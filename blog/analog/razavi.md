


# Chap. 10 Stability and Frequency Compensation




> 10.2. An amplifier with a forward gain of A0 has two coincident poles at ωp. Calculate the maximum value of A0 for a 60◦ phase margin with a closed-loop gain of (a) unity and (b) 4.

(a)

$$
\frac{A_0}{\left( 1+\frac{s}{\omega_p} \right)^2} \implies
\begin{cases}
-\arctan(\omega_u/\omega_p)-\arctan(\omega_u/\omega_p) = -120\degree \implies \omega_u=\sqrt{3}\omega_p \\
\dfrac{A_0}{1+\left( \frac{\omega_u}{\omega_p}\right)^2}=1  \implies \boxed{A_0=4=\text{12.04 dB}}
\end{cases}
$$

(b)

$$
\frac{\beta A_0}{\left( 1+\frac{s}{\omega_p} \right)^2} \implies
\begin{cases}
-\arctan(\omega_u/\omega_p)-\arctan(\omega_u/\omega_p) = -120\degree \implies \omega_u=\sqrt{3}\omega_p \\
\dfrac{\beta A_0}{1+\left( \frac{\omega_u}{\omega_p}\right)^2}=1  \implies \boxed{A_0=16=\text{24.08 dB}}
\end{cases}
$$

> 10.3. An amplifier has a forward gain of A0 = 1000 and two poles at ωp1 and ωp2. For ωp1 = 1 MHz, calculate the phase margin of a unity-gain feedback loop if (a) ωp2 = 2ωp1 and (b) ωp2 = 4ωp1.

$$
\frac{A_0}{\sqrt{\left(1+\left(\dfrac{\omega_u}{\omega_p}\right)^2\right)\cdot\left(1+\left(\dfrac{\omega_u}{(2,4)\cdot\omega_p}\right)^2\right)}} = 1
\implies \omega_u=
\begin{cases}
\text{44.7 MHz}  \qquad 180\degree-\arctan(\omega_u/\omega_p)-\arctan(\omega_u/2\omega_p)=\boxed{4.53\degree} \\
\text{63.2 MHz}  \qquad 180\degree-\arctan(\omega_u/\omega_p)-\arctan(\omega_u/4\omega_p)=\boxed{3.84\degree}
\end{cases}
$$


> 10.4. A unity-gain closed-loop amplifier exhibits a frequency peaking of 50% in the vicinity of the gain crossover. What is the phase margin?

$$
|H(j\omega_u)=1|\implies H(j\omega_u)=e^{j(-\phi)}  \qquad
\left|\frac{H(j\omega_u)}{1+H(j\omega_u)}\right|
=\frac{1}{|1+e^{j(-\phi)}|}
=1.5
\implies\phi=\arccos(-7/9)=141.1\degree\quad \boxed{\text{PM}=38.9\degree}
$$

> 10.5 Consider the transimpedance amplifier shown in Fig. 10.73, where RD = 1 k, RF = 10 k, gm1 = gm2 = 1/(100Ω), and CA = CX = CY = 100fF. Neglecting all other capacitances and assuming that λ = γ = 0,
compute the phase margin of the circuit. (Hint: break the loop at node X.)

> 10.6. In Problem 10.5, what is the phase margin if RD is increased to 2kΩ?

> 10.7. If the phase margin required of the amplifier of Problem 10.5 is 45◦, what is the maximum value of (a) CY , (b) CA, and (c) CX while the other two capacitances remain constant?

