# What a Bode Plot Won't Tell You

### 当 $f_{in}\ll\frac{1}{2\pi RC}$ 时，将简单一阶低通网络视为延迟器


![img](https://github.com/user-attachments/assets/d4842bf4-cabc-450f-885f-ce15a945a6fa)

Bode plot 近似有：

- 在低频区 ($\tiny\textcolor{red}{f < 0.1f_c}$)：我们画一条水平直线在 0°
- 在高频区 ($\tiny\textcolor{red}{f > 10f_c}$)：我们画一条水平直线在 -90°
- 在过渡区 ($\tiny\textcolor{red}{0.1f_c < f < 10f_c}$)：我们画一条从 0° 到 -90° 的斜线，斜率为 -45°/per decade

但是 RC 电路的实际相频响应是

$$
\textcolor{blue}{
\phi(\omega) = -\arctan(\omega RC)
}
$$

我们对低频区重新近似：

$$
\phi(\omega) = 
\textcolor{blue}{ -\arctan(\omega RC) }
\textcolor{Orange}{ \xlongequal{\text{when }\omega\ll\frac{1}{RC}} - \omega RC }
$$

1.  **相位 $φ(ω)$ 不是一个常数0。** 相反，它是一个**随频率 $ω$ 线性变化**的量。频率越高（虽然仍在低频区内），相位的滞后角度就越大。
2.  **延迟 $τ = -φ(ω) / ω ≈ RC$ 是恒定的。**


或者我们从复频域的角度分析：

$$
\begin{aligned}
H(s) & = \frac{1}{1+sRC}  \xlongequal{\text{when }s \ll\frac{1}{RC}} \frac{1}{e^{sRC}}  \\
h(t) & = \frac{1}{RC}e^{-\frac{t}{RC}}u(t) \xlongequal{\text{when }s \ll\frac{1}{RC}} \delta(t-\underbrace{RC}_{\displaystyle\tau}) 
\end{aligned}
$$

<details>
<summary>code</summary>

```python
import numpy as np
import matplotlib.pyplot as plt

# --- 1. Circuit Parameters and Frequency Range ---
R = 1e3  # 1 kOhm
C = 1e-6  # 1 uF
RC = R * C  # Time constant
f_c = 1 / (2 * np.pi * RC)  # Cutoff frequency in Hz

# Frequency ranges for plotting
# A wide log range for Bode-style plots
f_log = np.logspace(np.log10(f_c) - 2, np.log10(f_c) + 2, 1000)
omega_log = 2 * np.pi * f_log
# A narrow linear range to show low-frequency behavior
f_lin = np.linspace(1e-3, f_c / 2, 500) # From near-zero up to half the cutoff frequency
omega_lin = 2 * np.pi * f_lin


# --- 2. Calculations ---
# Actual phase response (in degrees)
phi_actual_deg_log = np.degrees(-np.arctan(omega_log * RC))
phi_actual_deg_lin = np.degrees(-np.arctan(omega_lin * RC))

# Linear approximation of phase for the linear plot (phi ≈ -wRC)
phi_approx_deg_lin = np.degrees(-omega_lin * RC)

# Asymptotic phase response for the Bode plot
f_asymptotic = [0.1 * f_c, 10 * f_c]
phi_asymptotic = [0, -90]

# Delay calculations
# Phase Delay (tau_p = -phi / omega)
tau_p = -(-np.arctan(omega_log * RC)) / omega_log
# Group Delay (tau_g = -d(phi)/d(omega))
tau_g = RC / (1 + (omega_log * RC)**2)


# --- 3. Plotting ---
# Create a figure with 3 subplots, side-by-side
fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(21, 6))
fig.suptitle('Understanding RC Low-Pass Filter Delay', fontsize=16)

# == Plot 1: Phase Response: Actual vs. Asymptotic ==
ax1.semilogx(f_log, phi_actual_deg_log, label='Actual Response', color='royalblue', linewidth=2)
# Simplified asymptotic lines
ax1.plot([f_log[0], 0.1 * f_c], [0, 0], 'r--', label='Asymptotic Approx.')
ax1.plot([0.1 * f_c, 10 * f_c], [0, -90], 'r--')
ax1.plot([10 * f_c, f_log[-1]], [-90, -90], 'r--')
ax1.axvline(f_c, color='gray', linestyle=':', label=f'Cutoff f_c = {f_c:.1f} Hz')
ax1.scatter(f_c, -45, color='red', zorder=5)
ax1.text(f_c * 1.2, -42, '-45° at f_c', verticalalignment='center')
ax1.set_title('1. Phase Response: Actual vs. Asymptotic')
ax1.set_xlabel('Frequency (Hz) [log scale]')
ax1.set_ylabel('Phase (degrees)')
ax1.grid(True, which="both", ls='--')
ax1.legend()
ax1.set_ylim(-100, 10)

# == Plot 2: Low-Frequency Phase is Linear ==
ax2.plot(f_lin, phi_actual_deg_lin, label='Actual Phase: -arctan(ωRC)', color='royalblue', linewidth=2)
ax2.plot(f_lin, phi_approx_deg_lin, label='Linear Approx.: -ωRC', color='darkorange', linestyle='--', linewidth=2)
ax2.set_title('2. Low-Frequency Phase is Linear')
ax2.set_xlabel('Frequency (Hz) [linear scale]')
ax2.set_ylabel('Phase (degrees)')
ax2.grid(True, ls='--')
ax2.legend()

# == Plot 3: Constant Delay at Low Frequencies ==
ax3.semilogx(f_log, tau_p * 1e3, label='Phase Delay (τp)', color='green', linewidth=2)
ax3.semilogx(f_log, tau_g * 1e3, label='Group Delay (τg)', color='purple', linestyle='-.', linewidth=2)
ax3.axhline(RC * 1e3, color='red', linestyle=':', label=f'Constant Delay = RC = {RC*1e3:.1f} ms')
ax3.axvline(f_c, color='gray', linestyle=':', label=f'Cutoff f_c = {f_c:.1f} Hz')
ax3.set_title('3. Result: Constant Delay')
ax3.set_xlabel('Frequency (Hz) [log scale]')
ax3.set_ylabel('Delay (milliseconds)')
ax3.grid(True, which="both", ls='--')
ax3.legend()

# Final adjustments and display
plt.tight_layout(rect=[0, 0.03, 1, 0.95])
plt.show()
```

</details>
