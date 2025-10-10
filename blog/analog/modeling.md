# MOSFET Modeling in Advanced Planar Nodes for Analog Design

## Modeling

### DC

#### `n`, the subthreshold slope factor

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

#### EKV 

EKV 模型引入了一个关键的中间变量，叫做**Pinch-off 电压** $V_P$ 。可以理解为在沟道中任意一点，能产生反型电荷所需要的“局部有效栅极电压”。

$$
V_P = \frac{V_G - V_{TH0}}{n}
$$

EKV 模型将总漏极电流 $I_D$ 表示为**正向电流 $I_f$** 和**反向电流 $I_r$** 的差值：

$$
I_D = I_f - I_r
$$

##### 强反型下的 EKV

正向电流 $I_f$ 由栅源极电压 $V_G, V_S$ 控制，强反型下的正向电流公式是：

$$
I_f = \frac{n}{2} \left(\mu C_{ox} \frac{W}{L}\right) \left(V_P - V_S\right)^2 \qquad (V_P>V_S)
$$

反向电流 $I_r$ 由栅漏极电压 $V_G, V_D$ 控制，强反型下的反向电流公式是：

$$
I_r = \frac{n}{2} \left(\mu C_{ox} \frac{W}{L}\right) \left(V_P - V_D\right)^2  \qquad (V_P>V_D)
$$

总电流有：

$$
I_D = \frac{n}{2} \mu C_{ox} \frac{W}{L} \left[ \left(\frac{V_G - V_{T0}}{n} - V_S\right)^2 - \left(\frac{V_G - V_{T0}}{n} - V_D\right)^2 \right] 
$$

所以，对应平方律模型中所谓的 1.三极管区, 2.饱和区（在 EKV 模型中即 1.源端强反型 + 漏断强反型, 2.源端强反型 + 漏断夹断）有：

$$
I_D = \begin{cases}
\displaystyle \left(\mu C_{ox} \frac{W}{L}\right) \left(V_G - V_{TH0} - n\frac{V_S + V_D}{2}\right) \cdot V_{DS}  &  \dfrac{V_G - V_{TH0}}{n} > V_D, V_S \\
\displaystyle \frac{n}{2} \mu C_{ox} \frac{W}{L} \left(\frac{V_G - V_{TH0}}{n} - V_S\right)^2  &  V_D >\dfrac{V_G - V_{TH0}}{n} > V_S
\end{cases}
$$

我们可以推出其导通电阻：

$$
R_{ON} 
= \left( \left. \frac{\partial I_D}{\partial V_{DS}} \right|_{V_{DS} \to 0} \right)^{-1}
= \frac{1}{\mu C_{ox} \frac{W}{L} (V_G - V_{TH0} - nV_S)}
$$

### Capacitor

## Simulating

### 过压和过流 warning

当我们在仿真时，spectre 有时会报 Warning:

> [!WARNING]
> <span style="color: blue;">WARNING</span> (CMI-2751): M0: Vgs(=1.1 V) has exceeded vgs_max(=990 mV). Check and update the settings of the SOA-related model parameters and terminal bias of the instance

这是 "Safe Operating Areas (SOA) Parameters" 检查，是对电压域检查的其中[一种方式](https://community.cadence.com/cadence_blogs_8/b/cic/posts/spectre-tech-tips-spectre-assert-and-design-check-overview)，SOA 检查的规则常由 pdk 提供方指定。例如，TSMC 28nm 中对于 `nch_mac` 的 core NMOS 有：

```
...
+vgs_max=0.99*(max(ov_ratio/1.1,1)) 
+vgd_max=0.99*(max(ov_ratio/1.1,1)) 
+vds_max=0.99*(max(ov_ratio/1.1,1)) 
+vbd_max=0.99*(max(ov_ratio/1.1,1)) 
+vbs_max=0.99*(max(ov_ratio/1.1,1)) 
+vgb_max=0.99*(max(ov_ratio/1.1,1))
...
```

这不是 [BSIM4](https://bsim.berkeley.edu/models/bsim4/) 标准中提供的模型参数，但是被包括 ngspice, Spectre 和 HSPICE 在内的主流 simulator 支持。例如，Spectre Circuit Simulator Components and Device Models Reference `spectremod.pdf` 文档中介绍了在 BSIM4 下支持的 11 个 SOA 参数：

```
506 vds_max=infinity
507 vgd_max=infinity
508 vgs_max=infinity
509 vbd_max=infinity
510 vbs_max=vbd_max
511 vgb_max=vgs_max
512 vgdr_max=vgd_max
513 vgsr_max=vgs_max
514 vgbr_max=vgb_max
515 vbsr_max=vbs_max
516 vbdr_max=vbd_max
```

类似的，[ngspice](https://ngspice.sourceforge.io/docs/ngspice-manual.pdf) 也给出了 6 个和 TSMC 28nm pdk 一样的 SOA 参数。

```
1. Vgs_max: If |Vgs| exceeds Vgs_max, SOA warning is issued.
2. Vgd_max: If |Vgd| exceeds Vgd_max, SOA warning is issued.
3. Vgb_max: If |Vgb| exceeds Vgb_max, SOA warning is issued.
4. Vds_max: If |Vds| exceeds Vds_max, SOA warning is issued.
5. Vbs_max: If |Vbs| exceeds Vbs_max, SOA warning is issued.
6. Vbd_max: If |Vbd| exceeds Vbd_max, SOA warning is issued.
```

但是有许多电压域完全无法检测出的危险错误，例如：

> [!CAUTION]
> 
> 如果我们将 `pch_mac` bulk 的 n-well 接在 GND 上，导致 PMOS 的 parasitic diode 导通，产生数 A 乃至 kA 级别的电流时。因为 |Vbd| 没有 exceeds Vbd_max，所以并不会有任何 SOA warning 被抛出。而 spectre 支持的 `vbdr_max` 等反向最大电压参数，也没有被包括 TSMC 28nm pdk 在内的大部分 pdk 所采用。所以此时仿真在 0 warning 中“正常”结束。

其实 spectre 对于 pn junction 提供了 `imax` 和 `imelt` 两个参数（详见 Spectre Classic Simulator, Spectre APS, Spectre X, and Spectre XPS User Guide `spectreuser.pdf`），但是 TSMC 28nm pdk 和上文示例电路在默认设置下的仿真并没有成功触发任何 warning，可能是因为 pdk 中没有对这些参数的定义。可以参考 edaboard 的更多信息：[1](https://www.edaboard.com/threads/warning-message-during-simulation-in-cadence.260315/)[2](https://www.edaboard.com/threads/simulating-power-electronics-in-spectre-imax-imelt-warnings.222730/)[3](https://www.edaboard.com/threads/problem-when-using-ndmos-as-switches-at-charge-pump-design.188318/)[4](https://www.edaboard.com/threads/cadence-warning-message-about-current-exceeding-imax-realistic-importance.303891/)，官方论坛也有人[提及](https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/21492/imax-and-imelt-error-in-spectre)。
