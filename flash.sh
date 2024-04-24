set -e
adb reboot recovery

sleep 46

adb push AnyKernel3/N_KERNEL.*zip /tmp/kernel.zip
adb shell twrp install /tmp/kernel.zip
adb shell twrp reboot system
