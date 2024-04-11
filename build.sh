PATH=$PWD/toolchain/bin:$PATH
export LLVM_DIR=$PWD/toolchain/bin
export LLVM=1

export ARCH=arm64
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s

if [ -z "$DEVICE" ]; then
export DEVICE=m21
fi

ARGS='
CC=clang
LD='${LLVM_DIR}/ld.lld'
ARCH=arm64
AR='${LLVM_DIR}/llvm-ar'
NM='${LLVM_DIR}/llvm-nm'
AS='${LLVM_DIR}/llvm-as'
OBJCOPY='${LLVM_DIR}/llvm-objcopy'
OBJDUMP='${LLVM_DIR}/llvm-objdump'
READELF='${LLVM_DIR}/llvm-readelf'
OBJSIZE='${LLVM_DIR}/llvm-size'
STRIP='${LLVM_DIR}/llvm-strip'
LLVM_AR='${LLVM_DIR}/llvm-ar'
LLVM_DIS='${LLVM_DIR}/llvm-dis'
LLVM_NM='${LLVM_DIR}/llvm-nm'
LLVM=1
'

make distclean
clear
make ${ARGS} KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y ${DEVICE}_defconfig naz.config
make ${ARGS} KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y -j$(nproc)

echo "  Cleaning Stuff"
rm -rf AIK/Image
rm -rf config
echo "  done"
echo ""
echo "  Copying Stuff"

# Define potential locations for the image binary
locations=(
  "$PWD/arch/arm64/boot"
  "$PWD/out/arch/arm64/boot"
)

# Check each location sequentially
found=false
for location in "${locations[@]}"; do
  if test -f "$location/Image"; then
    found=true
    break # Stop iterating after finding the binary
  fi
done

# Handle the case where image binary wasn't found
if ! $found; then
  echo "  ERROR : image binary not found in any of the specified locations!"
  exit 1
fi

cp -r arch/arm64/boot/Image AIK/Image
cp -r .config AIK/config
echo "  done"
echo ""
kver=$(make kernelversion)
kmod=$(echo ${kver} | awk -F'.' '{print $3}')
echo "  Zipping Stuff"
cd AIK
rm -rf N_KERNEL.*.zip
zip -r1 N_KERNEL.${kmod}_${DEVICE}.zip * -x .git README.md *placeholder
cd ..
echo "  Ready to Flash"
