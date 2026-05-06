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

## Operating-Point Parameters (Virtuoso)

### Capacitances

| Parameter | Unit| BSIM4 Description | BSIM-BULK Description |
| :--- | :--- | :--- | :--- |
| `cbb` | (F) | Bulk capacitance, including intrinsic and overlap components. | Total body capacitance. |
| `cbbi` | (F) | - | Intrinsic body capacitance. |
| `cbd` | (F) | Intrinsic bulk-to-drain capacitance. | Total body-to-drain capacitance. |
| `cbdbo` | (F) | CBDBO = -dQb/dVd intrinsic bulk-to-drain capacitance (alias=lx22). | - |
| `cbdi` | (F) | - | Intrinsic body-to-drain capacitance. |
| `cbg` | (F) | Total bulk-to-gate capacitance, including intrinsic and overlap components (alias=lx88). | Total body-to-gate capacitance. |
| `cbgbo` | (F) | CBGBO = -dQb/dVg intrinsic bulk-to-gate capacitance (alias=lx21). | - |
| `cbgi` | (F) | - | Intrinsic body-to-gate capacitance. |
| `cbs` | (F) | Intrinsic bulk-to-source capacitance. | Total body-to-source capacitance. |
| `cbsbo` | (F) | CBSBO = -dQb/dVs intrinsic bulk-to-source capacitance (alias=lx23). | - |
| `cbsi` | (F) | - | Intrinsic body-to-source capacitance. |
| `cdb` | (F) | Intrinsic drain-to-bulk capacitance. | Total drain-to-body capacitance. |
| `cdbi` | (F) | - | Intrinsic drain-to-body capacitance. |
| `cdd` | (F) | Drain capacitance, including intrinsic, overlap, and fringing components. | Total drain capacitance. |
| `cddbo` | (F) | CDDBO = dQd/dVd intrinsic drain capacitance (alias=lx33). | - |
| `cddi` | (F) | - | Intrinsic drain capacitance. |
| `cdg` | (F) | Total drain-to-gate capacitance, including intrinsic, overlap, and fringing components (alias=lx87). | Total drain-to-gate capacitance. |
| `cdgbo` | (F) | CDGBO = -dQd/dVg intrinsic drain-to-gate capacitance (alias=lx32). | - |
| `cdgi` | (F) | - | Intrinsic drain-to-gate capacitance. |
| `cds` | (F) | Total drain-to-source capacitance (alias=lx86). | Total drain-to-source capacitance. |
| `cdsbo` | (F) | CDSBO = -dQd/dVs intrinsic drain-to-source capacitance (alias=lx34). | - |
| `cdsi` | (F) | - | Intrinsic drain-to-source capacitance. |
| `cgb` | (F) | Total gate-to-bulk capacitance, including intrinsic and overlap components. | Total gate-to-body capacitance. |
| `cgbi` | (F) | - | Intrinsic gate-to-body capacitance. |
| `cgd` | (F) | Total gate-to-drain capacitance, including intrinsic, overlap, and fringing components (alias=lx83). | Total gate-to-drain capacitance. |
| `cgdbo` | (F) | CGDBO = -dQg/dVd intrinsic gate-to-drain capacitance (alias=lx19). | - |
| `cgdext` | (F) | - | External gate-to-drain capacitance. |
| `cgdi` | (F) | - | Intrinsic gate-to-drain capacitance. |
| `cgg` | (F) | Total gate capacitance, including intrinsic, overlap and fringing components (alias=lx82). | Total gate capacitance. |
| `cggbo` | (F) | CGGBO = dQg/dVg intrinsic gate capacitance (alias=lx18). | - |
| `cggi` | (F) | - | Intrinsic gate capacitance. |
| `cgs` | (F) | Total gate-to-source capacitance, including intrinsic, overlap, and fringing components (alias=lx84). | Total gate-to-source capacitance. |
| `cgsbo` | (F) | CGSBO = -dQg/dVs intrinsic gate-to-source capacitance (alias=lx20). | - |
| `cgsext` | (F) | - | External gate-to-source capacitance. |
| `cgsi` | (F) | - | Intrinsic gate-to-source capacitance. |
| `cjd` / `capbd` (`cjdt`) | (F) | Drain-bulk junction capacitance (alias=lx29). | Drain-to-substrate junction capacitance. |
| `cjs` / `capbs` (`cjst`) | (F) | Source-bulk junction capacitance (alias=lx28). | Source-to-substrate junction capacitance. |
| `cm` | (F) | Capacitance element 1 for QS model. | - |
| `cmb` | (F) | Capacitance element 2 for QS model. | - |
| `cmx` | (F) | Capacitance element 3 for QS model. | - |
| `co` | (F) | Output Drain-Source capacitance. | - |
| `covlgb` / `cgbov` | (F/m) / (F) | Gate-bulk overlap capacitances (alias=lv38). | Gate-to-substrate overlap capacitance. |
| `covlgd` | (F/m) | Gate-drain overlap and fringing capacitances (alias=lv37). | - |
| `covlgs` | (F/m) | Gate-source overlap and fringing capacitances (alias=lv36). | - |
| `csb` | (F) | Intrinsic source-to-bulk capacitance. | Total source-to-body capacitance. |
| `csbi` | (F) | - | Intrinsic source-to-body capacitance. |
| `csd` | (F) | Total source-to-drain capacitance. | Total source-to-drain capacitance. |
| `csdi` | (F) | - | Intrinsic source-to-drain capacitance. |
| `csg` | (F) | Total source-to-gate capacitance, including intrinsic, overlap, and fringing components. | Total source-to-gate capacitance. |
| `csgi` | (F) | - | Intrinsic source-to-gate capacitance. |
| `css` | (F) | Source capacitance, including intrinsic, overlap, and fringing components. | Total source capacitance. |
| `cssi` | (F) | - | Intrinsic source capacitance. |


### 2. Frequency, Gm, R

| Parameter | Unit| BSIM4 Description | BSIM-BULK Description |
| :--- | :--- | :--- | :--- |
| `fqslim` | (Hz) | QS model frequency limit. | - |
| `ft` | (Hz) | Unity current gain frequency at actual bias. | Unity current gain frequency at actual bias. |
| `fug` | (Hz) | Unity current gain frequency at actual bias. | Unity current gain frequency at actual bias. |
| `gbd` | (S) | Bulk-drain diode conductance (alias=lx10). | - |
| `gbs` | (S) | Bulk-source diode conductance (alias=lx11). | - |
| `gds` | (S) | Common-source output conductance (alias=lx8). | Common-source output conductance. |
| `gm` | (S) | Common-source transconductance (alias=lx7). | Common-source transconductance. |
| `gmb` | (S) | DC bulk transconductance. | - |
| `gmbs` | (S) | Body-transconductance (alias=lx9). | Body-transconductance. |
| `gmoveri` | (1/V) | Gm/Ids. | - |
| `gmoverid`| (1/V) | Gm/Ids. | Gm/Ids. |
| `go` | (S) | Common-source output conductance. | - |
| `rdeff` | (Ω) | Effective drain resistance. | - |
| `rgate` | (Ω) | MOS gate resistance. | - |
| `rgbd` | (Ω) | Gate bias-dependent resistance. | - |
| `ron` | (Ω) | On-resistance, includes the parasitical rs and rd. | On-resistance. |
| `rout` | (Ω) | AC output resistor. The parasitical rs and rd are excluded. | Output resistance. |
| `rseff` | (Ω) | Effective source resistance. | - |

### 3. Currents & Power

| Parameter | Unit| BSIM4 Description | BSIM-BULK Description |
| :--- | :--- | :--- | :--- |
| `Iavl` | (A) | Weak avalanche current. | - |
| `ib` | (A) | Total DC bulk current. | - |
| `ibe` | (A) | Total DC bulk current. | - |
| `ibulk` | (A) | Resistive bulk current. | - |
| `id` | (A) | Resistive drain current. | Total resistive drain current. |
| `idb` / `ibd` (`ijdb`) | (A) | DC drain-bulk current. | Drain-bulk junction current. |
| `ide` | (A) | Total DC drain current. | - |
| `ideff` | (A) | - | Effective drain current. |
| `idriftsatd`| (A)| - | Drift region saturation current. |
| `ids` | (A) | Resistive drain-to-source current. | Drain-source current. |
| `ig` | (A) | Total DC gate current. | - |
| `igb` | (A) | Gate-to-bulk tunneling current (alias=lx66). | Gate-to-bulk tunneling current. |
| `igbacc` | (A) | Gate-to-bulk tunneling current determined by ECB (alias=lx73). | - |
| `igbinv` | (A) | Gate-to-bulk tunneling current determined by EVB (alias=lx74). | - |
| `igcd` | (A) | Gate-to-channel (drain side) tunneling current (alias=lx68). | Gate-to-channel (drain side) tunneling current. |
| `igcs` | (A) | Gate-to-channel (source side) tunneling current (alias=lx67). | Gate-to-channel (source side) tunneling current. |
| `igd` | (A) | Gate-to-drain tunneling current (alias=lx39). | Gate-to-drain tunneling current. |
| `igdt` | (A) | Gate Dielectric tunneling current (alias=lx71). | - |
| `ige` | (A) | Total DC gate current. | - |
| `igeff` | (A) | - | Effective gate current. |
| `igidl` | (A) | Gate-induced drain leakage current (alias=lx70). | Gate-induced drain leakage current. |
| `igisl` | (A) | Gate-induced source leakage current. | Gate-induced source leakage current. |
| `igs` | (A) | Gate-to-source tunneling current (alias=lx38). | Gate-to-source tunneling current. |
| `is` | (A) | Total DC source current. | - |
| `isb` / `ibs` (`ijsb`) | (A) | DC source-bulk current. | Source-bulk junction current. |
| `ise` | (A) | Total DC source current. | - |
| `iseff` | (A) | - | Effective source current. |
| `isub` (`iii`) | (A) | Substrate current ( alias to LX69 ). | Impact ionization current. |
| `pwr` | (W) | Power at op point. | Power at op point. |

### 4. Charges

| Parameter | Unit| BSIM4 Description | BSIM-BULK Description |
| :--- | :--- | :--- | :--- |
| `qb` | (Coul) | Total bulk charge, including intrinsic and overlap components. | Body charge. |
| `qbi` | (Coul) | Intrinsic bulk charge. | Intrinsic bulk charge. |
| `qd` | (Coul) | Total drain charge, including intrinsic, overlap and fringing components. | Drain charge. |
| `qdi` | (Coul) | Intrinsic drain charge. | Intrinsic drain charge. |
| `qg` | (Coul) | Total gate charge, including intrinsic, overlap and fringing components. | Gate charge. |
| `qgdovl` | (Coul) | Gate-drain overlap and fringing charge. | - |
| `qgi` | (Coul) | Intrinsic gate charge. | Intrinsic gate charge. |
| `qgsovl` | (Coul) | Gate-source overlap and fringing charge. | - |
| `qinv` | (Coul) | Inversion charge. | - |
| `qjd` | (Coul) | Drain-bulk junction charge. | - |
| `qjs` | (Coul) | Source-bulk junction charge. | - |
| `qs` | (Coul) | Total source charge, including intrinsic, overlap and fringing components. | Source charge. |
| `qsi` | (Coul) | Intrinsic source charge. | Intrinsic source charge. |

### 5. Voltages

| Parameter | Unit| BSIM4 Description | BSIM-BULK Description |
| :--- | :--- | :--- | :--- |
| `vbs` | (V) | Bulk-source voltage. | Body-to-source voltage. |
| `vdb` | (V) | Drain-bulk voltage. | - |
| `vds` | (V) | Drain-source voltage. | Drain-to-source voltage. |
| `vdsat` (`vdssat`) | (V) | Drain-source saturation voltage (alias=lv10). | Drain-source saturation voltage. |
| `vdsat_marg` / `vsat_marg` | (V) | Vds margin. (Note: BSIM4 has both names for this) | Vds margin. |
| `vdss` | (V) | Drain saturation voltage at actual bias. | - |
| `vdst` | (V) | - | External drain-source voltage. |
| `vearly` | (V) | Equivalent early voltage. | Equivalent early voltage. |
| `vfbeff` | (V) | Effective Flat-band voltage. | - |
| `vgb` | (V) | Gate-bulk voltage. | - |
| `vgd` | (V) | Gate-drain voltage. | - |
| `vgs` | (V) | Gate-source voltage. | Gate-to-source voltage. |
| `vgst` | (V) | - | External gate-source voltage. |
| `vgt` (`vth_drive`)| (V) | effective gate drive voltage including back bias and drain bias effects. (Alias: vth_drive)| Effective gate drive voltage. |
| `vsb` | (V) | Source-bulk DC voltage. | Voltage between source and bulk (vs-vb). |
| `vsbt` | (V) | - | External source-bulk voltage. |
| `vth` (`lv9`) | (V) | Threshold voltage (alias=lv9). | Threshold Voltage. |
| `vth0` | (V) | Zero-bias threshold voltage, excluding back-bias (body effect) and drain-bias effect (DIBL). | - |

### 6. Others

| Parameter | Unit| BSIM4 Description | BSIM-BULK Description |
| :--- | :--- | :--- | :--- |
| `beff` | (A/V²) | Gain factor in saturation. | - |
| `betaeff` | (A/V²) | Effective beta (alias LV21). | - |
| `Ctype` | | Flag for channel type of MOSFET. 1: NMOS. -1: PMOS. | - |
| `leffcv` | (m) | - | Effective length for CV. |
| `OPdef` | | 1: Device Physics notation. 2: Circuit Simulator notation. | - |
| `pro_Gamma`| | Gamma. | - |
| `region` | triode | Estimated operating region. %Z outputs the number (0-4) in a rawfile. Possible values are off, triode, sat, subth and breakdown. | Estimated operating region. Spectre outputs number (0-4) in a rawfile. Possible values are off, triode, sat, subth and breakdown. |
| `reversed`| | Reverse mode indicator. Possible values are no and yes. | - |
| `SDint` | | Flag for source-drain interchange. 1: No S-D interchange, -1: S-D interchange. | - |
| `SDop` | | Operation mode related to channel type and drain-source voltage sign. Possible values are Forward and Reverse. | - |
| `self_gain`| | Transistor self gain. | Transistor self gain. |
| `tau1` | (s) | Time constant related to NQS first frequency pole. | - |
| `ueff` | | ueff. | - |
| `weffcv` | (m) | - | Effective width for CV. |
|  |  |  |  |
| `dtemp` | (C) / 0.0 C | Alias for trise. | Offset of device temperature. |
| `Dtsh` / `t_delta_sh` | (K) | Device temperature rise due to self-heating. | Device temperature by selfheating. |
| `Tk` / `t_total_k` (`tk`) | (K) | Absolute Device temperature including self-heating. | Device temperature in Kelvin. |
| `t_total_c`| (deg-C)| - | Device temperature in Celsius. |
| `trise` | (C) / 0.0 C | Temperature rise from ambient. | Alias of dtemp. |

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
