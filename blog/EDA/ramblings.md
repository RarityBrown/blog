# Ramblings

## 数值计算

编写一个计算器远没有想象的那么简单啊。Windows 计算器都有一堆数值问题 [#222 ms/calculator](https://github.com/microsoft/calculator/issues/222)。

## `1290111812442216 / 716728784960.12` 产生的问题

灵感来源：[zhihu](https://www.zhihu.com/question/1494578413/answer/12187421405)

我们假设读者对于 IEEE 浮点标准有基本的了解。例如，因为浮点误差 `0.1 + 0.2 == 0.3` 会返回 `false`。

`1290111812442216 / 716728784960.12 = 1800`，但几乎所有平台都会计算成 `1799.9999993219...` 从而产生了惊人的 `3.767e-10` 相对误差。为什么这里用**惊人**这个词来形容呢？主要有三个原因：

1. IEEE 764 double precision 的最大舍入（相对）误差只有 [2<sup>−53</sup> ≈ 1.11e-16](https://en.wikipedia.org/wiki/Machine_epsilon)，相比 `1799.9999993219...` 的相对误差小了 6 个数量级
2. [NASA](https://www.jpl.nasa.gov/edu/news/how-many-decimals-of-pi-do-we-really-need/) 在“最高精度的计算”中使用 π 小数点后 15 位，这和双精度浮点的有效位数也是[相关的](https://www.zhihu.com/question/267550954)。这意味着 `1e-10` 量级的相对误差对于少部分应用来说是不可忽视的，是很大的一个值。
3. 几乎所有平台的编程语言、计算器和数学工具，因为误差已经足够大，以至于软件认为这不是浮点计算误差，而直接把 `1799.9999993219...` 作为结果显示了出来，而不是像 `0.1 + 0.2 = 0.3(0000000000000004)` 这样直接省略了浮点误差。

不过，在上个世纪曾出现过 Pentium X87 FPU `FDIV` 指令[错误](https://en.wikipedia.org/wiki/Pentium_FDIV_bug)，其误差还是远大于 `1e-10` 这个量级的

| src                                                          |                                      | 真值    | 典型值 (相对误差)                                           | Windows | iOS  | MATLAB <br />(numerical) | Python | C    |
| ------------------------------------------------------------ | ------------------------------------ | ------- | ----------------------------------------------------------- | ------- | ---- | ------------------------ | ------ | ---- |
|                                                              | float 64 最大误差                    |         | ([1.11e-16](https://en.wikipedia.org/wiki/Machine_epsilon)) |         |      |                          |        |      |
|                                                              | `0.3`                                | `0.3`   | `0.299999999999999988897...` (`3.7007e-17`)                 |         |      |                          |        |      |
|                                                              | `0.123`                              |         |                                                             |         |      |                          |        |      |
| [zhihu](https://www.zhihu.com/question/1494578413/answer/12187421405) | `1290111812442216 / 716728784960.12` | `1800`  | `1799.9999993219` (`3.767e-10`)                             | N       | N    | N                        | N      |      |
| [#222 ms/calculator](https://github.com/microsoft/calculator/issues/222) | `sqrt(2.25)-1.5+1e-47`               | `1e-47` |                                                             | N       | Y    | Y                        |        |      |

假设有一理想 64-bit 浮点除法器计算 `1290111812442216 / 716728784960.12 = 1800` 会产生 $\frac{1290111812442216(1 + \Delta)}{716728784960.12(1 - \Delta)}-1800=2\Delta$ 的绝对误差。相对误差小于 $\Delta$，所以在双精度下，这一结果可视为 $1800(1+\Delta)$ 的 64-bit 浮点。其中 $\Delta$ 是 IEEE 764 double precision 的最大舍入（相对）误差。

下面一层层抽丝剥茧：

### 除法算法

- https://en.wikipedia.org/wiki/Division_algorithm

### 浮点实现与浮点**运算**误差 (不是浮点误差)

- https://en.wikipedia.org/wiki/Floating-point_arithmetic#Accuracy_problems
- https://en.wikipedia.org/wiki/Floating-point_error_mitigation
- https://digitalsystemdesign.in/floating-point-division/
- https://jvns.ca/blog/2023/01/13/examples-of-floating-point-problems/
- http://www.indowsway.com/floatingpoint.htm
- https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html
- https://docs.python.org/3/tutorial/floatingpoint.html
- https://jonisalonen.com/2013/deriving-welfords-method-for-computing-variance/
- https://floating-point-gui.de/

众所周知，财务系统要使用十进制或者 int 来计算，浮点误差和浮点运算误差都有影响。另一个小众但是直观的错误则是部分里程表中众多浮点加法导致的误差。

### 从 C 到 Assembly

在现代 CPU 上，有两种主流的方式可以实现浮点除法：一种是基于 X87 FPU 的 `FDIV` 命令，另一种是基于 SSE2 指令集的 `DIVSD`:

```c
#include <stdio.h>
#include <quadmath.h>
int main() {
    double dividend_d = 1290111812442216.0;
    double divisor_d = 716728784960.12;
    double result_double = dividend_d / divisor_d;

    long double dividend_l = 1290111812442216.0L;
    long double divisor_l = 716728784960.12L;
    long double result_long_double = dividend_l / divisor_l;

    __float128 dividend_128 = 1290111812442216.0Q;
    __float128 divisor_128 = 716728784960.12Q;
    __float128 result_128 = dividend_128 / divisor_128;
    return 0;
}
```

在使用现代 CPU 和现代编译器 (例如 GCC) 时：

| C             | GCC 参数    | 汇编       | 指令集              | 精度     |
| ------------- | ----------- | ---------- | ------------------- | -------- |
| `long double` | 无          | `FDIV`     | x87                 | 80 bits  |
| `double`      | `-mno-sse2` | `FDIV`     | x87                 | 64 bits  |
| `double`      | 无          | `DIVSD`    | SSE2                | 64 bits  |
| `double`      | `-mavx`     | `VDIVSD`   | AVX                 | 64 bits  |
| `__float128`  | 无          | `__divtf3` | GCC `quadmath` 模拟 | 128 bits |

### Microarchitecture 

Intel 微架构

- **Codename**: Intel 的 Coffee Lake 这类名称并不是 Intel 的微架构名称，只是商品名的 codename，比如 Coffee Lake 对应的是 Intel Core 8/9 代产品。所以 Coffee Lake 这类名称不能称之为微架构，而是使用 codename 或 “架构” 的称呼。
  - Intel 的产品从 2015 后开始使用 xxx + whitespace + Lake 作为消费端产品的 codename 
- **Microarchitecture**: Lion Cove, Skymont 这类名称才是 Intel 的微架构名称。例如 Lion Cove 是 Arrow Lake (Intel Ultra Series 2) CPU 的大核微架构，Skymont 是 Arrow Lake 的小核微架构。但是 Lion Cove 的大核也可以用于 Lunar Lake (Intel Ultra 200V) 这一系列 CPU
  - Skylake 是一个特殊的情况，因为其中间**没有**空格，所以 Skylake 是一种**微架构**，作为 Cooper Lake, Comet Lake 等一系列产品的 codename。同时，Skylake 于 2015 年提出，正处于 Intel 开始使用 xxx + whitespace + Lake 作为产品代号的第一年。所以 Sky{没有空格}lake 也是 Intel Core 6 的codename 


| Source | Microarchitecture (Architecture)          | Instruction       | Latency | Throughput (CPI) |
| ------ | ----------------------------------------- | ----------------- | ------- | ---------------- |
| agner  | Zen 3, Zen 4                              | `FDIV`            | 15      | 6                |
| agner  | Zen 3                                     | `DIVSD`           | 13.5    | 4.5              |
| agner  | Zen 4                                     | `DIVSD`           | 13      | 5                |
|        |                                           |                   |         |                  |
| agner  | Skylake (Skylake, ... , Cooper Lake)      | `FDIV`            | 14~16   | 4~5              |
| agner  | Skylake (Skylake, ... , Cooper Lake)      | `DIVSD`           | 13~14   | 4                |
| intel  | Skylake (Skylake, ... , Cooper Lake)      | `DIVSD`, `VDIVSD` | 14      | 4                |
|        |                                           |                   |         |                  |
| agner  | Sunny Cove (Ice Lake)                     | `FDIV`            | 14~16   | 4~5              |
| agner  | Sunny Cove (Ice Lake)                     | `DIVSD`           | 13~14   | 4                |
| intel  | Sunny Cove (Ice Lake)                     | `VDIVSD`          | 13      | -                |
|        |                                           |                   |         |                  |
| intel  | Golden Cove (Alder Lake, Sapphire Rapids) | `DIVSD`, `VDIVSD` | 14      | 4                |

> Source:
>
> 1. [agner instruction_tables](https://www.agner.org/optimize/instruction_tables.pdf)
> 2. *Intel 64 and IA-32 Architectures Optimization Reference Manual*
> 3. [Intel Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)

所以从表中可以发现，SSE 指令集的 FPU 和 X87 指令集的 FPU 可能不是同一种 FPU？

- https://www.plantation-productions.com/Webster/www.artofasm.com/DOS/ch14/CH14-3.html


### 输出结果


例如在 Intel, AMD 的 CPU 上，在 Windows 或 Linux 中时，以下代码的输出结果都是一致的：

```c
#include <stdio.h>
int main() {
    double dividend_d = 1290111812442216.0;
    double divisor_d = 716728784960.12;
    double result_double = dividend_d / divisor_d;
    double res_double = 1800.0;
    printf("Using double (SSE2):\n");
    printf("Dividend: %.48f\n", dividend_d);
    printf("Divisor:  %.52f\n", divisor_d);
    printf("Result:   %.60f\n", result_double);
    printf("1800:     %.60f\n", res_double);
    printf("\n");

    long double dividend_l = 1290111812442216.0L;
    long double divisor_l = 716728784960.12L;
    long double result_long_double = dividend_l / divisor_l;
    long double res_long_double = 1800.0L;
    printf("Using long double (x87):\n");
    printf("Dividend: %.48Lf\n", dividend_l);
    printf("Divisor:  %.52Lf\n", divisor_l);
    printf("Result:   %.60Lf\n", result_long_double);
    printf("Result:   %.60Lf\n", res_long_double);
    return 0;
}

Using double (SSE2):
Dividend: 1290111812442216.000000000000000000000000000000000000000000000000
Divisor:  716728784960.1199951171875000000000000000000000000000000000000000
Result:   1799.999999321919176509254612028598785400390625000000000000000000
1800:     1800.000000000000000000000000000000000000000000000000000000000000

Using long double (x87):
Dividend: 1290111812442216.000000000000000000000000000000000000000000000000
Divisor:  716728784960.1200000047683715820312500000000000000000000000000000
Result:   1799.999999321919238903788595962396357208490371704101562500000000
Result:   1800.000000000000000000000000000000000000000000000000000000000000
```

同时，符号和数值计算软件也纷纷给出了不精确的结果：

具体还有再研究一下(比如 decimal 库)。再说

```matlab
%%%%%%%%% Symbolic
numerator = sym(1290111812442216)
denominator0 = sym(716728784960.12)
denominator1 = sym(71672878496012) / sym(100)
result0 = numerator / denominator0
result1 = numerator / denominator1
simplified_result0 = simplify(result0, 'Steps', 10000, 'IgnoreAnalyticConstraints', true)
simplified_result1 = simplify(result1, 'Steps', 10000, 'IgnoreAnalyticConstraints', true)

%%%%%%%% Numerical 1
digits(100);  % 设置有效位数
result_n0 = vpa(numerator / denominator0)
result_n1 = vpa(numerator / denominator1)

%%%%%%%% Numerical 2
format longG;
numerator = 1290111812442216;
denominator = 716728784960.12;
result = numerator / denominator
```

```mathematica
%%%%%%%%% Symbolic
N[1290111812442216 / SetPrecision[716728784960.12, Infinity], Infinity]

%%%%%%%% Numerical 1
NumberForm[N[1290111812442216 / SetPrecision[716728784960.12, Infinity], 1024], 64]
```


```python

```

输出结果对比：

```
1800.000000000000000000000000000000000000000000000000000000000000
1799.999999321919251173957854121732089838160693269094554867732152  mathematica
1799.999999321919238903788595962396357208490371704101562500000000  C (80 bits FDIV)
1799.999999321919176509254612028598785400390625000000000000000000  C (64 bits)
```

### Assembly

使用 80 bits 的

其中 `long double result_long_double = dividend_l / divisor_l;` 使用 x86-64 GCC 14.2 编译得到

```assembly
main:
        push    rbp
        mov     rbp, rsp
        fld     TBYTE PTR .LC0[rip]
        fstp    TBYTE PTR [rbp-16]
        fld     TBYTE PTR .LC1[rip]
        fstp    TBYTE PTR [rbp-32]
        fld     TBYTE PTR [rbp-16]
        fld     TBYTE PTR [rbp-32]
        fdivp   st(1), st
        fstp    TBYTE PTR [rbp-48]
        mov     eax, 0
        pop     rbp
        ret
.LC0:
        .long   -1559429120    # 0xA3 0D 00 00    0b1010 0011 0000 1101 0000 0000 0000 0000 (low 32 bits of significand)
        .long   -1834274295    # 0x92 AB 32 09    0b1001 0010 1010 1011 0011 0010 0000 1001 (high 32 bits of significand)
        .long   16433          # 0x00 00 40 31    0b0000 0000 0000 0000 0100 0000 0011 0001 (exponent and sign)
        .long   0              # padding
.LC1:
        .long   1075755008
        .long   -1495245480
        .long   16422
        .long   0
```


80 bits 的 Extended precision 和 64 bits 的 double precision 对比如下：

![64](https://upload.wikimedia.org/wikipedia/commons/a/a9/IEEE_754_Double_Floating_Point_Format.svg)

![80](https://upload.wikimedia.org/wikipedia/commons/e/e1/X86_Extended_Floating_Point_Format.svg)

- 64 bits significand: `0x92 AB 32 09 A3 0D 00 00`
  - 注意大小端
  - decimal: 10,568,595,967,526,633,472
- 15 bits exponent: $16433-(2^{14}-1)=50$ (decimal)
- 1 bit sign: positive

最终结果 $10,568,595,967,526,633,472\times 2^{50-63}=1,290,111,812,442,216$






## Cracking

https://github.com/BinaryHackerLab



