# Analog/Mixed-Signal/RF EDA

- SPICE & BSIM

## Spectre by Cadence: Kenneth S. Kundert @ UC Berkeley → Cadence 

- [Life After SPICE](https://ieeexplore.ieee.org/document/6051611)
- [Simulation of Nonlinear Circuits in the Frequency Domain](https://ieeexplore.ieee.org/document/1270223)
- [Steady-State Methods for Simulating Analog and Microwave Circuits](https://link.springer.com/book/10.1007/978-1-4757-2081-5)
- [The Designer’s Guide to Spice and Spectre®](https://link.springer.com/book/10.1007/b101824) 有许建超（西安交通大学）的电子译本
- [The Designer’s Guide to Verilog-AMS](https://link.springer.com/book/10.1007/b117108)
- [Introduction to RF simulation and its application](https://ieeexplore.ieee.org/document/782091)
- [Striving for small-signal stability](https://ieeexplore.ieee.org/document/900125)

## Spectre 仿真类型

### 背景

https://community.cadence.com/cadence_blogs_8/b/cic/posts/spectre-tech-tips-accuracy-101

### 万物的开山: `dc` simulation

modified nodal analysis

### `dc` 的衣钵: `tran` simulation

- 步长 (time step parameter)
  - Spectre 一般情况下会自动动态的设置 `tran` 仿真的步长：例如在信号变化幅度较大时缩小 step；当电路进入类似于稳态，没什么信号波动时增大 step
  - `step`:
  - `maxstep`: 本次 `tran` 所允许的最大步长。当我们不希望 spectre 在电路进入稳态后 step 越来越大，而一直小于一个最大 step 值
  - `minstep`: 
- param
  - tran noise
    - isnoisy


### 小信号的王者: `ac` simulation

### `ac` 的亲戚: `stb` simulation

Striving for small-signal stability - Loop-Based and Device-Based Algorithms for Stability Analysis of Linear Analog Circuits in the Frequency Domain

### `sp`

### Spectre 在模拟仿真领域超越 Hspice 的开端: `pss` simulation

### `hb` Harmonic Balance 谐波平衡法

#### 例一

##### 概念理解

一个最经典、最基础的非线性电路：**一个由正弦波驱动的二极管限幅电路**。

- 想象一个简单的串联电路：一个正弦信号源 $v_s(t) = V_{in}\cos(\omega t)$，一个线性电阻 $R$，一个非线性元件二极管 $D$。由于二极管的这种开关特性，流过电路的电流 $i(t)$ 不再是漂亮的正弦波了。它会被“削平”一部分，波形发生畸变。

- 这个畸变后的电流波形虽然不再是正弦波，但它仍然是一个**周期波**（周期和输入信号一样）。根据傅里叶分析，任何周期波都可以分解为基波（$\omega$）和一系列谐波（$2\omega, 3\omega, 4\omega, \dots$）的叠加。我们想知道，这个畸变电流中，每个谐波分量的幅度和相位是多少？

**Harmonic Balance Method 就是为解决这个问题而生的。**

它的思路是：

1.  **猜测**：我们假设电路中所有地方的电压和电流（比如二极管两端的电压 $v_D(t)$）都可以写成傅里叶级数的形式（包含直流、基波、二次谐波……）。
2.  **“平衡”**：电路必须始终遵守基尔霍夫定律（KVL 和 KCL）。谐波平衡法的核心就是要求**基尔霍夫定律在每一个谐波频率上都必须单独成立**。
3.  **求解**：通过让每个谐波分量都“平衡”，我们把一个包含非线性元件的**电路微分方程**问题，转换成了一组关于各谐波分量（的幅度和相位）的**非线性代数方程组**。

可以列写 KVL
$$
v_s(t) = i(t)R + v_D(t)
$$

二极管的非线性特性由**肖克利二极管方程**描述：

$$
i(t) = I_S \left( e^{v_D(t) / (nV_T)} - 1 \right)
$$

这是一个超越方程，很难直接求解 $v_D(t)$ 或 $i(t)$。

**应用谐波平衡法步骤：**

**Step 1: 假设解的形式**

假设非线性元件（二极管）两端的电压 $v_D(t)$ 是我们要求的解。我们做一个简单的近似，只考虑直流和基波分量：
$$
v_D(t) \approx V_0 + V_1\cos(\omega t)
$$

*   $V_0$ 是二极管上的直流偏置电压（即使输入没有直流，非线性效应也会产生它，这叫“自偏置”）
*   $V_1$ 是二极管上基波电压的幅度
*   $V_0$ 和 $V_1$ 是我们要求解的未知数

**Step 2: 将所有信号在频域中表示**

将 KVL 方程 $v_s(t) - i(t)R - v_D(t) = 0$ 转换到频域。我们需要每个信号在直流（$k=0$）、基波（$k=1$）等频率上的分量。

| 谐波 Harmonics                                  | 直流 ($k=0$)                                                 | 基波 ($k=1$)                                                 | 高次谐波 ($k>1$) |
| ----------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------- |
| $v_s(t)$ 已知                                   | $V_{s,0} = 0$                                                | $V_{s,1} = V_{in}$                                           | $V_{s,k} = 0$    |
| $v_D(t)$ 假设                                   | $V_{D,0} = V_0$                                              | $V_{D,1} = V_1$                                              | $V_{D,k} = 0$    |
| $i(t) = f(v_D(t)) = f(V_0 + V_1\cos(\omega t))$ | $I_0(V_0,V_1) = \frac{1}{T} \int_0^T f(V_0 + V_1\cos(\omega t)) dt$ | $I_1(V_0,V_1) = \frac{2}{T} \int_0^T f(V_0 + V_1\cos(\omega t)) \cos(\omega t) dt$ | $I_k=0$          |

其中 $i(t)$ 的直流、基波是通过傅里叶级数算出的：
$$
f(t) = \frac{a_0}{2} + \sum_{k=1}^{\infty} \left( a_k\cos(k\omega_0 t) + b_k\sin(k\omega_0 t) \right) \\
a_0 = \frac{2}{T} \int_{0}^{T} f(t) \,dt \\
a_k = \frac{2}{T} \int_{0}^{T} f(t) \cos(n\omega_0 t) \, dt 
$$
$I_0$ 和 $I_1$ 都是未知数 $V_0$ 和 $V_1$ 的**复杂非线性函数**

**Step 3: 平衡谐波 (Harmonic Balance)**

现在，我们要求 KVL 方程在每个谐波上都成立：

* **直流平衡 ($k=0$)**:
  $$
  V_{s,0} - I_0 R - V_{D,0} = 0 \implies 0 - I_0(V_0, V_1)R - V_0 = 0
  $$

* **基波平衡 ($k=1$)**:
  $$
  V_{s,1} - I_1 R - V_{D,1} = 0 \implies V_{in} - I_1(V_0, V_1)R - V_1 = 0
  $$

**Step 4: 求解**

我们得到了一个包含两个未知数 ($V_0, V_1$) 的两个**非线性代数方程组**：
$$
\begin{cases}
V_0 + I_0(V_0, V_1)R = 0 \\
V_1 + I_1(V_0, V_1)R = V_{in}
\end{cases}
$$

这个方程组虽然不能手算（因为积分 $I_0, I_1$ 很复杂），但可以用计算机数值求解。一旦求出了 $V_0$ 和 $V_1$，我们就知道了二极管上的电压，进而可以计算出电流的各个谐波分量，完成分析

##### 计算机实现

#### 例二


考虑一个一阶 RC 低通系统，其中 R 时不变，$C=C_a+C_b\cos\omega_1t$ 时变，输入信号是。在时域求解可以列出：

$$
\frac{V_{in}(t) - V_{out}(t)}{R}
= I_R(t)
= I_C(t)
= \frac{\mathrm{d}Q(t)}{\mathrm{d}t}
= \frac{\mathrm{d}}{\mathrm{d}t}\!\bigl[C(t)\,V_{out}(t)\bigr]
= \frac{\mathrm{d}C(t)}{\mathrm{d}t}V_{out}(t) + C(t)\frac{\mathrm{d}V_{out}(t)}{\mathrm{d}t}
\quad C(t) = C_a + C_b\cos(\omega_1 t)
$$



## MATLAB & Simulink

- Mathworks 官方课程 / 功能介绍视频
  - 免费
    - [Simulink Onramp](https://matlabacademy.mathworks.com/details/simulink-onramp/simulink)
    - [Mixed-Signal Blockset](https://www.mathworks.com/products/mixed-signal.html)
      - [Mixed-Signal Data Analysis with MATLAB](https://www.mathworks.com/videos/series/mixed-signal-data-analysis-with-matlab.html)
      - [Understanding Phase Locked Loop with Mixed-Signal Blockset](https://www.mathworks.com/videos/pll-loop-parameter-estimation-68728.html)
      - ...
  - 付费
    - [Simulink for Analog Mixed-Signal Design](https://www.mathworks.com/learn/training/simulink-for-analog-mixed-signal-design.html)



## EDA List

| Full Custom (Analog)                  | Cadence                                         | Synopsys                                    | [Siemens](https://www.sw.siemens.com/en-US/technology/electronic-design-automation-eda/) (Mentor) | Keysight                         | Empyrean 华大九天 |
| ------------------------------------- | ----------------------------------------------- | ------------------------------------------- | ------------------------------------------------------------ | -------------------------------- | ----------------- |
| Solution                              | **Virtuoso Studio**                             | Custom Compiler                             | Tanner (*Tanner*)                                            | Advanced Design System (ADS)     | Aether            |
| Platform (Environment)                | **Virtuoso Analog Design Environment (ADE)**    | PrimeWave Design Environment                | Solido Design Environment (*Solido*)                         |                                  |                   |
|                                       |                                                 |                                             |                                                              |                                  |                   |
| Third-latest SPICE                    | **Spectre** (Classic)                           | **HSPICE** *(Meta-Software)*                | Eldo, Solido SPICE                                           |                                  |                   |
| Second-latest SPICE                   | **Spectre APS**                                 | ~~FineSim SPICE?  (*Magma*)~~               |                                                              |                                  | ALPS              |
| Latest SPICE (GPU)                    | **Spectre X**                                   | PrimeSim SPICE                              |                                                              |                                  | **ALPS GT**       |
| Second-latest FastSPICE               | ~~**Spectre XPS**~~                             | ~~CustomSim / FineSim FastSPICE (*Magma*)~~ | Analog FastSPICE (AFS) (*Berkeley Design Automation*)        |                                  |                   |
| Latest FastSPICE                      | **Spectre FX**                                  | PrimeSim XA / PrimeSim Pro                  | AFS eXTreme (AFS XT), Solido FastSPICE                       |                                  |                   |
| RF SPICE (RF FastSPICE)               | **Spectre RF**                                  | PrimeSim SPICE                              | AFS RF                                                       |                                  | ALPS RF           |
| AMS Simulation                        | Spectre AMS + Xcelium                           | VCS AMS                                     | Symphony, Questa ADMS                                        |                                  |                   |
| RC Extraction (2D EM Simulation)      | Quantus                                         | StarRC                                      | Calibre xRC                                                  |                                  |                   |
| 2.5D EM Simulation (Planar 3D)        | **EMX** (*Integrand*)                           | RaptorH (RaptorX) (*Ansys*)                 | Calibre xACT 3D                                              | RFPro\*, **ChannelSim (SerDes)** |                   |
| 3D EM Simulation (Full-Wave 3D)       | Clarity (for packaging)                         | **HFSS** (*Ansys*)                          | HLAS (for packaging)                                         | **EMPro**                        |                   |
|                                       |                                                 |                                             |                                                              |                                  |                   |
| Schematic / Layout Editor             | Virtuoso Schematic Editor XL / Layout Suite MXL |                                             | Tanner S-Edit / L-Edit                                       |                                  | Aether SE / LE    |
| Layout Automation                     | **Animate** (*Pulsic*)                          |                                             |                                                              |                                  |                   |
| Viewer                                | Virtuoso Visualization & Analysis (ViVA) XL     | Custom WaveView                             | Swave                                                        |                                  | iWave             |
| Cell                                  | Spectre Characterization Simulator              | PrimeLib                                    | Solido Variation Designer                                    |                                  |                   |
|                                       |                                                 |                                             |                                                              |                                  |                   |
| Physical Verification (DRC, ERC, LVS) | Assura / Pegasus                                | IC Validator                                | **Calibre**                                                  |                                  |                   |

> \* FEM + Momentum 方法
>
> Planar 3D: 矩量法 (MoM - Method of Moments)
>
> Full-Wave 3D: 有限元法 (FEM - Finite Element Method) + 时域有限差分法 (FDTD - Finite Difference Time Domain)
>
> https://zhuanlan.zhihu.com/p/28550045
