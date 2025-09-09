# Sample and Hold, Track and Hold

ref: 

> Analog-to Digital Conversion, Fourth Edition, Marcel J.M. Pelgrom, 978-3-030-90808-9
>
> [Comprehensive Analysis of Distortion in the Passive FET Sample-and-Hold Circuit](https://ieeexplore.ieee.org/abstract/document/8307227), Tetsuya Iizuka & Asad A. Abidi, TCAS-I

## Basic Concept

todo

## Passive FET Sample-and-Hold

### (nonlinear) $v_{in}(t)$-dependent $R_{ON}$ resistance     (Modulation of FET $R_{on}$ by $v_{in}(t)$)

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
> $$
> I_{D}=\mu_{n}C_{ox}\dfrac{W}{L}\left( (V_{GS}-V_{TH})V_{DS}-\frac{1}{2}V_{DS}^2 \right) \\
> 
> R_{ON}(V_{in}(t))|_{V_{DS}\sim 0}
> =\frac{1}{\pdv{I_D}{V_{DS}}}
> =\frac{1}{\mu_nC_{ox}\frac{W}{L}(V_{GS}-V_{TH}-V_{DS})}
> =\frac{1}{\mu_nC_{ox}\frac{W}{L}(V_{DD}-V_{in}-V_{TH})}
> $$
> 对于低电源电压的设计，要注意 MOSFET 开关是否能导通。
>
> At low supply voltages and large-signal excursions, the voltage-dependent resistance of the switch can lead to aperture time differences causing distortion. 





#### Advanced Model by Abidi (1) considering HD3 单音测试

首先，我们不给证明的给出（证明稍后给出）

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

#### Advanced Model by Abidi (2) considering IM2, IM3 双音测试 intermodulation distortion

给予双音信号 $V_{in}(t)=A_0\sin(\omega_1 t) + A_0\sin(\omega_2 t)$ 省略推导，直接给出结论：

$$
\text{IM2} = 2\cdot \text{HD2} \\
\text{IM3} = \text{HD3}
$$

## Bootstrap

todo

