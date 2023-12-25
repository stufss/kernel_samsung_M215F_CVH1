# Kernel Source For `SM-M215F` (Galaxy M21 2020)

**Based on [`Naz v1`](https://github.com/naz664/M215F-S/tree/Naz-old) , only For `CVH1` Stock** 

### Features

- `Anxiety` set as default i/o scheduler
- Compiled with `Prtotn CLang 12`
- LLVM Polly
- `Cortex-a73` Specfic Optmizations
- Inline Optmizations
- All features from `Naz-v1`
- `Devfreq Boost` is disabled
- Smooth UI
### **Build Instructions**

Build With `Proton Clang 12` and `Gcc 12.3` and `CC=clang`

```shell
bash init_clang_12.sh # Initiliaze Toolchains 
bash auto_workflow_clang.sh # Build
```

Is also Compatible With `Gcc 13` & `Gcc 14` with `CC=gcc`

`Clang 13` and above are not supported with `CC=clang` , they won't **boot**
Feel 
### **Credits** *(kanged everything from these guys)*

- **[`@naz664`](https://github.com/naz664)**
- **[`@LMAO-armv8`](https://github.com/LMAO-armv8)**
- **[`@TenSeventy7`](https://github.com/TenSeventy7)**
