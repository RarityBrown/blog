## Jitter and Jitter Simulation

### 所有 Jitter 类型一览

| 从测量 (仿真) 角度分类                                       | 从 Jitter 来源分类                                           |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/b5e68f68-e812-4eb6-afc9-f938715a3549) | ![](https://github.com/user-attachments/assets/a64b57d8-c402-47ba-8a10-fe80b96a3544) |

我们先从 Jitter 来源分类进行简单一览：

- Idea: consider the total jitter distribution as the combination of:
  - Deterministic Jitter (DJ) := any jitter with **bounded** distribution -> `tran`
    - Data Dependent Jitter (DDJ) 
      - Inter symbol Interference (ISI)
      - Crosstalk
      - Duty Cycle Distortion (DCD)
    - Sinusoidal jitter (SJ) / Power supply Induced Jitter (PSIJ)
  - Random Jitter (RJ) := any jitter with **unbounded** distribution (gaussian) -> `pss` + `pnoise`
    - Thermal Noise
    - Flicker Noise
  - The result of DJ and RJ is called Total Jitter (TJ) -> `tran` + tran noise enable

关于所谓的 bounded 和 unbounded 有：

- 我们把 Random Jitter (RJ) gaussian 叫做 *unbounded* 的原因是 gaussian distribution 在 $x\to\infty$ 是 $f_{PDF}(x)$ 只是趋近于 0，而不是 =0。所以理论上，抖动的 peak 可以达到无穷大，只是概率会随着幅度的增加而急剧下降
  - 所以只能使用 rms (1σ) 或者 3σ 等值来评估，而没有一个 peak (或者说 peak=∞, 但是这没有意义)
- 而 Deterministic Jitter 由于是 *bounded* 的，所以是存在 peak 的概念的

| bounded DJ                                                   | unbounded RJ                                                 | unbounded TJ                                                 |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/94148a76-8f62-4cbc-8cf5-8261726b83e5) | ![](https://github.com/user-attachments/assets/83d29041-1af6-4987-98a0-e9932d2b45f9) | ![](https://github.com/user-attachments/assets/e72ff0da-3a8c-451c-9951-e3ce0f58938e) |

上图都是采样多次后，得到的 jitter 分布图。



然后我们开始从测量 (仿真) 角度，理解 Absolute Jitter $\sigma_{\text{abs}}$, Phase Noise $L(f)$, 和 Accumulated Jitter $\sigma_{ACC}$ (特别地, period jitter)：

### Absolute Jitter $\sigma_{\text{abs}}$ (wrt ideal clock in time domain) (edge-to-reference jitter)

|                                                              |                                                              |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/ee510f59-7001-4f3a-b7ec-c47d909263f8) | ![](https://github.com/user-attachments/assets/3eaa0f72-38bc-4f6c-a20c-26984033fd3c) | ![](https://github.com/user-attachments/assets/c9b2bc8c-841b-4451-83fa-eeb100288b05) |


Absolute Jitter 是 real clock 和 **ideal** clock 的比较，即 time deviation with respect to ideal clock。所以在 Virtuoso 的 `abs_jitter()` 函数中存在 $T_{nom}$ 这个参数，算法即：

$$
J_{abs}(n)=t_n-n\cdot T_{nom}
$$

此处的单位是秒。如果未指定 $T_{nom}$ 时，Virtuoso 按照第一个沿和最后一个沿，生成每个周期完全相等的 ideal clock 作为参考。显然一个特定单点的 $J_{abs}(n)$ 值是没有意义的，所以我们需要多仿真几个沿，然后观察这些 $J_{abs}$ 的标准差 $\hat{\sigma}_{\text{abs}}$ :


```lisp
stddev( abs_jitter(Cliped "falling" 0.5 ?yUnit "s") )
```


- 其中 `Cliped` 建议是 `clip(VT("/VOUT") VAR("settle_time") VAR("tran_time"))` 后的稳态情况
- 此处省略 $T_{nom}$ 参数，让 Virtuoso 自动计算

事实上，此处得到的 $\hat{\sigma}_{\text{abs}}$ 也是一个随机分布，那么很自然的问题是，我们需要仿真多久才能得到可靠的结果？使得 

$$
\hat{\sigma}_{\text{abs}}\approx {\sigma}_{\text{abs}}
$$

对于很大的 $N$，样本标准差 $s=\hat{\sigma}$ ，即 `stddev( abs_jitter(Cliped "falling" 0.5 ?yUnit "s") )` 近似服从一个正态分布：

$$
s = \hat{\sigma} \sim \mathcal{N}\left(\sigma, \frac{\sigma^2}{2(N-1)}\right)
$$

绝对估算误差 $|s - \sigma|$ 小于 $Q$ 倍的标准误差的数学表示是：

$$
|s - \sigma| \le Q \cdot \frac{\sigma}{\sqrt{2(N-1)}}
$$

相对误差即：

$$
\epsilon = \frac{|s - \sigma|}{\sigma} \le \frac{1}{\sigma} \cdot \left(Q \cdot \frac{\sigma}{\sqrt{2(N-1)}}\right) = \frac{Q}{\sqrt{2(N-1)}} 
\implies
N \ge \frac{1}{2}\left(\frac{Q}{\epsilon}\right)^2
$$

如果我们需要 $3\sigma$ 99.7% 的置信区间，1% 的相对误差，则需要仿真 45000 个沿；需要 2σ 5% 时，也还需要 800 个沿。在 100 个沿的仿真条件下，2σ 的置信度只能保证测量的相对误差不超过 ±14.1%

#### 例一 Absolute Jitter $\sigma_{\text{abs}}$ 在 ADC Sampling 中的影响

很多书上都有了，暂略。



这似乎也是绝大部分书分析 jitter 对 adc 影响时，唯一分析的一种 jitter 类型

### 多种 jitter 名字的区别

在 ADC sampling 中，absolute jitter 又有另一个名字，叫做 aperture jitter. 事实上，在 Cadence 的 RAK 文档中是这样写的：

> The variation in the delay between a **triggering** event and a **response** event is the edge-to-edge timing jitter. It is also called as absolute or aperture jitter.

在 Cadence 文档 `JitterAN.pdf` 中的示意图更加清晰。但是，值得注意的是，这和 ISSCC 2012 T5 中提到的 "edge-to-edge jitter" 即 "period jitter" 并不一样。我们列出一个表格，来核对一些核心概念：

|                          | Absolute Jitter                                              | 后文将要提到的 Period Jitter                                 |
| ------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Cadence 文档中的称谓     | absolute jitter, *edge-to-edge* jitter (`Jee`) (下图, 指 reference edge i to true edge i), aperture jitter | cycle jitter (`Jc`),  period jitter                          |
| Cadence 文档中示意图     | ![](https://github.com/user-attachments/assets/8e64f945-f332-411c-b812-a1e8a3f4abdb) | ![](https://github.com/user-attachments/assets/cad4de35-9850-4f2d-9205-49f5f2729466) |
| Cadence 文档中的算法     | $\qquad\qquad\qquad\qquad \sqrt{\text{Var}(t_i)}\qquad\qquad \qquad\qquad$ | $\small\sqrt{\text{Var}(t_{i+1}-t_i)}=\sqrt{\text{Var}(t_{i+1}-t_i)-(t_{i+1,ideal}-t_{i,ideal})}$ <br /> $=\sqrt{\text{Var}(j_{abs}(n+1)-j_{abs}(n))}$ |
| ISSCC 2012 T5 中的称谓   | absolute jitter, edge-to-reference jitter                    | period jitter, *edge-to-edge* jitter (下图, 指 edge n to edge n+1) |
| ISSCC 2012 T5 中的示意图 | ![](https://github.com/user-attachments/assets/ee510f59-7001-4f3a-b7ec-c47d909263f8) | ![](https://github.com/user-attachments/assets/242b6514-05c7-4234-89a2-f6246b7bf9e2) |
| 一些 ADC 文档中的称谓    | aperture jitter                                              |                                                              |
| 一些其他说法             | TIE jitter, edge-to-reference, edge-reference TIE            |                                                              |

我们这里暂且对 Period Jitter 不做任何说明。目前我们只要知道，在 Cadence 中 absolute jitter = Jee 即可。

### Phase Noise in Frequency Domain

$$
\begin{aligned}
V(t) 
=& A \cdot \sin(\omega_0 t + \varphi(t))  \\
=& A \cdot [\sin(\omega_0 t)\cos(\varphi(t)) + \cos(\omega_0 t)\sin(\varphi(t))] \\
\xlongequal{\text{Small angle modulation: }\varphi(t) \ll 1} & A \cdot [\sin(\omega_0 t) \cdot 1 + \cos(\omega_0 t) \cdot \varphi(t)] \\
=& \underbrace{A \cdot \sin(\omega_0 t)}_{\text{Carrier}} + \underbrace{A \cdot \varphi(t) \cdot \cos(\omega_0 t)}_{\text{Noise Sidebands}}
\end{aligned}
$$

假设 $\varphi(t)$ 的双边 PSD 是 $S_{\varphi,\text{dss}}(f)$ ，则噪声的双边 PSD 就是 $S_{vn}(f) = \dfrac{A^2}{4} \cdot [S_{\varphi,\text{dss}}(f - f_0) + S_{\varphi,\text{dss}}(f + f_0)]$ 

$$
\begin{aligned}
&\text{Power of in 1 Hz BW @ } f \text{ from } f_0 \\
&= S_{vn}(f_0 + f) \\
&= \frac{A^2}{4} \cdot [S_{\varphi,\text{dss}}(f) + S_{\varphi,\text{dss}}(2f_0 + f)]  \\
&\approx \frac{A^2}{4}S_{\varphi,\text{dss}}(f)
\end{aligned}
$$

可以得到相噪

$$
\text{Phase Noise}
= L(f)
= \frac{\text{Power at } (f_0 + f) \text{ in 1 Hz bandwidth}}{\text{Power of Carrier}}
= \frac{\frac{A^2}{4}S_{\varphi,\text{dss}}(f)}{A^2/2}
= \frac{S_{\varphi,\text{dss}}(f)}{2}
$$



#### Phase Noise $L(f)$ to Absolute Jitter $\sigma_{\text{abs}}$


$$
V(t) = A \cdot \sin(\omega_0 t + \varphi(t)) = A \cdot \sin\left[\omega_0 \left(t + \smash[b]{\underbrace{\frac{\varphi(t)}{\omega_0}}_{\displaystyle j_{\text{abs}}}}\right)\right] \\\\
$$

$$
j_{ABS} = \frac{\varphi}{\omega_0} 
\xRightarrow{\text{PSD}} S_{j_{ABS}}(f) = \frac{L(f)}{\omega_0^2}
\xRightarrow{\text{Wiener-Khinchin Theorem}}
\sigma_{ABS}^2 = \int_{-\infty}^{+\infty} S_{j_{ABS}}(f) \, df = \frac{2}{\omega_0^2} \int_{0}^{+\infty} L(f) \, \mathrm{d}f
$$

但是实际上，这样积分会有一些问题：

|                                                              |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/5e44f92c-f1c5-4f93-844b-32bcb8b54643) | ![](https://github.com/user-attachments/assets/bb9e9406-273d-4876-bfc4-7458811b3786) |

- 积分下界问题
  - 问题：close to the carrier the noise is normally dominated by components which goes like $\frac{1}{f^2}$ or $\frac{1}{f^3}$, like flicker noise or similar things. And you know from mathematics that if you try to integrate this kind of function close to 0 you get +∞, so you would diverge
  - 方案：I don't start integrating from 0 off-set from the carrier, but I start integrating from some minimum frequency. This minimum frequency of course has to be decided based on the system which is using this clock. 一般在仿真中从 1Hz 开始积分
- 积分上界问题：
  - 问题：you would take the power also of the next harmonics. So but you are not interested in this power and also you are not interested in the power of the noise in this region here because this belongs to the second harmonic. 
  - 方案：limit the integration of the phase noise to this limit here which is actually a limitation to $\dfrac{f_0}{2}$.

$$
\sigma_{ABS}^2 = \frac{2}{(2\pi f_0)^2} \int_{f_{MIN}=1\text{Hz}}^{\frac{f_0}{2}} L(f) \, \mathrm{d}f
$$

因此，这个 $\frac{f_0}{2}$ 并不是什么做 ADC 的人产生的 Nyquist 频率，而是一切 driven circuit (例如 divider, buffer, mux; 暂时不包括 autonomous circuit 例如 VCO)，在通过频域 phase noise 分析一个 $f_0$ 频率信号的时域 absolute jitter 时，在最终积分时需要填写的频率上界。例如 Jee Measurement Using PSS/Pnoise and Transient Noise Analysis RAK 中的设置：40MHz 的振荡频率，20MHz 的积分上界。所以，如果我们需要在 Virtuoso 中写的公式时：

```lisp
rfJitter(?result "pnoiseOut1_sample_pm0" ?unit "Second" ?from 1 ?to (VAR("f_0")/2) ?signalLevel "rms")
```

需要注意的是，实际上噪声谱的 y 轴有多种可能的单位，包括但不限于三种**电压噪声密度** $V_n(f)$ ：

```lisp
         getData("out" ?result "pnoise_sample_pm0")             ; Output Noise     ( V   /sqrt(Hz) )
     pow(getData("out" ?result "pnoise_sample_pm0") 2)          ; Output Noise     ( V**2/Hz       )
db10(pow(getData("out" ?result "pnoise_sample_pm0") 2))         ; Output Noise     ( dBV /Hz       )
```

这三种在 ADE 的 `Results - Direct Plot - Main Form` 中都对应 `Output Noise` ，这并不是我们前文公式所需要的 $L(f)$ 相位噪声。**相位噪声**的图像竖轴的单位应该是 dBc/Hz，对应的是 `Main Form` 中的 `Edge Phase Noise`：

```list
rfEdgePhaseNoise(?result "pnoise_sample_pm0" ?eventList 'nil)   ; Edge Phase Noise ( dBc /Hz       )
```

我们是在理论分析而不是在使用 EDA 时，如果需要对 $\frac{1}{f^3}, \frac{1}{f^2}, \frac{1}{f}$ 噪声进行分段积分，考虑到 $L(f)$ 往往是 log-log 轴，所以需要一些运算：

$$
\Large\text{Jitter}_{rms}(s) = \frac{1}{2\pi f_c} \sqrt{2 \sum_{i=0}^{N-1} \int_{f_i}^{f_{i+1}} 10^{\frac{1}{10} \left( L_{\text{dB}}(f_i) + \left( \frac{L_{\text{dB}}(f_{i+1}) - L_{\text{dB}}(f_i)}{\log_{10}(f_{i+1}) - \log_{10}(f_i)} \right) \cdot (\log_{10}(f) - \log_{10}(f_i)) \right)} \mathrm{d}f}
$$

MATLAB 提供了一个封装好的函数 `phaseNoiseToJitter` ：

```matlab
PNFreq = [100,1e3,1e4,200e6];  # -125 dBc/Hz at 100 Hz, -150 dBc/Hz at 1 kHZ, -174 dBc/Hz at 10 kHz, -174 dBc/Hz at 200 MHz
PNPow = [-125,-150,-174,-174];
[Jrms_rad Jrms_deg Jrms_sec] = phaseNoiseToJitter(PNFreq,PNPow,'Frequency',100e6)  # a signal of 100 MHz frequency
# Jrms_rad = 4.0430e-05
# Jrms_deg = 0.0023
# Jrms_sec = 6.4346e-14
```

当然，如果我们不想使用 ADE 自带的函数，即上文提到的 `rfJitter` 来进行自动积分时；可以在 ADE 中手动验证 $\text{jitter} = \sqrt{\frac{2}{(2\pi f_0)^2} \int_{f_{MIN}=1\text{Hz}}^{\frac{f_0}{2}} L(f) \mathrm{d}f}$ 的正确性：

```list
Lf            = rfEdgePhaseNoise(?result "pnoise_sample_pm0" ?eventList 'nil)
int_Lf_linear = integ((10**(Lf / 10)) 1 (VAR("f_0") / 2) " ")
f_term        = (2 / ((2 * pi * VAR("f_0"))**2))
jitter        = sqrt((f_term * int_Lf_linear))
```

这种方式得到的 jitter 在数值上应该和 `rfJitter(?result "pnoiseOut1_sample_pm0" ?unit "Second" ?from 1 ?to (VAR("f_0")/2) ?signalLevel "rms")` 是一模一样的。


#### 例二 Jitter filtering in CDR systems: 一种更精准的积分方法 phase

更好的方案：

> A better way to do this to overcome these problems is to understand what is the jitter transfer function of the system under investigation. So this clock is going into some system and this system has some sensitivity to clock jitter frequencies. Hopefully your system will not be sensitive to jitter frequencies which are very low. So close to the carrier. So if you are able to find the jitter transfer function of your system, the best thing you can do then is to multiply the phase noise by the square of the transfer function of the system and then integrate from zero to plus infinite. I will show now how to apply this concept here to an application taken from

暂略，详见 ISSCC 2012 T5



#### PLL 中的例子

暂略，不是笔者的研究方向





### Absolute Jitter in Simulation

行文至此，我们可以思考一下，

```lisp
stddev( abs_jitter(Cliped "falling" 0.5 ?yUnit "s") )
rfJitter(?result "pnoiseOut1_sample_pm0" ?unit "Second" ?from 1 ?to (VAR("f_0")/2) ?signalLevel "rms")
```

两种方式的算出的 absolute jitter 理论上应该完全一样吗？我们再回到之前的 Total Noise = Deterministic Jitter and Random Jitter, 或者如前文所述，更准确地是卷积：

$$
\text{Total Noise} = \text{Deterministic Jitter } {\Large{*}} \text{ Random Jitter}
$$

这是因为当 RJ 和 DJ 相互独立时，有

$$
f_{TJ}(z) = (f_{RJ} * f_{DJ})(z) = \int_{-\infty}^{\infty} f_{RJ}(x) f_{DJ}(z-x) dx
$$

对于 jitter 之间的关系则有：

$$
\sigma_{abs, TJ}^2 = \sigma_{abs, DJ}^2 + \sigma_{abs, RJ}^2
$$

**tran noise 的问题** 

如果我们在 tran 仿真中没有启用 tran noise 时仿出来的 jitter 大概率是一个非 Gaussian 分布的 rms 值

**样本数量的问题**

另外，我们之前也提到了，当我们需要 5% 的置信区间时，我们需要 tran 仿真 800 个沿。tran 仿真数量较小的时候，得出的 `stddev( abs_jitter( Cliped "falling" 0.5) )` 值是毫无意义的。

更致命的是，上面的推导有一个至关重要的前提：每一个抖动样本 $j_{abs}(n)$ 都是相互独立的。但是当我们不开噪声时，所有的 DJ 显然不是独立的；即使开启噪声后，1/f  噪声在低频段具有极高的功率。在时域上，这意味着噪声信号具有很强的长期相关性。换句话说，电路在某个时刻的状态会受到很久之前噪声的影响。这导致连续几个、甚至几百个周期的抖动样本之间是高度相关的，而不是独立的。800 个沿的估计只是一个至少的底线了。

**pnoise 问题**

当然，pnoise 也容易出现问题，例如[这篇问题文章](https://blog.csdn.net/m0_62489442/article/details/144940946)中 pnoise 的仿真结果比 tran noise 好不少就是 pnoise 的仿真设置有误。只要 pnoise 的仿真设置有误，最直观的体现就是 jitter 反而比 tran noise 仿真出来的要好。noise 的仿真要格外注意，因为几乎所有的错误设置都会使得仿真结果反而变好（也包括 tran noise）。

### Accumulated Jitter (self-referenced in time domain)

|                                                              |                                                              |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/9ee94732-1cd5-481f-b7eb-41db536b0505) | ![](https://github.com/user-attachments/assets/9d2fb02a-405a-46db-a3e9-96759382e48d) | ![](https://github.com/user-attachments/assets/242b6514-05c7-4234-89a2-f6246b7bf9e2) |

所以

$$
\begin{aligned}
\sigma_{ACC}^2(N) 
&= \text{Var}(j_{ACC}(N))  \\
&= \text{Var}(j_{ABS}(n+N) - j_{ABS}(n)) \\
&= \text{Var}(j_{ABS}(n+N)) + \text{Var}(j_{ABS}(n)) - 2 \cdot \text{Cov}(j_{ABS}(n+N), j_{ABS}(n))
\end{aligned}
$$

对于一个稳定的时钟信号，我们通常假设其抖动是一个宽义平稳过程 (Wide-Sense Stationary Process)，即它的统计特性（比如平均值和方差）不随时间变化。所以：

$$
\sigma_{ACC}^2(N) = 2\sigma_{ABS}^2 - 2 \cdot \text{Cov}(j_{ABS}(n+N), j_{ABS}(n))
$$

当 $N\gg1$ 时，这意味着我们正在比较两个在时间上相距很远的抖动样本。对于大多数物理噪声源（如热噪声），其影响是短暂的，其相关性会随着时间间隔的增大而迅速衰减。我们可以认为第 n 个边沿的抖动和第 n+N 个边沿的抖动是完全不相关的。所以：

$$
\sigma_{ACC}^2(N) \xlongequal{\displaystyle N\gg 1} 2\sigma_{ABS}^2
$$

#### Period Jitter

特别地，对于 $N=1$ 的情况，我们可获得 Period Jitter, $\sigma_{PER}$ (即 Cadence 中的 `Jc` )

$$
\hat{\sigma}_{PER} = \hat{\sigma}_{ABS} \sqrt{2(1 - \rho)}
$$

其中 $-1 ≤ ρ ≤ 1$ 是相邻两次 absolute jitter 间的相关系数。如果抖动是完全不相关的，即随机抖动 (Random Jitter, RJ)，表现为白噪声特性，每个边沿的抖动都独立于前一个边沿，则有

$$
\hat{\sigma}_{PER} = \sqrt{2} \cdot \hat{\sigma}_{ABS}
$$

在实际电路中，抖动通常是相关的。低频的相位噪声会导致相邻边沿的抖动值非常接近。如果抖动变化很慢 (例如，低频漂移)，那么 $j_{ABS}(n+1)$ 会非常接近 $j_{ABS}(n)$，相关系数 $\rho$ 趋近于 1。此时，**$\hat{\sigma}_{PER}$ 会变得非常小**。这是符合直觉的：如果时钟整体向左或向右漂移，但每个周期的长度保持不变，那么 absolute jitter (wrt ideal clock) 很大，而 period jitter 很小。



### 其他例子



Serial Data Sampling，暂略，放一张图：



![](https://github.com/user-attachments/assets/32a4316d-48d1-4781-9687-d02123896814)



在数字系统里，误码率往往要 $10^{-12}$ 以下，所以其实看似很足够的 $\pm6\sigma$ 范围是不够的



<details>
<summary>code</summary>

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
import matplotlib.patches as mpatches

mean = 0
std_dev = 1
x = np.linspace(mean - 8 * std_dev, mean + 8 * std_dev, 1000)
y = norm.pdf(x, mean, std_dev)
fig, ax1 = plt.subplots(figsize=(16, 6))

label_fontsize = 24
tick_fontsize = 20
text_fontsize = 20
legend_fontsize = 22

ax1.set_xlabel("X-axis (Standard Deviations)", fontsize=label_fontsize)

ax1.axvspan(-6, 6, alpha=0.15, color='skyblue')
ax1.axvspan(-3, 3, alpha=0.15, color='lightgreen')
ax1.axvspan(-1, 1, alpha=0.15, color='lightcoral')

color1 = 'blue'
ax1.set_ylabel("Probability Density (Linear Scale)", color=color1, fontsize=label_fontsize)
line1 = ax1.plot(x, y, color=color1, label='Linear Scale', linewidth=2.5)
ax1.tick_params(axis='y', labelcolor=color1, labelsize=tick_fontsize)
ax1.tick_params(axis='x', labelsize=tick_fontsize)
ax1.grid(True, which='major', axis='both', linestyle='-')

ax2 = ax1.twinx()
color2 = 'green'
ax2.set_ylabel("Probability Density (Log Scale)", color=color2, fontsize=label_fontsize)
line2 = ax2.plot(x, y, color=color2, linestyle='-', label='Log Scale', linewidth=2.5)
ax2.set_yscale('log')
ax2.tick_params(axis='y', labelcolor=color2, labelsize=tick_fontsize)

sigma_levels = [1, 3, 6]
right_x_limit = ax1.get_xlim()[1]

for sigma in sigma_levels:
    y_at_sigma = norm.pdf(sigma, mean, std_dev)
    ax2.plot([-sigma, right_x_limit], [y_at_sigma, y_at_sigma], color='black', linestyle=':', linewidth=2)
    ax2.plot([-sigma, sigma], [y_at_sigma, y_at_sigma], 'o', markersize=10, color='red')
    ax2.text(right_x_limit - 0.2, y_at_sigma * 1.5, f'{sigma}σ Level ({y_at_sigma:.2e})', 
             verticalalignment='bottom', horizontalalignment='right', 
             color='black', fontsize=text_fontsize)

patch1 = mpatches.Patch(color='lightcoral', alpha=0.3, label='1σ (68.3%)')
patch3 = mpatches.Patch(color='lightgreen', alpha=0.3, label='3σ (99.7%)')
patch6 = mpatches.Patch(color='skyblue', alpha=0.3, label='6σ (99.9999998%)')
all_handles = line1 + line2 + [patch1, patch3, patch6]
ax1.legend(handles=all_handles, loc='upper left', fontsize=legend_fontsize)

fig.tight_layout()
plt.show()
```

</details>


## 后记

不同地方对于 jitter 的名称不太一样，对于笔者造成了一定的困惑，同时网上 Virtuoso 仿真的方法也是只授人以鱼。所以有了这篇文章，希望能帮助读者理清不同的 jitter 类型，授人以渔。


核心参考资料：

- ISSCC 2012 T5 by Nicola Da Dalt: JITTER basic and advanced concepts, statistics and applications
- ESSCIRC 2019 T by Nicola Da Dalt: Jitter in Wireline and Data Converter Applications Presented
- ESSCIRC 2019 T by Ali Sheikholeslami: Fundamental Concepts in Jitter and Phase Noise Presented
- *Understanding Jitter and Phase Noise: A Circuits and Systems Perspective* by Nicola Da Dalt & Ali Sheikholeslami


其他参考 ref: 

1. ISSCC 2025 T2: Fundamentals of DRAM I/O : Standards & Circuits
2. ADI MT-007: Aperture Time, Aperture Jitter, Aperture Delay Time - Removing the Confusion by Walt Kester
3. ADI MT-008: Converting Oscillator Phase Noise to Time Jitter by Walt Kester 
   1. [倔强的砖工](https://zhuanlan.zhihu.com/p/605435397)介绍与评论区
4. [`phaseNoiseToJitter`- MATLAB](https://www.mathworks.com/help/msblks/ref/phasenoisetojitter.html)

Cadence reference available in offline doc: 

1. `vivaxlug.pdf`: Virtuoso Visualization and Analysis XL User Guide
2. `spectreRFinExplorer.pdf`: Spectre Circuit Simulator and Accelerated Parallel Simulator RF Analysis in ADE Explorer User Guide
3. `JitterAN.pdf`: Jitter Measurements Using SpectreRF Application Note
   1. eetop link: [JitterAN.book](https://picture.iczhiku.com/resource/eetop/sYKhSYjZLJZoTBCx.pdf)

Cadence reference available online:

1. Jee Measurement Using PSS/Pnoise and Transient Noise Analysis Rapid Adoption Kit (RAK)
   1. cadence public link: https://support1.cadence.com/public/docs/content/20483291.html
   2. cadence support link: https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1O0V000009EVE2UAO
   3. eetop link: https://bbs.eetop.cn/thread-976083-1-1.html
2. Summary of Study of Cadence Sampled Phase Noise and Jitter Definitions with a Comparison to Conventional Time Interval Error (TIE) for a Driven Circuit, Shawn Logan
   1. https://community.cadence.com/cadence_technology_forums/f/rf-design/56894/jee-measurement
3. unknown 
   1. https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1O3w000009bh2QEAQ
   2. https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1Od0000000nTk7EAE
