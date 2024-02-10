export LD_LIBRARY_PATH="$PWD/toolchain/proton-clang/lib:$LD_LIBRARY_PATH"
export CROSS_COMPILE='$PWD/toolchain/proton-clang/bin/aarch64-linux-gnu-'
export CROSS_COMPILE_ARM32='$PWD/toolchain/proton-clang/bin/arm-linux-gnueabi-'
export LLVM=1

export ARCH=arm64
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s

ARGS='
CC=clang
LD=ld.lld
ARCH=arm64
LLVM=1
CROSS_COMPILE='$PWD/toolchain/proton-clang/bin/aarch64-linux-gnu-'
CROSS_COMPILE_ARM32='$PWD/toolchain/proton-clang/bin/arm-linux-gnueabi-'
CLANG_TRIPLE='$PWD/toolchain/proton-clang/bin/aarch64-linux-gnu-'
'
clear
make clean && make distclean
make ${ARGS} KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y exynos9610-m21dd_defconfig
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
zip -r1 N_KERNEL.${kmod}_PROTON_CLANG_12_LATEST.zip * -x .git README.md *placeholder
cd ..
echo "Ready to Flash"
#export LDGOLD=$HOME/android/toolchain/google/sammy_clang_v8/gcc-cfp/gcc-cfp-jopp-only/aarch64-linux-android-4.9/bin/aarch64-linux-android-ld.gold
