
## Answer to the "problems" in the Razavi's 2025 ADC book.

### Chapter 3: Sampling Circuits

#### 3.1

$V_{in}(t)=V_0\cos(\omega_1t)u(t)$ passing through $H(s)=\frac{1}{1+sR_{on}C_1}$ gets: 

$$
\begin{aligned}
Y(s)
&=H(s)X(s) \\
&=\frac{1}{1+sR_{on}C_1}\cdot\mathcal L\lbrace V_0\cos(\omega_1t)u(t)\rbrace \\
&=\frac{1}{1+s\tau}\cdot\frac{V_0s}{s^2+\omega_1^2} \\
&=\frac{V_0s}{(1+s\tau)(s^2+\omega_1^2)} \\
&=\frac{\left(-\frac{V_0\tau}{1+\tau^2\omega_1^2}\right)}{1+s\tau}+\frac{\left(\frac{V_0}{1+\tau^2\omega_1^2}\right)s+\left(\frac{V_0\tau\omega_1^2}{1+\tau^2\omega_1^2}\right)}{s^2+\omega_1^2} 
\end{aligned}
\implies
\begin{aligned}
V_{out}(t)
&=\mathcal L^{-1}\{Y(s)\} \\
&=\frac{V_0\cdot u(t)}{1+(\omega_1\tau)^2}\left[\cos(\omega_1 t)+\omega_1\tau\sin(\omega_1 t)-e^{-t/\tau}\right]  \\
&=u(t)\left[\frac{V_0}{\sqrt{1+\tau^2\omega_1^2}}\cos\bigl(\omega_1 t-\arctan(\tau\omega_1)\bigr)-\frac{V_0}{1+\tau^2\omega_1^2}e^{-t/\tau}\right]
\end{aligned}
$$

#### 3.2

Omitted, ask for LLM please.

#### 3.3

(a): $R_{on,2W}=\frac{R_{on}}{2}=\frac{R_{on,avg}}{2}+\frac{\alpha_1}{2}\cos\omega_1t+\frac{\alpha_2}{2}\cos2\omega_1t+\cdots$

(b): halved

see [Iizuka, TCAS-I, 2018] to learn more

#### 3.4

Omitted

#### 3.5

In a properly designed track-and-hold circuit, the condition $\omega_1\ll\frac{1}{\tau}=\frac{1}{R_{on}(C_a+C_b\cos\omega_1t)}$ must be satisfied. Therefore, the RC network functions as a τ delay unit, resulting in a phase lag of $\omega_1\tau$ in the output signal:

$$
V_{out} \approx \frac{V_{DD}}{2} + \frac{V_{DD}}{2} \cos[\omega_1 t - R_{on}(C_a+C_b\cos\omega_1 t)\omega_1]
$$

(2) todo

#### 3.6 

$$
\Delta V 
= \frac{Q_{ch}}{C_H} 
= \frac{W L C_{ox} (V_{GS} - V_{TH})}{C_H}
= \frac{\left( \mu_nC_{ox}\dfrac{W}{L} (V_{GS} - V_{TH}) \right)\cdot \dfrac{L^2}{\mu_n}}{C_H}
= \dfrac{L^2}{\mu_n\tau}
$$

#### 3.7

$$
\Delta V = 
-\underbrace{\frac{C_{GD}}{C_{GD}+C_H}V_{DD}}_{\displaystyle\text{eqn 3.45}}
+\underbrace{\frac{WLC_{ox}(V_{GS}-V_{TH})}{C_H}}_{\displaystyle\text{eqn 3.47}} =
-\frac{W_{\textcolor{red}{\to2W}}C_{ov}+\frac{W_{\textcolor{red}{\to2W}}LC_{ox}}{2}}{W_{\textcolor{red}{\to2W}}C_{ov}+\frac{W_{\textcolor{red}{\to2W}}LC_{ox}}{2} + C_{H\textcolor{red}{\to 2C_H}}}V_{DD} 
+\frac{W_{\textcolor{red}{\to2W}} L C_{ox} (V_{GS} - V_{TH})}{C_{H\textcolor{red}{\to 2C_H}}} = \text{the same}
$$

$$
V_{n,out,rms} = \sqrt{\frac{kT}{C\to 2C}} = \times0.7
$$

#### 3.8

Yes

#### 3.9

page 41

#### 3.10

$$
V_A=\frac{C_b}{C_b+C_p}V_{in}=\frax{5}{6}V_{in}
$$

#### 3.11, 3.12, 3.13

| omitted? | open                                                         | short               |
| -------- | ------------------------------------------------------------ | ------------------- |
| M4       |                                                              |                     |
| M5       |                                                              |                     |
| M6       | only track, no hold                                          | only hold, no track |
| M3       | only hold, no track                                          | vdd to gnd          |
| M2       | Node Q is floating, the total charge $-C_bV_{DD}$ at Q has nowhere to go, therefore the charge $+C_bV_{DD}$ at P is bound by the positive plate of $C_b$, so the gate charge of M1 is always 0 | vin to gnd          |

#### 3.14

omitted; approximately 2VDD

#### 3.15

M2 turns off slightly *before* M4. (otherwise vin to gnd)

#### 3.16

$$
{\small \frac{V_b'}{V_{DD}}
= \frac{C_b}{C_b+C_{G1}+C_{G2}+C_p}
\approx \frac{C_b}{C_b+(WL)_1 C_{ox}+2W_1 C_{ov}+(WL)_2 C_{ox}+2W_2 C_{ov}}
= \frac{C_b}{C_b+1.2WLC_{ox}+2.4WC_{ov}}
= 0.9 }
\implies C_b>9W(1.2LC_{ox}+2.4C_{ov})
$$

#### 3.17

todo

#### 3.18

?

#### 3.19

$$
\Delta V(V_{in}) 
= \frac{W L C_{ox} (V_{GS} - V_{TH})}{C_H} 
= \frac{W L C_{ox} (V_{DD} - V_{TH})}{C_H}
= \frac{W L C_{ox} (V_{DD} - (V_{TH0}+\gamma(\sqrt{\textcolor{red}{V_{in}}+2\phi_B}-\sqrt{2\phi_B})))}{C_H}
$$

#### 3.20

?
