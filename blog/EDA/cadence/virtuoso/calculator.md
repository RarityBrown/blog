## Calculator & ADE Explorer Expression Builder


### 半对数轴求导

对 $\log_{10}\sim\log_{10}$ 坐标系求导，例如幅频响应：

$$
20\lg y=\lg f
\to \dfrac{d\lg y}{d\lg f}=\dfrac{d\lg y / df}{d\lg f/ df}=\dfrac{\dfrac{d\lg y}{d y}\dfrac{d y}{df}}{\dfrac{1}{f}}=\dfrac{f}{y}\dfrac{dy}{df}
$$



对 $\log_{10}(y)\sim x$ 坐标系求导：

$$
\dv{\log_{10} y}{x} = \dfrac{1}{y \ln 10}\dv{y}{x}
$$

例如对于 MOSFET IV 曲线中的 Subthreshold Slope `I * ln(10) / deriv(I)` ：

$$
\begin{aligned}
\dv{\log_{10} I_D}{V_{GS}} = \dfrac{1}{I_D \ln 10}\dv{I_D}{V_{GS}} &= a\,\pu{(V^{-1})}
\quad &&\text{电压每提高 1V 时，电流增加至原来的 }10^a
\\
\text{SS}=\dfrac{1}{a} &= \pu{60mV/decade}\quad &&\text{电流每增加 10 倍，电压需提高 60mV}
\end{aligned}
$$

### `OT("/M1" "gmoverid")`

当我们希望画出 M1 管的 gmoverid 和时间的曲线时（例如在设计 FIA Comparator），我们会用到 `OT("/M1" "gmoverid")` 函数 "to create an expression for transient operating point"。但是需要进行额外设置，否则画出来的是一个数值，而不是一条关于时间的曲线，设置如下：


![](https://github.com/user-attachments/assets/2832a7d0-2db1-44e7-8664-73678dd2df28)

参考资料：*Usage of Operating Point Parameters Rapid Adoption Kit (RAK)*

## 自定义函数

```skill

```
