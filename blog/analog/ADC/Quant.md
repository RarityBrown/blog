# 量化

## 量化噪声

### 离散时间分析

直接看经典教材吧

### 连续时间分析

> 本部分假设读者具有基础的信号和通信背景知识
> 
> 本部分大量使用 AI 辅助创作，但是已由人工仔细审核和重排

#### 信号与采样

1.  **原始信号**: $x(t)$，其频谱为 $X(\omega)$，并且带限于 $|\omega| < \omega_B$。
2.  **采样操作**: 通过乘以一个冲激串 $s(t) = \sum_{n=-\infty}^{\infty} \delta(t - nT_s)$ 来实现，其中 $T_s = 2\pi/\omega_s$。
3.  **采样后信号**: $x_s(t) = x(t) \cdot s(t)$。
4.  **采样信号频谱**: $X_s(\omega) = \frac{1}{T_s} \sum_{k=-\infty}^{\infty} X(\omega - k\omega_s)$。这表示原始频谱以 $\omega_s$ 为周期进行了复制

"这里缺少经典老图一张.png"

#### 连续时间量化噪声和噪声序列的功率

量化器作用于采样后信号 $x_s(t)$ 的每一个冲激的“幅度” $x(nT_s)$。我们可以将量化过程建模为一个加性误差。

- **量化后的信号**: $x_q(t) = \sum_{n=-\infty}^{\infty} Q[x(nT_s)] \delta(t - nT_s)$ 其中 $Q[\cdot]$ 是量化函数
- 我们可以将 $x_q(t)$ 分解为理想采样信号和误差信号之和：$x_q(t) = x_s(t) + e(t)$
- 这里的 **量化误差信号 $e(t)$** 是我们分析的核心。它也是一个连续时间的冲激串： $e(t) = x_q(t) - x_s(t) = \sum_{n=-\infty}^{\infty} (Q[x(nT_s)] - x(nT_s)) \delta(t - nT_s)$
- 令 $e[n] = Q[x(nT_s)] - x(nT_s)$ 为在第 $n$ 个采样时刻的量化误差值，则 $e(t) = \sum_{n=-\infty}^{\infty} e[n] \delta(t - nT_s)$ 这个表达式的形式和采样信号 $x_s(t)$ 完全一样，只是冲激的幅度从信号值 $x(nT_s)$ 变成了误差值 $e[n]$

为了分析 $e(t)$ 的频谱，我们需要对 $e[n]$ 的统计特性做出一些标准假设：
1.  **白噪声**: $e[n]$ 序列是不相关的。即 $E[e[n]e[m]] = 0$ 对于 $n \neq m$。
2.  **与信号不相关**: $e[n]$ 与原始信号 $x(t)$ 不相关。
3.  **均匀分布**: $e[n]$ 在 $[-\Delta/2, \Delta/2]$ 之间均匀分布，其中 $\Delta$ 是量化步长。

根据这些假设，我们可以计算出 $e[n]$ **序列**的平均功率 (**方差**): $\sigma_e^2 = E[e[n]^2] = \int_{-\Delta/2}^{\Delta/2} e^2 \frac{1}{\Delta} de = \frac{\Delta^2}{12}$

#### 通过自相关函数求 PSD

我们将使用**维纳-辛钦定理 Wiener-Khinchin Theorem **求 PSD，该定理指出，一个**广义平稳**随机过程的功率谱密度是其自相关函数的傅里叶变换。所以我们要先求自相关函数：

$$
\begin{aligned}
R_{ee}(t,\tau)
& = E[e(t) e(t+\tau)] \\
& = E\left[ \left( \sum_{n=-\infty}^{\infty} e_n \delta(t - nT_s) \right) \left( \sum_{m=-\infty}^{\infty} e_m \delta(t + \tau - mT_s) \right) \right] \\
& = \sum_{n=-\infty}^{\infty} \sum_{m=-\infty}^{\infty} E[e_n e_m] \delta(t - nT_s) \delta(t + \tau - mT_s) \\
& = \sum_{n=-\infty}^{\infty} \sigma_e^2 \delta(t - nT_s) \delta(t + \tau - nT_s)
\end{aligned}
$$

因为 $f(t) \delta(t-nT_s) = f(nT_s) \delta(t-nT_s)$ , 所以上式

$$
\begin{aligned}
R_{ee}(t,\tau)
& = \sum_{n=-\infty}^{\infty} \sigma_e^2\delta(t + \tau - nT_s)\delta(t - nT_s) \\
& = \sigma_e^2 \delta(\tau) \sum_{n=-\infty}^{\infty} \delta(t - nT_s)
\end{aligned}
$$

这个结果仍然依赖于 $t$，这表明 $e(t)$ 是一个周期平稳（cyclostationary）过程。

##### Cyclostationary

> [!NOTE]
>
> 这里不严谨地直接给出所谓的 “时间平均”，感兴趣的读者可以仔细研究

为了得到广义平稳过程的自相关函数，我们需要对其进行时间平均。对 $t$ 在一个周期 $T_s$ 内积分再除以 $T_s$ 

$$
\overline{R_{ee}(\tau)} = \frac{1}{T_s} \int_0^{T_s} R_{ee}(t,\tau) dt = \frac{1}{T_s} \int_0^{T_s} \left( \sigma_e^2 \delta(\tau) \sum_{n=-\infty}^{\infty} \delta(t - nT_s) \right) dt
$$

由于在一个周期内 (例如从 0 到 $T_s$ ), $\sum \delta(t-nT_s)$ 中只有一个冲激 (在 $t=0$ 或 $t=T_s$ ) , 其积分为1。

$$
\overline{R_{ee}(\tau)} 
= \frac{1}{T_s} \int_0^{T_s} \left( \sigma_e^2 \delta(\tau) \sum_{n=-\infty}^{\infty} \delta(t - nT_s) \right) dt
= \frac{\sigma_e^2 \delta(\tau)}{T_s} \int_0^{T_s} \delta(t-0) dt = \boxed{\frac{\sigma_e^2}{T_s} \delta(\tau)}
$$

这个结果的物理意义是：量化噪声冲激串只在时间延迟 $\tau=0$ 时与自身相关，这正是连续时间白噪声的特征。

Wiener-Khinchin Theorem 指出，功率谱密度有：

$$
S_{ee}(\omega) 
= \mathcal{F}\{\overline{R_{ee}(\tau)}\} 
= \int_{-\infty}^{\infty} \overline{R_{ee}(\tau)} e^{-j\omega\tau} d\tau
= \int_{-\infty}^{\infty} \frac{\sigma_e^2}{T_s} \delta(\tau) e^{-j\omega\tau} d\tau
= \frac{\sigma_e^2}{T_s}
= \boxed{\frac{\Delta^2/12}{T_s}}
$$

对于连续时间 δ 采样模型而言，未经过任何带限滤波的“量化误差冲激串”在数学上不是一个具有有限功率的普通信号

- 时域角度: $e(t)=∑ e_n δ(t−nT_s)$  平方意义下涉及 $δ(t)^2$ 所以 $E[e(t)^2]$ 不存在
- 频域角度: 其“总功率”在全频积分下发散。所有“理想白噪声（无限带宽）”一致：总功率无限，仅带内功率可谈。

#### 理想重建模拟信号

为了从采样信号中恢复出原始的模拟信号，我们使用一个理想的低通重建滤波器 $H_r(\omega)$。它的作用是选取基带（$k=0$）的频谱副本，并恢复其正确的幅度：

$$
H_r(\omega) = \begin{cases} T_s & |\omega| < \omega_s/2 \\ 0 & \text{其它} \end{cases}
$$

重建后的信号是 $y(t)=x_s * h_r(t)$, 重建后的噪声是 $n(t)=e(t) * h_r(t)$. 因此，输出的量化噪声的 PSD 为：

$$
S_n(\omega) = |H_r(\omega)|^2 S_e(\omega) = \begin{cases} T_s^2 \cdot \left(\frac{\sigma_e^2}{T_s}\right) = \sigma_e^2 T_s & |\omega| < \omega_s/2 \\ 0 & \text{其它} \end{cases}
$$

我们可以通过对输出噪声的 PSD 在整个 Nyquist 带宽内积分，来校核其总功率（使用双边带积分）：

$$
P_n = \frac{1}{2\pi} \int_{-\omega_s/2}^{\omega_s/2} \sigma_e^2 T_s d\omega = \frac{\sigma_e^2 T_s}{2\pi} (\omega_s) = \sigma_e^2 = \boxed{\frac{\Delta^2}{12}}
$$

这个结果表明，经过理想重建后，分布在 Nyquist 带宽 $|\omega| < \omega_s/2$ 内的总量化噪声功率等于单次采样误差的方差。

#### 观察带内噪声功率

在实际应用中，我们通常只关心信号所在的有效带宽，设其为 $|\omega| \le \omega_B$，其中 $\omega_B < \omega_s/2$。我们可以通过一个更窄的低通滤波器来滤除带外噪声。此时，我们只计算这个频带内的噪声功率（读者可以思考为什么是对 $S_n(\omega)$ 积分，而不是对 $S_{ee}(\omega)$ 积分？）：

$$
\begin{align*}
P_n(\omega_B) &= \frac{1}{2\pi} \int_{-\omega_B}^{\omega_B} S_n(\omega) d\omega \\
              &= \frac{1}{2\pi} \cdot (\sigma_e^2 T_s) \cdot (2\omega_B) \\
              &= \sigma_e^2 \cdot \frac{2\omega_B}{\omega_s} \\
              &= \frac{\Delta^2}{12} \cdot \frac{2\omega_B}{\omega_s}
\end{align*}
$$

我们定义**过采样比 (Oversampling Ratio, OSR)** 为采样率与信号Nyquist采样率的比值：

$$
\text{OSR} = \frac{f_s}{2f_B} = \frac{\omega_s}{2\omega_B}
$$

于是，带内噪声功率可以表示为：

$$
P_n(\omega_B) = \frac{\Delta^2/12}{\text{OSR}}
$$

这个公式表明，**带内的量化噪声功率与OSR成反比**。采样率 $\omega_s$ 每提高一倍（OSR 变为原来的 2 倍），带内量化噪声功率 $P_n$ (平台高度) 就会减半，即降低约 $3 \text{ dB}$

我们可以将此模型与标准的信噪比（SNR）公式联系起来。

- 假设输入是一个满幅正弦信号，其幅值为 $A$。信号功率为 $P_s = A^2/2$
- 带内量化噪声功率为 $P_n(\omega_B) = (\Delta^2/12)/\text{OSR}$
- 在带宽 $\omega_B$ 内测量的一个具有 $N$ 位的对称均匀量化器，满幅正弦信号 $A=2^N \Delta / 2$ 有：

$$
\begin{align*}
\text{SNR}_\text{dB} &= 10\log_{10}\left[ \frac{P_s}{P_n(\omega_B)} \right] \\
           &= 10\log_{10}\left[ \frac{A^2/2}{(\Delta^2/12)/\text{OSR}} \right] \\
           &= 10\log_{10}\left[ \frac{A^2/2}{\Delta^2/12} \right] + 10\log_{10}(\text{OSR}) \\
           &= 6.02N + 1.76 + 10\log_{10}(\text{OSR})
\end{align*}
$$

#### 简单建模

我们如何肉眼“看到”过采样对于理想 ADC 的 SNR 提高？以 8-bit 1G ADC 为例：

```python
todo
```
