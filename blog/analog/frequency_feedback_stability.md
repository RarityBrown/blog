# Frequency Response, Feedback and Stability

[如何用Bode图判断系统的稳定性？ - 知乎 (zhihu.com)](https://www.zhihu.com/question/20699458)

[如何直观看待模拟电路中的环路增益？ - 知乎 (zhihu.com)](https://www.zhihu.com/question/577525420)




## 一个有趣的问题：反相放大器

| 反馈结构     | Transimpedance amplifier                                     | Inverting amplifier                                          |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
|              | ![TIA](https://upload.wikimedia.org/wikipedia/commons/f/f1/TIA_simple.svg) | ![inverting](https://upload.wikimedia.org/wikipedia/commons/4/41/Op-Amp_Inverting_Amplifier.svg) |
|              | $\dfrac{V_{out}}{I_{in}}=-\dfrac{R_f}{1+\dfrac{1}{A}}\approx -R_f$ | $\dfrac{V_{out}}{V_{in}}=\dfrac{-\frac{R_f}{R_{in}+R_f}A}{1+\frac{R_{in}}{R_{in}+R_f}A}\approx-\dfrac{R_f}{R_{in}}$ |
| 一般观点     | voltage-shunt 并联采样（电压采样），并联混合（电流求和）     |                                                              |
| Razavi 观点  | voltage-current 检测输出电压，反馈电流至输入端               |                                                              |
| Sansen 观点  | shunt-shunt 反馈网络并联于输出节点和虚地间，在反相输入端进行电流并联混合求和 |                                                              |
| 反馈下的闭环 | $\dfrac{V_{out}}{I_{in}}=\dfrac{R_0}{1+g_{mF}R_0}$           |                                                              |

网上的主流分析方法是（参考张鸿老师网课、[模集王小桃](https://zhuanlan.zhihu.com/p/2909304009)）：

> 传统认为，闭环负反馈网络的传递函数可写为 $\dfrac{A_{OL}}{1+\beta A_{OL}}$。但是实际上应该修正为: $\dfrac{A_{OL}}{1+L}$​ 其中 L 是 Loop gain
>
> 1. 计算 $A_{OL}=\dfrac{V_{OUT}}{V_{IN}}$: 断开 $R_f$ 和 $V_{out}$ 的连接，将 $R_f$ 右端接交流地，在 $V_{in}$ 输入信号。得到 $A_{OL}=-\dfrac{R_f}{R_{in}+R_f}A_v$
> 2. 计算 $L=-\dfrac{V_F}{V_t}$: 断开 $R_f$ 和 $V_{out}$ 的连接，将 $V_{in}$ 接交流地，在 $R_f$ 右端输入信号 $V_t$ 。得到 $L=-\dfrac{R_{in}}{R_{in}+R_f}A_v$
> 3. $\dfrac{A_{OL}}{1+L}=\dfrac{-\frac{R_f}{R_{in}+R_f}A_v}{1+\frac{R_{in}}{R_{in}+R_f}A_v}\approx-\dfrac{R_f}{R_{in}}$
>
> 如果我们此时强行通过公式 $L=\beta A_{OL}$, 反解出 $\beta=-\dfrac{R_{in}}{R_f}$, 会感觉没有电路的 insight，因为我们**无法**从电路中直接算出这个结果


因为是 voltage-current 反馈，我们可以认为输入的其实是电流信号。所以



我们提供一种不同的看法：



当我们在谈论**负**反馈模型时，我们常常认为 $A_{OL}$ 在低频下是一个**同相**放大器, $\beta$ 是一个无源**同相**反馈网络，例如电阻分压或电容分压。 $\beta$ 的输出加上**负**号，意味着系统是**负**反馈，所以有：

$$
\big[V_{in}+(-\beta V_{out})\big]\cdot A_{OL}=V_{out}
\implies
\dfrac{V_{out}}{V_{in}}=\dfrac{A_{OL}}{1+\beta A_{OL}}
$$

![nfb](https://upload.wikimedia.org/wikipedia/commons/6/6e/Block_Diagram_for_Feedback.svg)

我们考虑另一种视角，认为 $A_{OL,N}=-A_{OL}$ 在低频下是一个**反相**放大器, $\beta$ 是一个无源**同相**反馈网络。 $\beta$ 的输出加上**正**号，认为系统是“**正**”反馈：

![pfb](https://github.com/user-attachments/assets/843b2e32-3c2e-4019-92ef-e35fa7c448ee)

$$
\dfrac{V_{out}}{V_{in}}=\dfrac{A_{OL,N}}{1-\beta A_{OL,N}}=\dfrac{-A_{OL}}{1+\beta A_{OL}}
$$


