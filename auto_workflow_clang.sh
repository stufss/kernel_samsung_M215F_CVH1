export LLVM=1
export ARCH=arm64
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s

if [ -z "$DEVICE" ]; then
export DEVICE=m21
fi

ARGS='CC=clang LD=ld.lld ARCH=arm64 AS='$PWD/toolchain/llvm-as' AR='$PWD/toolchain/llvm-ar' OBJDUMP='$PWD/toolchain/llvm-objdump' READELF='$PWD/toolchain/llvm-readelf' CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- CLANG_TRIPLE=aarch64-linux-gnu-'

clear
make clean && make distclean
make ${ARGS} LLVM=1 KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y ${DEVICE}_defconfig naz.config
make ${ARGS} LLVM=1 KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y -j$(nproc)


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
