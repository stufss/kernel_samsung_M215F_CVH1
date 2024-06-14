### Kernel Source For `SM-M215F & SM-M315F`

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

### **Credits** *(kanged everything from these guys)*

- **[`@naz664`](https://github.com/naz664)**
- **[`@LMAO-armv8`](https://github.com/LMAO-armv8)**
- **[`@TenSeventy7`](https://github.com/TenSeventy7)**
- **[`@Royna2544`](https://github.com/Royna2544)**
