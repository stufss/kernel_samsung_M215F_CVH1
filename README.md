### Kernel Source For `M21/M31/M31s/F41`

**Based on [`Naz v1`](https://github.com/naz664/M215F-S/tree/Naz-old)** 

#### **Features**

- Compiled with `Neutron Clang 18`
- LLVM Polly
- Inline Optmizations
- All features from `Naz-v1`
- `Devfreq Boost` is disabled
- Compiled with `O2` optmization level
- Debugging Nuked
- thinLTO enabled
- Binderfs , Incfs etc

#### **Build Instructions**

```shell
# Dependencies for ubuntu
$ sudo apt install bash git make libssl-dev curl bc pkg-config m4 libtool automake autoconf zstd libarchive-tools wget

# Clean build for m21, ksu and for cwb1 and above
$ KSU=1 OLD=0 ./build.sh -c

# Dirty build for m31 , no ksu and for older u2/u3 stock
$ DEVICE=m31 KSU=0 OLD=1 ./build.sh -d
```
Toolchain is synced automatically

Flashable zip is localted in Anykernel3/N_KERNEL*.zip

### **Note**
1. F41 uses older tee, so only build with `OLD=1`.
2. By default the script builds with `OLD=0` which uses the new tzdev, might not boot for you.
3. AVB needs to be disabled to boot these kernels i.e. nuked from vendor and boot fstabs.

### **Credits** *(kanged everything from these guys)*

- **[`@naz664`](https://github.com/naz664)** (base tree)
- **[`@LMAO-armv8`](https://github.com/LMAO-armv8)** (upstreamed kernel)
- **[`@TenSeventy7`](https://github.com/TenSeventy7)** (vdso32, minor optimizations)
- **[`@Royna2544`](https://github.com/Royna2544)** (incfs, binderfs, lto fixes)
