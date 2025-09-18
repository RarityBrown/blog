# Sampling

# Sample and Hold, Track and Hold

## Basic Concept

todo

## Distortion in the Passive FET Sample-and-Hold Circuit

> ref:
>
> Analog-to Digital Conversion, Fourth Edition, Marcel J.M. Pelgrom, 978-3-030-90808-9
>
> [Comprehensive Analysis of Distortion in the Passive FET Sample-and-Hold Circuit](https://ieeexplore.ieee.org/abstract/document/8307227), Tetsuya Iizuka & Asad A. Abidi, TCAS-I, 2018

### (nonlinear) $v_{in}(t)$-dependent resistance     (Modulation of FET $R_{on}$ by $v_{in}(t)$)

#### Simple Model by Marcel

Marcel 使用

1. MOSFET 平方律; 
2. $R_{ON}=kV_{in}+R_0$ 线性化（一阶 Maclaurin 展开）

进行分析

直接线性假设，即单位变化的 $V_{in}$ 会线性地导致 $R_{ON}$ 的变化

$$
\begin{aligned}
R_{ON}(V_{in}) 
&= \underbrace{R_{ON}(V_{in}=0) + \dv{R_{ON}}{V_{in}}\bigg|_{V_{in}=0} \cdot V_{in}}_{\text{first order}} + \cancel{\underbrace{\frac{1}{2}\cdot\dv[2]{R_{ON}}{V_{in}}\bigg|_{V_{in}=0} \cdot V_{in}^2}_{\text{second order}}} + \dots \\
&= R_0+\frac{V_{in}}{V_{in,pp}}\Delta R
\end{aligned}
$$

- 对于典型的 $f_{in}=100\mathrm{MHz}$ 和 $C_H=1\mathrm{pF}$ 有容抗 $X_C=\frac{1}{2\pi fC}\approx1.6\mathrm{k\Omega}\gg R_{ON}$; 或者说，我们认为开关往往开得非常好，使得近似 $V_{in}=V_{C_H}$
  - 所以对于输入信号 $V_{in}(t)=0.5V_{in,pp}\sin(\omega t)$ 的电压全部落在 $C_H$ 上，产生电流 $I(t)=\omega C0.5V_{in,pp}\cos(\omega t)$
  - 在 $R_{ON}$ 上产生的压降是 $V_R(t)=R_{ON}(V_{in})\times I(t)=\left( R_0+\dfrac{0.5V_{in,pp}\sin(\omega t)}{V_{in,pp}}\Delta R \right) (\omega C0.5V_{in,pp}\cos(\omega t))$
  - 其中第一项是线性的压降，第二项 $V_{R,2nd}(t) = \left( \dfrac{0.5V_{in,pp}\sin(\omega t)}{V_{in,pp}}\Delta R \right) (\omega C0.5V_{in,pp}\cos(\omega t))=\dfrac{\omega\Delta R CV_{in,pp}\sin(2\omega t)}{8}$

所以有

$$
\boxed{\text{HD2} = \frac{V_{R,2nd\text{ rms}}}{V_{in\text{ rms}}} = \frac{\omega\cdot \Delta\!R\cdot C}{4}}
$$

> [!NOTE]
>
> 平方律的 MOSFET 模型，有：
> 
> $$
> I_{D}=\mu_{n}C_{ox}\dfrac{W}{L}\left( (V_{GS}-V_{TH})V_{DS}-\frac{1}{2}V_{DS}^2 \right) \\
> R_{ON}(V_{in}(t))|_{V_{DS}\sim 0}
> =\frac{1}{\pdv{I_D}{V_{DS}}}
> =\frac{1}{\mu_nC_{ox}\frac{W}{L}(V_{GS}-V_{TH}-V_{DS})}
> =\frac{1}{\mu_nC_{ox}\frac{W}{L}(V_{DD}-V_{in}-V_{TH})}
> $$
> 
> 对于低电源电压的设计，要注意 MOSFET 开关是否能导通。
>
> At low supply voltages and large-signal excursions, the voltage-dependent resistance of the switch can lead to aperture time differences causing distortion. 


#### Taylor Series Model by Iizuka (HD, Single-tone)

首先，我们不给证明的给出（证明稍后给出）：

$$
R_{ON}(V_{in}) = \frac{1}{\mu_n C_{ox}\frac{W}{L}(V_{DD}-nV_{in}(t)-V_{TH})}
$$

> where n (> 1) is called the body effect or slope factor
>
> 详见 [MOSFET Modeling in Advanced Planar Nodes for Analog Design](modeling.md) 相关内容

类似地，

$$
\begin{aligned}
R_{ON}(V_{in}) 
&= \underbrace{R_{ON}(V_{in}=0) + \dv{R_{ON}}{V_{in}}\bigg|_{V_{in}=0} \cdot V_{in}}_{\text{first order}} + \underbrace{\frac{1}{2}\cdot\dv[2]{R_{ON}}{V_{in}}\bigg|_{V_{in}=0} \cdot V_{in}^2}_{\text{second order}} + \dots \\
\end{aligned}
$$

只不过此时我们想要求 HD3，所以不能省略二阶项。将 $R_{ON}(V_{in}) = \frac{1}{\mu_n C_{ox}\frac{W}{L}(V_{DD}-nV_{in}(t)-V_{TH})}$ 带入上式，可求得

$$
\begin{aligned}
\large R_{ON}(V_{in}) 
= &\underbrace{R_{ON}(0)}_{\frac{1}{\mu_n C_{ox}\frac{W}{L}(V_{DD}-V_{TH})}} \cdot\left[ 1 + \frac{n}{V_{DD}-V_{TH}}V_{in} + \left(\frac{n}{V_{DD}-V_{TH}}\right)^2 V_{in}^2 \right] \\
= &\frac{1}{\mu_n C_{ox}\frac{W}{L}(V_{DD}-V_{TH})} + \frac{n}{\mu_n C_{ox}\frac{W}{L}(V_{DD}-V_{TH})^2} \cdot V_{in} + \frac{n^2}{\mu_n C_{ox}\frac{W}{L}(V_{DD}-V_{TH})^3} \cdot V_{in}^2

\end{aligned}
$$

我们使用 Marcel 类似的推导方式，即开关往往开得非常好，使得近似 $V_{in}=A_0\sin(\omega t)=V_{C_H}$ 输入信号全部落在 $C_H$ 上，然后可以求出开关两端的电压：

$$
\begin{aligned}
V_R(t) & =  \ A_0 \omega C_H R_{ON,0} \cos(\omega t) \\
& + \ A_0^2 \omega C_H R_{ON,0} \dfrac{n}{V_{ov}} \left( \frac{1}{2}\sin(2\omega t) \right) \\
& + \ A_0^3 \omega C_H R_{ON,0} \dfrac{n^2}{V_{ov}^2} \left( \frac{1}{4}\cos(\omega t) - \frac{1}{4}\cos(3\omega t) \right)
\end{aligned}
$$

其中 $V_{ov}=V_{DD}-V_{TH}$

然后可以求出
$$
\boxed{
\text{HD2} = \frac{1}{2}\cdot \frac{nA_0}{V_{DD}-V_{TH}} \cdot R_{ON,0}C_H\omega
} \\
\boxed{
\text{HD3} = \frac{1}{4}\cdot \left(\frac{nA_0}{V_{DD}-V_{TH}}\right)^2 \cdot R_{ON,0}C_H\omega
}
$$

> 1. We expect the distortion to rise with frequency, because the capacitive current flowing through the nonlinear resistance of the FET will induce a larger distorting voltage.
> 2. Both 2nd and 3rd-order distortions due to Ron modulation are proportional to input frequency ω
> 3. $R_{ON,0}C_H$ is recognized as the nominal time constant of the S/H circuit. So Ron-based distortion is also proportional to the time constant of the circuit. These are all indications of dynamic distortion, which is usually analyzed with Volterra series.

#### Taylor Series Model by Iizuka (intermodulation distortion, Two-tone)

给予双音信号 $V_{in}(t)=A_0\sin(\omega_1 t) + A_0\sin(\omega_2 t)$ 省略推导，直接给出结论：

$$
\text{IM2} = 2\cdot \text{HD2} \\
\text{IM3} = \text{HD3}
$$

#### Fourier Series Model by Razavi

### $v_{in}(t)$-dependent turn-OFF-time

我们还是先不给证明的认为 $V_G(t)-nV_{in}(t) = V_{TH}$ 时，MOSFET 刚好关闭。

假设 $V_G$ 的波形是一个 descending ramp，则 MOSFET 实际的关闭时间，距离 $V_G(t)$ 电压为 0 的时间的差值 $\Delta t_m$ 是
$$
\Delta t_m = \frac{t_f}{V_{DD}}(V_{TH}+n\cdot V_{in}(t))
$$

| [Abidi, TCAS-I, 2018]                                        | [Abidi, TCAS-I, 2018]                                        |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](data:image/png;base64,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) | ![](data:image/png;base64,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) |

即 $C_H$ 上采样的连续时间信号 $V_{in}(t)$ 在时间轴上是不均匀分布的：

![img](https://github.com/user-attachments/assets/ad3369a4-0ca5-484b-b8eb-9faa7e3ffbc5)

这种在采样开关上的时间不均匀采样时间，可以等价为被采信号上 $V_{in}(t-\Delta t_m(V_{in}))$ 的延迟不均匀，即 [Abidi, TCAS-I, 2018] 的 fig. 4. (b) 

$$
\begin{aligned}
V_{c}(t) 
& =V_{in}(t-\Delta t_m) \\
& \approx V_{in}(t)-\Delta t_m\dv{v_{in}(t)}{t}+\frac{1}{2}\Delta t_m^2\dv[2]{v_{in}(t)}{t}
\end{aligned}
$$

将 $\Delta t_m = \dfrac{t_f}{V_{DD}}(V_{TH}+n\cdot V_{in}(t))$ 和 $V_{in}=A_0\sin\omega t$ 带入上式，可得

$$
\boxed{\text{HD}2_{tim}=\frac{\text{IM}2_{tim}}{2}\approx\frac{n}{2}\frac{A_{0}}{V_{DD}}(\omega_{0}t_{f})} \\
\boxed{\text{HD}3_{tim}=\frac{\text{IM}3_{tim}}{3}\approx\frac{n^2}{8}\left(\frac{A_0}{V_{DD}}\right)^2\left(\omega_0t_f\right)^2}
$$

> We expect that this distortion will get worse at higher input frequency, when non-uniform sampling creates larger errors.

在双线性坐标轴上，HD3 随 $t_f$ 的增加而二次增加；在 log-dB 坐标轴上上即 40 dB/dec

### 由 overlap and fringing capacitance 导致的 charge

Marcel 中认为由于交叠电容耦合栅极下降电压导致的电压下降是 (Marcel 书 page384)：

$$
\Delta V_{\text{pedestal}} = \frac{C_{fring}\Delta V_{g}}{C_H} = -\frac{WC_{overlap}V_{DD}}{C_H}
$$

所以这不是一个 $v_{in}(t)$-dependent 量，而是可以视作一种 $V_{DC}$ 

Abidi 认为微乎其微

> When the FET is in triode region, discharge of the inversion layer accounts for the entire expelled charge or clock feedthrough: overlap and fringing capacitance displace a negligible charge by comparison.

此处 Abidi 把 charge-injection 认为是一种 clock feedthrough

### $v_{in}(t)$-dependent charge-injection

#### Marcel

Marcel ADC 书中和 Razavi Analog IC 书假设类似，简单假设

$$
V_{hold} = V_{in}+\frac{Q_{inv}(V_{in})/2}{C_H} = V_{in}\left( 1+\frac{WLC_{ox}}{2C_H} \right)
$$

可以得到 "a slight amplification at the moment of sampling" 的结论：

> This effect can jeopardize the performance of pipeline and algorithmic based converters where an exactly multiplication factor is required. In advanced technologies with short gate lengths, the channel contains much less charge, and therefore this amplification is less of an issue.

#### Razavi

在 Razavi 的 ADC 书中

$$
\Delta V = \frac{Q_{ch}}{C_H} = \frac{W L C_{ox} (V_{GS} - V_{TH})}{C_H} = \frac{W L C_{ox} (V_{DD} - V_{in} - V_{TH})}{C_H}
$$

则进一步考虑由于体效应导致的 $V_{TH} = V_{TH0} + \gamma (\sqrt{V_{in} + 2 \phi_B} - \sqrt{2 \phi_B})$ 变化，导致的 non-linearity

或者也可以写成：

$$
\Delta V 
= \frac{Q_{ch}}{C_H} 
= \frac{W L C_{ox} (V_{GS} - V_{TH})}{C_H}
= \frac{\left( \mu_nC_{ox}\dfrac{W}{L} (V_{GS} - V_{TH}) \right)\cdot \dfrac{L^2}{\mu_n}}{C_H}
= \dfrac{L^2}{\mu_n\tau}
$$

来体现 trade-off:

> In other words, the product of the error, V , and τ is equal to L2/μn and only a function of the CMOS technology in which the circuit is designed. This relation exemplifies a precision-speed trade-off.

#### Iizuka

不同于 Marcel ADC 书中注入 s 和 d 两侧电荷相等的简单假设，Iizuka 认为不相等：

- > As the FET switch turns OFF, the charge in its channel flows into source and drain terminals **unequally**, depending on their relative impedances and on the transition time of $V_G(t)$

然后我们让开关在 $t=0$ 时开始关闭，则结合前文所述，MOSFET 在 $t=t_f-\Delta t(V_{in})$ 时完全关闭，而不是 $V_G=0$ 的 $t=t_f$ 时间点。

为了评估沟道电荷注入造成的 distortion，我们需要先做出近似：

- > assume that when the switch FET turns OFF, its expelled charge **changes** the source and drain **voltages negligibly**
  - 同时，由于之前假设了 MOSFET 开关开得非常好，即 $V_S=V_D$ 恒成立，所以加上 charge-injection 几乎不改变电压这个假设，可以推出 during the transition of $V_G(t)$ the charge density remains **uniform between source and drain** as it collapses to zero

    - > the ON resistance Ron is equally divided from the center of the channel

    - > this assumption suffices at moderate levels of distortion, its limits are tested when it is the dominant source at very low levels

  - 也可以说 the voltage of the channel, $V_{ch}$, remains almost constant over the transition time $0\to (t_f-\Delta t(V_{in}))$

![img](https://github.com/user-attachments/assets/e45ff243-681f-480e-9a9d-fb067bc3f8d3)

所以，可以将注入的电荷近似为从 $t=0$ 开始放流，至 $t=t_f-\Delta t(V_{in})$ 时结束放流的电流源。从 NMOS 注入 source 和 drain 的总电量，即由于 $V_G(t)$ 随时间下降，而反型层中多余的电子逐渐进入 s 和 d 的（负）电荷随时间变化的关系是：

$$
?\quad Q(t) = (V_G(t)-V_{ch})\cdot C_G=\int^t_0 i_{inj}(\tau)\;\mathrm{d}\tau \quad ?
$$

#### 结论

$$
\begin{alignat}{3}
\text{HD } 2_{ci} 
= & \frac{\text{IM } 2_{ci}}{2} 
\approx & \frac{n^2}{8} \frac{A_0}{V_{DD}} \frac{C_G}{C_2} \frac{\beta V_{ov}}{C_2} t_f 
\times  &
& \exp \left( -\frac{1}{2} \frac{V_{ov}}{V_{DD}} \frac{\beta V_{ov}}{C_2} t_f \right) \\
\text{HD} 3_{ci} 
=& \frac{\text{IM } 3_{ci}}{3} 
\approx & \frac{n^3}{48} \frac{A_0^2}{V_{DD} V_{ov}} \frac{C_G}{C_2} \frac{\beta V_{ov}}{C_2} t_f 
\times & \left( \frac{V_{ov}}{V_{DD}} \frac{\beta V_{ov}}{C_2} t_f - 1 \right) 
&\exp \left( -\frac{1}{2} \frac{V_{ov}}{V_{DD}} \frac{\beta V_{ov}}{C_2} t_f \right)
\end{alignat}
$$

- two-tone IM2 and IM3 due to the charge injection are, respectively, 6 dB and 10 dB larger than HD2 and HD3
- charge injection is **independent** of the **input frequency**
- The harmonics increase in amplitude proportionally with the ratio of the gate to the sampling capacitances, which scales up the amount of the distortion-causing charge



- The term βVov/C2  indicates the (RC)−1 bandwidth of the S/H circuit. Simply stated, charge injection is greater in a large-size FET (large β) driving a given capacitance
- The exponential term indicates that the distortion decreases rapidly with larger FET size and with lower hold capacitance. 
- With wide bandwidth, that is, when ON resistance and capacitance are both small, charge distribution becomes independent of the external signal input since the source and drain remain nearly equipotential over the turn OFF transition.


- 开关速度 $t_f$
  - 非常快时：Distortion depends either linearly or quadratically on the transition time $t_f$ of $V_{G}(t)$. Sharper turn-OFF will lower distortion
    - The ON conductance of the MOS switch quickly falls to zero, when it is reasonable to assume that the channel charge will partition equally into the source and drain terminals: this leads to a fixed offset voltage on the output capacitor but no distortion.
    - do not hold for extremely sharp turn-OFF transitions because the assumption breaks down that charge density is uniform through the channel
  - 非常慢时：distortion will also drop
    - Since the ON resistance increases gradually over a slow transition, a quasi-static condition [18, Ch. 7] prevails that divides the channel charge between source and drain in a ratio determined only by the capacitances C1 and C2. This partition is independent of input signal, so charge injection produces either a fixed offset in held voltage, or a linear scaling of the input; neither can be called distortion.
  - Therefore, as the transistor width W or the transition time $t_f$ are swept, distortion will likely go through a minimum or maximum. HD3 is null at the specific transition time t f = (C2 VDD)/(β Vo2v ).



### $v_{in}(t)$-dependent $C_H'=C_H+C_{DB}(v_{in})$

$C_{DB}$ 是 Switch MOSFET drain-bulk PN 结的结电容，对于结电容有：

$$
C_{DB}(v_{in}) 
= \frac{C_{j0}}{\left( 1 + \dfrac{V_{DB}}{\phi_0} \right)^m}
= \frac{C_{j0}}{\left( 1 + \dfrac{V_{in}(t)}{\phi_0} \right)^m}
$$

In Razavi's ADC book, Problem 3.5 assumes that $C'_H(t) = C_a + C_b\cos(\omega_1t)$ for an input signal of $V_{in}(t) = \frac{V_{DD}}{2} + \frac{V_{DD}}{2}\cos(\omega_1t)$: 

In a properly designed track-and-hold circuit, the condition $\omega_1\ll\frac{1}{\tau}=\frac{1}{R_{on}(C_a+C_b\cos\omega_1t)}$ must be satisfied. Therefore, the RC network functions as a τ delay unit, resulting in a phase lag of $\omega_1\tau$ in the output signal:

$$
\begin{aligned}
V_{out}(t) 
&\approx \frac{V_{DD}}{2} + \frac{V_{DD}}{2} \cos[\omega_1t - R_{on}(C_a + C_b \cos \omega_1t)\omega_1] \\
V_{out,ac}(t)
&= \frac{V_{DD}}{2}\cos[\omega_1t - \underbrace{R_{on}C_a\omega_1}_{\displaystyle\phi_0} - \underbrace{R_{on}C_b\omega_1}_{\displaystyle\beta_0} \cos(\omega_1t)]\\
&= \frac{V_{DD}}{2} \cos[\omega_1t - \phi_0 - \beta_0 \cos(\omega_1t)] \\
&= \frac{V_{DD}}{2}\bigg( \cos(\omega_{1}t - \phi_0)\cdot\cos(\beta_0 \cos(\omega_1t)) + \sin(\omega_{1}t - \phi_0)\cdot\sin(\beta_0 \cos(\omega_1t)) \bigg)
\end{aligned}
$$

For a S&H:

$$
\omega_1\ll\dfrac{1}{R_{on}C_H}<\dfrac{1}{R_{on}C_b} 
\implies \beta_0\cos(\omega_1t)\ll1 
\implies
\begin{cases}
\cos(\beta_0 \cos(\omega_1t)) \approx 1 - \frac{\beta_0^2}{2}\cos^2(\omega_{1}t) \\
\sin(\beta_0 \cos(\omega_1t)) \approx \beta_0 \cos(\omega_1t) - \frac{\beta_0^3}{6}\cos^3(\omega_1t)
\end{cases}
$$

Therefore:

$$
\begin{aligned}
V_{out,ac}(t) 
&= \frac{V_{DD}}{2}\left( \cos(\omega_{1}t - \phi_0)\cdot\left(1 - \frac{\beta_0^2}{2}\cos^2(\omega_1t)\right) + \sin(\omega_1t - \phi_0)\cdot\left(\beta_0 \cos(\omega_1t) - \frac{\beta_0^3}{6}\cos^3(\omega_1t)\right) \right)\\
&= \frac{V_{DD}}{2} \left[ \underbrace{\left(1 - \frac{\beta_0^2}{4}\right)\cos(\omega_{1}t - \phi_0) - \frac{\beta_0^2}{8}\cos(\omega_1t + \phi_0)}_{ \displaystyle(1ω_1)} + \underbrace{\frac{\beta_0}{2}\sin(2\omega_1t - \phi_0)}_{\displaystyle(2ω_1)} - \underbrace{\frac{\beta_0^2}{8}\cos(3\omega_1t - \phi_0)}_{\displaystyle(3ω_1)} - \underbrace{\frac{\beta_0}{2}\sin(\phi_0)}_{\displaystyle\text{DC offset}} + \dots \right]
\end{aligned}
$$

We get:

$$
\boxed{
\begin{aligned}
\text{HD2} &\approx \frac{V_{DD}\beta_0/4}{V_{DD}/2} = \frac{\beta_0}{2} = \frac{R_{on}C_b\omega_1}{2} \\
\text{HD3} &\approx \frac{V_{DD}\beta_0^2/16}{V_{DD}/2} = \frac{\beta_0^2}{8} = \frac{(R_{on}C_b\omega_1)^2}{8}
\end{aligned}
}
$$

> [!NOTE]
>
> Razavi’s analytical method actually underestimates HD2 and HD3; in particular, HD3 shows a qualitative accuracy in Razavi’s framework, yet quantitatively it introduces an error of roughly a factor of 10. We therefore need a more accurate approach for evaluation.

另一种方法有：

我们有 $V_{in}(t) = V_{DC} + V_{AC}\cos(\omega_1t)$ 和 $C(t) = C_a + C_b\cos(\omega_1t)$，其中 $V_{DC}=V_{AC}=\dfrac{V_{DD}}{2}$

$$
\begin{aligned}
V_{out}(t) 
&= V_{in}(t) - R_{on} \frac{d}{dt}[C(t)V_{out}(t)] \\
\approx V_{out}^{(1)}(t) & = V_{in}(t) - R_{on} \frac{d}{dt}[C(t)V_{in}(t)] \\
&= V_{in}(t)-R_{on}\dv{}{t}(C_a + C_b\cos(\omega_1t))(V_{DC} + V_{AC}\cos(\omega_1t)) \\
&= V_{in}(t)-R_{on}\dv{}{t}\left( \left(C_aV_{DC} + \frac{C_bV_{AC}}{2}\right) + (C_aV_{AC} + C_bV_{DC})\cos(\omega_1t) + \frac{C_bV_{AC}}{2}\cos(2\omega_1t) \right) \\
&= V_{in}(t) - R_{on} \big[ -\omega_1(C_aV_{AC} + C_bV_{DC})\sin(\omega_1t) - \omega_1C_bV_{AC}\sin(2\omega_1t) \big] \\
&= \underbrace{(V_{DC} + V_{AC}\cos(\omega_1t))}_{V_{in}(t)} + \underbrace{R_{on}\omega_1(C_aV_{AC} + C_bV_{DC})\sin(\omega_1t)}_{\text{基波修正项}} + \underbrace{R_{on}\omega_1C_bV_{AC}\sin(2\omega_1t)}_{\text{二次谐波}}
\end{aligned}
$$

所以 HD2 有：

$$
\boxed{\text{HD2} = R_{on}\omega_1C_b}
$$

为了得到三次谐波，我们需要进行第二轮迭代。我们将上面得到的 $V_{out}^{(1)}(t)$ 代回到原始方程中。

$$
V_{out}^{(2)}(t) = V_{in}(t) - R_{on} \frac{d}{dt}[C(t)V_{out}^{(1)}(t)]
$$

三次谐波来自于 $C(t)$ 中的 $\omega_1$ 分量与 $V_{out}^{(1)}(t)$ 中的 $2\omega_1$ 分量的混频，在乘积 $C(t)V_{out}^{(1)}(t)$ 中，我们关注的项是：

$$
\text{交叉项} 
= \underbrace{(C_b\cos(\omega_1t))}_{\text{from } C(t)} \times \underbrace{(R_{on}\omega_1C_bV_{AC}\sin(2\omega_1t))}_{\text{from } V_{out}^{(1)}(t)}
= R_{on}\omega_1C_b^2V_{AC} \cos(\omega_1t)\sin(2\omega_1t)
= R_{on}\omega_1C_b^2V_{AC} \cdot \frac{1}{2}[\sin(3\omega_1t) + \sin(\omega_1t)]
$$

我们只关心产生三次谐波的部分，即 $\frac{1}{2}R_{on}\omega_1C_b^2V_{AC}\sin(3\omega_1t)$

$$
\frac{d}{dt}\left[\frac{1}{2}R_{on}\omega_1C_b^2V_{AC}\sin(3\omega_1t)\right] = \frac{3}{2}R_{on}\omega_1^2C_b^2V_{AC}\cos(3\omega_1t)
$$

代入 $V_{out}$ 的修正项公式，得到输出的三次谐波分量 $V_{out,3\omega_1}(t)$：

$$
V_{out,3\omega_1}(t) 
= -R_{on} \times \left(\frac{3}{2}R_{on}\omega_1^2C_b^2V_{AC}\cos(3\omega_1t)\right) 
= -\frac{3}{2}(R_{on}\omega_1)^2C_b^2V_{AC}\cos(3\omega_1t)
\implies \boxed{\text{HD3} = \frac{3}{2}(R_{on}\omega_1C_b)^2}
$$


### non-ideal clock (jitter)

by Razavi:

> We postulate that the jitter-induced output noise voltage, should have an rms value well below the LSB of the overall ADC. We formulate this condition after deriving the quantization noise power in Chapter 12.



### Appendix: where does $n$ come from (in Iizuka's paper)





## Thermal Noise in Track-and-Hold Circuits

> ISSCC 2011 - T08 - [Noise Analysis in Switched Capacitor Circuits](https://resourcecenter.sscs.ieee.org/education/short-courses/sscstut20110070), Boris Murmann
>
> [Thermal Noise in Track-and-Hold Circuits: Analysis and Simulation Techniques](https://ieeexplore.ieee.org/document/6218338), Boris Murmann, SSC-M, 2012

依然考虑一个 MOSFET + C 的简单采样情形
$$
\overline{v_{\text{out}}^2} = \int_{0}^{\infty} 4kTR \left| \frac{1}{1 + j2\pi fRC} \right|^2 df = 4kTR \frac{1}{4RC} = \frac{kT}{C}
$$
是一个推出热噪声的经典方法，还有另外一种理论可以推出相同的结果

> [!TIP]
>
> equipartition theorem: any energy storage element (or “degree of freedom”) in thermal equilibrium holds an average noise energy of kT/2. In the circuit considered here, the capacitor is the energy storage element.
> $$
> \overline{\frac{1}{2} C v_{\text{out}}^2} = \frac{kT}{2} \implies \overline{v_{\text{out}}^2} = \frac{kT}{C}
> $$
> derivations assume that the circuit operates in “thermal equilibrium.” This leaves room for speculation on whether the kT/C bound can be overcome using techniques that would trick a circuit into nonequilibrium.

定义
$$
\frac{T_s/2}{\tau=RC}
$$

> The number of time constants that fit into the tracking period. Precision SC circuits are typically designed with N = 7-10 to ensure accurate transient settling.





## Guidelines for Optimum S/H Design

> ref: [Comprehensive Analysis of Distortion in the Passive FET Sample-and-Hold Circuit](https://ieeexplore.ieee.org/abstract/document/8307227), Tetsuya Iizuka & Asad A. Abidi, TCAS-I, 2018: V. GUIDELINES FOR OPTIMUM S/H DESIGN

开始分析

> - Typically, we will use a FET with minimum L for the smallest possible switch Ron.
> - Specifications on thermal noise limit the smallest sampling capacitance by the mean square noise voltage kT/C across it, where k and T are Boltzmann’s constant and absolute temperature.
> - This leaves two design parameters, $t_f$ and W .

设计目标和工艺参数：

> - We focus on minimizing **3rd-order harmonic** distortion, counting on a well-balanced differential circuit arrangement to suppress even harmonics to a lower level.
>
> - Nyquist-rate A/D converter, N=10-bit resolution, $f_s=2.5\text{GS/s}\; (f_{in} < 1.25\text{GHz}),\; V_{DD} = 1,\; V_{DC} = 0.35,\; \dfrac{V_{pp}}{2}=A_0 = 0.2,\; R_S = 50\Omega$
>
> - 亚阈值斜率 $n=1.3$

设计方法：

> 1. The target SNR determines the smallest **sampling capacitance**: the mean square thermal noise is chosen to lie below the mean square quantization noise. by Iizuka
>
> $$
> \sqrt\frac{kT}{C_H} =
> \boxed{\sqrt{\overline{v_{n,th}^2}} \le \sqrt{\overline{v_{n,q}^2}} }
> = \sqrt\frac{\Delta^2}{12}=\sqrt\frac{\left( \dfrac{V_{FS}}{2^N} \right)^2}{12}
> \implies C_H \ge \frac{12 \cdot kT \cdot (2^N)^2}{V_{FS}^2}=327\text{fF}
> $$
>
> Or by Razavi: In the design of samplers, we first examine the static linearity ($f_{in}$ independent linearity) by measuring the output harmonics at low input frequencies and adjust the **value of the sampling capacitor to suppress them**. This still requires transient simulations followed by an FFT. We then turn to dynamic linearity, run the circuit at high frequencies, measure the distortion, and see whether further adjustments are necessary. For example, we can make the sampling switch wider so as to lower its resistance. Of course, such an adjustment may degrade the static linearity (why?). Thus, some iteration between static and dynamic tests is necessary.
>
> 2. Determine a suitable **transition time** $t_f$ of $v_G(t)$.
>
>    1. $v_{in}(t)$-dependent turn-OFF-time 中的分析告诉我们 $t_f$ 越短，失真越少。But this is at the price of more power consumed in the clock buffer. To lower this power, the transition time t f may be slowed down.
>    2. Since $\text{HD3}_{tim}$ depends only on $ω_0$ and $t_f$, we can find the longest $t_f$ for a specified input bandwidth.
>    $$
>    \text{SNR}_{ideal,q} = 6.02N+1.76 
>    =\quad 62\text{dB} \quad= 
>    \text{HD3}_{\text{dBc}} = 20\log_{10}(\text{HD3}_{tim}) = 20\log_{10}\left(\frac{n^2}{8}\left(\frac{A_0}{V_{DD}}\right)^2\left(\omega_0t_f\right)^2\right) 
>    
>    \implies t_f=40\text{ps}
>    $$
>    3. > [!NOTE]
>       >
>       > 此处假设了理想时钟，或者说在这个采样频率下，时钟 jitter 100fs 左右影响不大
>       >
>       > 此处并没有假设 $\text{HD3}_{\text{dBc}}<-\text{SNR}_{\text{dB, ideal, q}}-10$ ，而是要求同一量级
>
> 3. find the optimum switch FET **width**
>    1. 当 W 很小时，限制因素主要是 $v_{in}(t)$ dependent $R_{on}$ 产生的 $\text{HD3} = \frac{1}{4}\cdot \left(\frac{nA_0}{V_{DD}-V_{TH}}\right)^2 \cdot R_{ON,0}C_H\omega$ 
>    2. when W becomes very large, the distortion by FET’s nonlinear diffusion junction capacitance dominates the total HD3
>    3. The investigation so far shows that, alas, this simple S/H circuit cannot reach the target specification of −60 dB distortion at the given input bandwidth ( and $C_H, t_f$ we just set). However, it can reach −50 dB. 也就是说，在 "square thermal noise lie below the mean square quantization noise" 的情况下，10-bit ADC with a simple S/H 只能做到 -50dB 的 SNR
>
> 4. 因为在 $C_H=327\text{fF}, t_f=40\text{ps}$ 的情况下，无法到达之前目标的 62dB，是有所浪费的（即热噪声和 $\text{HD3}_{tim}$ 所导致的 SNDR 下降远小于 MOSFET W(限制 $R_{on}$ 和 $C_j$) 导致的 SNDR 下降），所以需要重新选取 $C_H$ 和 $t_f$ 找到一个 $>|50|\text{dB}$ 的综合最优值。或者说，可以确定 50dB 目标，而放宽对 $C_H$ 和 $t_f$ 的要求。Abidi 选择了后面一种情况讨论，详见 Fig. 21.



## Bootstrap

todo



## Appendix



<details>
<summary>code1</summary>

```python
import numpy as np
import matplotlib.pyplot as plt

# --- Global Style Settings ---
# Set the default font to Arial for all text elements
plt.rcParams['font.family'] = 'sans-serif'
plt.rcParams['font.sans-serif'] = ['Arial']

# Define a new, thicker line width for curves and axes
NEW_LINE_WIDTH = 8

# --- 1. Parameters Definition ---
# Input signal with DC offset and Vpp=1V
A = 0.5  # Amplitude (Vpp/2)
DC_OFFSET = 0.5 # DC Bias
VPP = 2 * A

f = 1.0  # Frequency
omega = 2 * np.pi * f
t_continuous = np.linspace(0, 2, 500)
# v_in now ranges from 0V to 1V
v_in = A * np.sin(omega * t_continuous) + DC_OFFSET

# Ideal sampling
Fs = 10  # Sampling frequency
Ts = 1 / Fs  # Ideal sampling period
num_samples = int(2 / Ts)
t_ideal = np.arange(num_samples) * Ts

# Turn-OFF timing shift Δt_m, linearly dependent on v_in
k = 0.05  # Distortion coefficient
v_in_at_ideal_t = A * np.sin(omega * t_ideal) + DC_OFFSET
delta_t = k * v_in_at_ideal_t

# Actual sampling instants
t_actual = t_ideal + delta_t
# Sampled voltage values at actual instants
v_sampled = A * np.sin(omega * t_actual) + DC_OFFSET

# --- 2. Plotting ---
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(24, 11), sharex=True)
fig.suptitle('Illustration of Turn-OFF Timing-Based Distortion', fontsize=36, y=0.98)

# --- Plot 1: Non-uniform Sampling on the Time Axis ---
ax1.plot(t_continuous, v_in, 'b-', label='Original Continuous Signal $v_{IN}(t)$', lw=NEW_LINE_WIDTH, alpha=0.8)

(markerline, stemlines, baseline) = ax1.stem(
    t_ideal, A * np.sin(omega * t_ideal) + DC_OFFSET, linefmt='g:', markerfmt='go', basefmt=" ",
    label='Ideal Sampling Instants (Uniform)'
)
plt.setp(stemlines, 'linewidth', NEW_LINE_WIDTH)
plt.setp(markerline, 'markersize', 16)

(markerline, stemlines, baseline) = ax1.stem(
    t_actual, v_sampled, linefmt='r-', markerfmt='rx', basefmt=" ",
    label='Actual Sampling Instants (Non-uniform)'
)
plt.setp(stemlines, 'linewidth', NEW_LINE_WIDTH)
plt.setp(markerline, 'markersize', 16, 'markeredgewidth', 7)

# Annotations for Δt
for i in [2, 5, 7]:
    ax1.annotate(
        '', xy=(t_actual[i], -0.35), xytext=(t_ideal[i], -0.35),
        arrowprops=dict(arrowstyle='<->', color='purple', shrinkA=0, shrinkB=0, lw=1.5)
    )
    ax1.text((t_ideal[i] + t_actual[i])/2, -0.45, f'Δt$_{i}$', color='purple', ha='center', fontsize=18)

# Adjust titles, labels, legend, and ticks
# Added y=1.02 to increase space between title and plot
ax1.set_title('(a) Non-uniform Sampling Caused by Turn-OFF Timing', fontsize=30, y=1.02)
ax1.set_ylabel('Voltage (V)', fontsize=26)
ax1.set_ylim(-0.5, 1.3)
ax1.legend(loc='upper right', fontsize=24)
for spine in ax1.spines.values():
    spine.set_linewidth(NEW_LINE_WIDTH)
ax1.tick_params(axis='both', which='major', labelsize=22, width=4, length=10)
ax1.grid(True, which='both', linestyle='--', linewidth=1)

# --- Plot 2: Equivalent Distortion at the Output ---
ax2.plot(t_continuous, v_in, 'b--', label='Original Signal $v_{IN}(t)$ (Reference)', lw=NEW_LINE_WIDTH, alpha=0.6)
ax2.plot(t_ideal, v_sampled, 'r-o', label='Reconstructed Signal $v_c(t)$ (Distorted)', lw=NEW_LINE_WIDTH, markersize=16)

# Annotations
t_peak_ideal = 0.25
v_peak_reconstructed = np.interp(t_peak_ideal, t_ideal, v_sampled)
ax2.annotate('Maximum delay occurs at peak voltage,\ncausing the sampled value to be lower',
             xy=(t_peak_ideal, v_peak_reconstructed),
             xytext=(0.6, 0.75),
             arrowprops=dict(facecolor='black', shrink=0.05, width=0.1, headwidth=3, headlength=4),
             fontsize=24, ha='center', bbox=dict(boxstyle="round,pad=0.3", fc="white", ec="black", lw=1, alpha=0.8))

t_trough_ideal = 0.75
v_trough_reconstructed = np.interp(t_trough_ideal, t_ideal, v_sampled)
ax2.annotate('Minimum delay occurs at trough voltage,\nso sampled value is more accurate',
             xy=(t_trough_ideal, v_trough_reconstructed),
             xytext=(1.1, 0.2),
             arrowprops=dict(facecolor='black', shrink=0.05, width=0.1, headwidth=3, headlength=4),
             fontsize=24, ha='center', bbox=dict(boxstyle="round,pad=0.3", fc="white", ec="black", lw=1, alpha=0.8))

# Adjust titles, labels, legend, and ticks
# Added y=1.02 to increase space between title and plot
ax2.set_title('(b) Equivalent Distortion at the Output', fontsize=30, y=1.02)
ax2.set_xlabel('Time (s)', fontsize=26)
ax2.set_ylabel('Voltage (V)', fontsize=26)
ax2.set_ylim(-0.1, 1.1)
ax2.legend(loc='upper right', fontsize=24)
for spine in ax2.spines.values():
    spine.set_linewidth(NEW_LINE_WIDTH)
ax2.tick_params(axis='both', which='major', labelsize=22, width=4, length=10)
ax2.grid(True, which='both', linestyle='--', linewidth=1)

plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.show()
```

</details>
