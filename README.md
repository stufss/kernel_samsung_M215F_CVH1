### Kernel Source For `SM-M215F & SM-M315F` 

**Based on [`Naz v1`](https://github.com/naz664/M215F-S/tree/Naz-old) , only For `CVH1` Stock** 

`//not tested on other stock versions
   boots on M31 U2 , U3 is untested  //`


#### **Features**

- `Anxiety` set as default i/o scheduler
- Compiled with `Neutron Clang 18`
- LLVM Polly
- `Cortex-a73` Specfic Optmizations
- Inline Optmizations
- All features from `Naz-v1`
- `Devfreq Boost` is disabled
- Smooth UI
- Compiled with `O2` optmization level
- Some Debugging Disabled

#### **Build Instructions**

Build With `Neutron Clang 18`

```shell
bash init_clang.sh # Initiliaze Toolchains 
bash build.sh # Build
```

Is also Compatible With `Gcc 13` & `Gcc 14` with `CC=gcc`
 
### **Credits** *(kanged everything from these guys)*

- **[`@naz664`](https://github.com/naz664)**
- **[`@LMAO-armv8`](https://github.com/LMAO-armv8)**
- **[`@TenSeventy7`](https://github.com/TenSeventy7)**
