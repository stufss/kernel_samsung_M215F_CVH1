export LD_LIBRARY_PATH="$PWD/toolchain/lib:$LD_LIBRARY_PATH"
export CROSS_COMPILE='$PWD/toolchain/bin/aarch64-linux-gnu-'
export CROSS_COMPILE_ARM32='$PWD/toolchain/bin/arm-linux-gnueabi-'
export LLVM=1

export ARCH=arm64
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s

if [ -z "$DEVICE" ]; then
export DEVICE=m21
fi

ARGS='
CC=clang
LD=ld.lld
ARCH=arm64
LLVM=1
CROSS_COMPILE='$PWD/toolchain/bin/aarch64-linux-gnu-'
CROSS_COMPILE_ARM32='$PWD/toolchain/bin/arm-linux-gnueabi-'
CLANG_TRIPLE='$PWD/toolchain/bin/aarch64-linux-gnu-'
'

clear
make clean && make distclean
make ${ARGS} KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y ${DEVICE}_defconfig naz.config
make ${ARGS} KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y -j$(nproc)


echo "Cleaning Stuff"
rm -rf AIK/Image
rm -rf config
echo "done"
echo ""
echo "Copying Stuff"
cp -r arch/arm64/boot/Image AIK/Image
cp -r .config AIK/config
echo "done"
echo ""
kver=$(make kernelversion)
kmod=$(echo ${kver} | awk -F'.' '{print $3}')
echo "Zipping Stuff"
cd AIK
rm -rf N_KERNEL.*.zip
zip -r1 N_KERNEL.${kmod}_CLANG_18_${DEVICE}.zip * -x .git README.md *placeholder
cd ..
echo "Ready to Flash"
