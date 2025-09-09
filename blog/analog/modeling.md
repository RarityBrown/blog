# MOSFET Modeling in Advanced Planar Nodes for Analog Design

## DC

### `n` the subthreshold slope factor

在器件课上，我们学过 SS 有

$$
n = 1 + \frac{C_{dep}}{C_{ox}}
$$

耗尽层电容 Cdep 代表了衬底对沟道的影响，而栅氧化层电容 Cox 代表了栅极对沟道的影响。n 的值实际上反映了这两个“栅极”控制能力的相对强弱。

在模集课上，我们学过体效应系数 γ 有

$$
\gamma=\frac{\sqrt{2q\epsilon_{si}N_{sub}}}{C_{ox}}
$$

经过一些代数轮换，可以推导出

$$
n(\psi_s)=1+\frac{\gamma}{2\sqrt{\psi_s+V_{SB}}} \xlongequal{\text{strong inversion}} 1+\frac{\gamma}{2\sqrt{2\phi_F+V_{SB}}} 
$$

所以，可以说 n 也是可以代表体效应的一个参数。本质上，Razavi 书公式 2.54 的 $\eta$ 和公式 2.37 的 $(\xi-1)$ 是同一个物理量。

再回到之前的那句话：

> 耗尽层电容 Cdep 代表了衬底对沟道的影响，而栅氧化层电容 Cox 代表了栅极对沟道的影响。n 的值实际上反映了这两个“栅极”控制能力的相对强弱。

$$
\frac{g_m}{C_{ox}} = \frac{g_{mb}}{C_{dep}}
$$

## Capacitor

