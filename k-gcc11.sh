make clean && make distclean
export PATH=$HOME/android/toolchain/proton-clang/bin:$PATH
export LD_LIBRARY_PATH="$HOME/android/toolchain/proton-clang/lib:$LD_LIBRARY_PATH"
export CROSS_COMPILE=$HOME/android/toolchain/gcc-12/bin/aarch64-linux-gnu-
export CLANG_TRIPLE=aarch64-linux-gnu-
export CC=clang
export LD=ld.lld
export AR=llvm-ar
export NM=llvm-nm
export OBJCOPY=llvm-objcopy
export OBJDUMP=llvm-objdump
export READELF=llvm-readelf
export OBJSIZE=llvm-size
export STRIP=llvm-strip
export LLVM_AR=llvm-ar
export LLVM_DIS=llvm-dis



export ARCH=arm64
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s


make LD=ld.lld ARCH=arm64 KCFLAGS=-w CROSS_COMPILE=$HOME/android/toolchain/gcc-12/bin/aarch64-linux-gnu- CLANG_TRIPLE=$HOME/android/toolchain/proton-clang/bin/aarch64-linux-gnu- AR=llvm-ar NM=llvm-nm LLVM_NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf OBJSIZE=llvm-size STRIP=llvm-strip LLVM_AR=llvm-ar LLVM_DIS=llvm-dis CONFIG_SECTION_MISMATCH_WARN_ONLY=y exynos9610-m21dd_gcc_defconfig
make LD=ld.lld ARCH=arm64 KCFLAGS=-w CROSS_COMPILE=$HOME/android/toolchain/gcc-12/bin/aarch64-linux-gnu- CLANG_TRIPLE=$HOME/android/toolchain/proton-clang/bin/aarch64-linux-gnu- AR=llvm-ar NM=llvm-nm LLVM_NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf OBJSIZE=llvm-size STRIP=llvm-strip LLVM_AR=llvm-ar LLVM_DIS=llvm-dis CONFIG_SECTION_MISMATCH_WARN_ONLY=y -j$(nproc)

echo "Cleaning Stuff"
rm -rf AIK/Image
echo "done"
echo ""
echo "Copying Stuff"
cp -r arch/arm64/boot/Image AIK/Image
echo "done"
echo ""
kver=$(make kernelversion)
kmod=$(echo ${kver} | awk -F'.' '{print $3}')
echo "Zipping Stuff"
cd AIK
rm -rf STOCK_KERNEL.*.zip
zip -r1 STOCK_KERNEL.${kmod}_GCC_12_LATEST.zip * -x .git README.md *placeholder
cd ..
echo "Ready to Flash"
#export LDGOLD=$HOME/android/toolchain/google/sammy_clang_v8/gcc-cfp/gcc-cfp-jopp-only/aarch64-linux-android-4.9/bin/aarch64-linux-android-ld.gold
