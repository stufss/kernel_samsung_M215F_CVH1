#!/bin/bash
[ ! -e "KernelSU/kernel/setup.sh" ] && git submodule init && git submodule update
[ ! -d "toolchain" ] && echo  "installing toolchain..." && bash init_clang.sh
#echo "patching kernelsu...."
#bash scripts/ksu_patch_samsung.sh

export KBUILD_BUILD_USER=ghazzor

PATH=$PWD/toolchain/bin:$PATH
export LLVM_DIR=$PWD/toolchain/bin
export LLVM=1

export ARCH=arm64
export PLATFORM_VERSION=12
export ANDROID_MAJOR_VERSION=s

if [ -z "$DEVICE" ]; then
export DEVICE=m21
fi

if [[ -z "$KSU" || "$KSU" = "0" ]]; then
KSU=0
export KSUSTAT=
elif [ "$KSU" = "1" ]; then
CONFIG_KSU=ksu.config
export KSUSTAT=_KSU
else
echo "Error: Set KSU to 0 or 1 to build"
exit 1
fi
export KSU

if [[ -z "$OLD" || "$OLD" = "0" ]]; then
echo "NOT PATCHING tzdev!!"
export OLST=-
elif [ "$OLD" = "1" ]; then
echo "PATCHING tzdev!!"
export OLST=_OLD-
rm -rf drivers/misc/tzdev/startup.tzar
cp startup_old.tzar drivers/misc/tzdev/startup.tzar
git apply tzdev.patch
fi

if [[ -z "$1" || "$1" = "-c" ]]; then
echo "Clean Build"
rm -rf out
elif [ "$1" = "-d" ]; then
echo "Dirty Build"
else
echo "Error: Set $1 to -c or -d"
exit 1
fi

export TIME="$(date "+%Y%m%d")"

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

make ${ARGS} O=out ${DEVICE}_defconfig naz.config ${CONFIG_KSU}
make ${ARGS} O=out -j$(nproc)

echo "  Cleaning Stuff"
rm -rf AnyKernel3/Image
rm -rf AnyKernel3/config
echo "  done"
echo ""

[ ! -e "out/arch/arm64/boot/Image" ] && \
echo "  ERROR : image binary not found in any of the specified locations , fix compile!" && \
exit 1

echo "  Copying Stuff"
cp -r out/arch/arm64/boot/Image AnyKernel3/Image
cp -r out/.config AnyKernel3/config
echo "  done"
echo ""
kver=$(make kernelversion)
kmod=$(echo ${kver} | awk -F'.' '{print $3}')
echo "  Zipping Stuff"
cd AnyKernel3
rm -rf N_KERNEL.*.zip
zip -r1 N_KERNEL.${kmod}_${DEVICE}${KSUSTAT}${OLST}${TIME}.zip * -x .git README.md *placeholder
cd ..

if [[ -z "$AUTO" || "$AUTO" = "0" ]]; then
echo " ZIP Ready to Flash"
elif [ "$AUTO" = "1" ]; then
echo "make sure adb debugging is enaled and device has a custom recovery"
echo "flashing kernel , no need to reboot into recovery...."
bash flash.sh
else
echo "Error: Set AUTO to 0 or 1 to flash"
exit 1
fi
