# Wilson Current Mirror

把几本经典模拟书上的威尔逊电流源的章节，郑益慧模电（华成英书），以及网上关于威尔逊电流源的内容做一个大汇总


TL;DR: CMOS 工艺没必要使用，直接使用 cascode current mirror 就行。

## 引入

Bipolar 的电流镜，即使采用了 cascode 形式，也会因为 $\beta$ 不是无穷大，产生基极电流，从而导致 $I_{IN}\ne I_{OUT}$ 复制不准，所以需要一种补偿 $I_B$ 的方式。同时，这种结构也产生了另外的优点，例如相较于普通的电流镜提高了输出电阻。

## 3T-Wilson

### Bipolar

> Wilson: *A monolithic junction FET-NPN operational amplifier*
>
> Gray: *Analysis and Design of Analog Integrated Circuits*
>
> 华成英: 模拟电子技术基础
>
> 其他参考资料：[β-help 电流镜 by 没芯没肺](https://zhuanlan.zhihu.com/p/1935300254837761404),  [β-help/Wilson 电流镜 by designer](https://zhuanlan.zhihu.com/p/622797847), [基于 BJT 和 MOS Wilson CM 的双环负反馈分析 by 归来](https://zhuanlan.zhihu.com/p/460748211)

#### DC

##### $\beta$ 的影响减小

假设三管 $\beta$ 一样，不考虑 Early 时 $I_{C1}=I_{C3}=I_{C1,3}$

$$
\begin{align}
I_{E2}=I_{C1,3}+2I_B=I_{C1,3}+\dfrac{2I_{C1,3}}{\beta}
\implies I_{C1,3}=\dfrac{\beta}{\beta+2}\cdot I_{E2}=\dfrac{\beta}{\beta+2}\cdot\dfrac{1+\beta}{\beta}I_{C2}=\dfrac{\beta+1}{\beta+2}I_{C2}
\\
I_{IN}=I_{B2}+I_{C1,3}=\dfrac{I_{C2}}{\beta}+\dfrac{\beta+1}{\beta+2}I_{C2}
\implies I_{C2}=\left(1-\dfrac{2}{\beta^2+2\beta+2}\right)I_{IN}
\end{align}
$$

考虑 $V_{CE3}\ne V_{CE1}$ 所以当 $V_A$ 有限时 $I_{C1}\ne I_{C3}$

$$
I_{C2} \simeq I_{IN}\left(1-\frac2{\beta^2+2\beta+2}\right)\left(1-\frac{V_{BE2}}{V_A}\right)
$$

- 相较于 bipolar cascode 复制地更准
- 有限值 $\beta$ 影响复制准确度相较于 bipolar cascode 减小
- 有限值 $V_A$ 影响复制准确度相较于 bipolar cascode 增大，can be overcome by introducing a new diode-connected transistor between the collector of Q3 and the base of Q2 to equalize the collector-emitter voltages of Q3 and Q1. 详见后文 [4T-Wilson](#4t-wilson--improved-wilson)

![image](https://github.com/user-attachments/assets/431536a1-42b2-4014-b19f-a5f43c8117c4)

##### 温度影响减小

郑益慧观点 P28 44:00：Q2 射极电阻：电流源形式，很大？温度稳定性 （笔者感觉不太对）

#### 负反馈

This circuit uses negative feedback through Q1, activating Q3 to reduce the base-current error and raise the output resistance.

From a qualitative standpoint, the difference between the input current and IC3 flows into the base of Q2. This base current is multiplied by (βF + 1) and flows in the diode-connected transistor Q1, which causes current of the same magnitude to flow in Q3.

$$
\begin{cases}
I_{IN}-I_{C3}=I_{B2} \\
(\beta+1) I_{B2}=I_{E2}=I_{E1}
\end{cases}
$$

==A feedback path is thus formed that regulates IC3 so that it is nearly equal to the input current, reducing the systematic gain error caused by finite βF.==

这个一开始没有理解，再用中文复述一遍：希望 $I_{OUT}=I_{IN}$，为判断反馈情况，不妨假设 $I_{C2}$ 减小，即 $I_{OUT} < I_{IN}$，此时 $I_{B2} = I_{C2}/\beta$ 减小导致 $I_{C3} = I_{IN}-I_{B2}$ 要增大；但是 $V_{BE1}$ 要减小以满足 $I_{C2}$ 的减小。 $I_{IN}-I_{B2}=I_{C3}=I_{C1}=\frac{\beta}{\beta+1}(I_{B2}+I_{OUT})$

小信号输出电阻：Similarly, when the output voltage increases, the collector current of Q2 also increases, in turn increasing the collector current of Q. As a result, the collector current of Q3 increases, which reduces the base current of Q2. The decrease in the base current of Q2 caused by negative feedback reduces the original change in the collector current of Q2 and increases the output resistance.

可以把二极管接法的管子放到 Q3 吗？为什么？启动情况？

https://zhuanlan.zhihu.com/p/242196850 中的反馈框图？

#### 小信号

- 当 $g_mr_\pi\gg1,g_mr_o\gg1$ 时，① 节点对地电阻近似为 $\frac{1}{g_{m1}}$
- Q3 的 $g_{m3}$ 支路有电流 $g_{m3}v_{\pi3} = g_{m3}v_{\pi1}=i_1$，所以改画成流控电流源 CCCS
- $r_{o3}\to+\infty$ ( $r_{o3}$ 有限值的分析见 Gray 书，略复杂)

$$
\large 2g_{m1}v_①=\frac{v_t-v_①}{r_{o2}}+g_{m2}(-g_{m1}v_①r_{\pi2}) \implies  \dfrac{v_t}{i_t}=\dfrac{v_t}{2g_{m1}v_①}=\frac1{2g_{m1}}+r_{o2}+\frac{g_{m2}r_{\pi2}r_{o2}}2\simeq\frac{\beta_0r_{o2}}2
$$

==This result is the same as (4.38) for the cascode current mirror. In the cascode current mirror, the small-signal current that flows in the base of Q2 is mirrored through Q3 to Q1 so that the small-signal base and emitter currents leaving Q2 are approximately equal. On the other hand, in the Wilson current mirror, the small-signal current that flows in the emitter of Q2 is mirrored through Q1 to Q3 and then flows in the base of Q2. Although the cause and effect relationship here is opposite of that in a cascode current mirror, the output resistance is unchanged because the small-signal base and emitter currents leaving Q2 are still forced to be equal. Therefore, the small-signal collector current of Q2 that flows because of changes in the output voltage still splits into two equal parts with half flowing in rπ2.==

### CMOS

> Allen: *CMOS Analog Circuit Design* 修改了管子的编号顺序，使得上下文连贯

CMOS 少了栅极电流，可以在不做任何近似的情况下给出解析解：

$$
r_{out}=r_{o2}+r_{o1}\left(\frac{1+r_{o2}g_{m2}\left(1+\eta_2\right)+g_{m3}r_{o3}g_{m2}r_{o2}}{1+g_{m1}r_{o1}}\right)
$$
![image](https://github.com/user-attachments/assets/b0744060-1c85-434f-a0fb-9d54c7f536e9)

$$
V_{IN\min}=2V_{GS},\quad V_{OUT\min}=V_{GS}+V_{ov}
$$

![image](https://github.com/user-attachments/assets/354fa114-8429-4196-9ecf-a35eb05833a4)

#### Blackman 输出电阻分析

因为存在反馈机制，尝试在不考虑 M2 体偏的情况下对 M3 使用 Blackman 阻抗定理分析（在 Razavi 中介绍的较为详细，Allen 中直接给出了简短的示例，本文取 Razavi 书中的符号），首先分析输入阻抗：

1. $A|_{I_3=0}=r_{o3}$
2. $T_{OC}|_{I_{in}=0}=-g_{m3}\dfrac{V_3}{I_3}=g_{m3}\dfrac{g_{m2}r_{o3}}{g_{m2}+g_{m1}}$ （没考虑 $r_{o2}$，将 $r_{M1}$ 近似为 $1/g_{m1}$）
3. $T_{SC}|_{V_{in}=0}=-g_{m3}\dfrac{V_3}{I_3}=0$
4. $R_{in}=A\dfrac{1+T_{SC}}{1+T_{OC}}=\dfrac{r_{o3}}{1+\frac{g_{m2}g_{m3}r_{o3}}{g_{m1}+g_{m2}}}=r_{o3}||\dfrac{g_{m1}+g_{m2}}{g_{m2}g_{m3}}\approx\dfrac{2}{g_m}$

吴金视频中给出了一种定性分析方法：M2 可以视作 source follower，所以交流通路下 M3 的 drain 和 gate 视作短路，即 M3 是二极管接法，所以 $R_{in}$ 的量级为 $1/g_{m3}$

对于小信号模型直接分析，可以给出考虑 $g_{ds2}$ 的结果，式中 $R_D$ 为电流镜输出负载电阻：$R_{in}=r_{o3}||\frac{g_{m1}+g_{m2}+g_{ds2}(1+g_{m1}R_D)}{g_{m2}g_{m3}}$

#### Regulated cascode current mirror

改进型 Wilson 电流镜可以获得 $g_{m}^2r_{o}^3$ 量级的输出电阻，但是最低输出电压仍然较高。

## 4T-Wilson / Improved Wilson

### CMOS

> Gray
>
> Sansen: *Analog Design Essentials* 修改了管子的编号顺序，使得上下文连贯
>
> [Current Mirror Circuit: Wilson and Widlar Current Mirroring Techniques (circuitdigest.com)](https://circuitdigest.com/tutorial/current-mirror-circuit-wilson-and-widlar-current-mirroring-techniques)
>
> [Wilson current mirror - Wikipedia](https://en.wikipedia.org/wiki/Wilson_current_mirror#Advantages_and_limitations)
>
> [Improved current mirror : r/chipdesign (reddit.com)](https://www.reddit.com/r/chipdesign/comments/75vpat/improved_current_mirror/)?

#### 反馈分析

不考虑体偏、 $I_{OUT}$ 端负载电阻=0（例如直接接 VDD，因为电流源一般驱动小阻抗，否则一山不容二虎）时，**将 M3 M1 的栅极断开**，求出：

$$
\Large \mathrm{loopgain}\xlongequal{V_{G3}\to V_{G4,2}=-g_{m3}V_{G3}r_{o3}\to V_{G1}}\frac{V_{G1}}{V_{G3}}\approx-\frac{g_{m2}}{g_{m1}}g_{m3}r_{o3}
$$

- $V_{G3}\to V_{G2}$ 之间存在负反馈
  - 提高输出电阻至 $g_{m2}r_{o3}r_{o2}$ 量级
  - 降低输入电阻至 $\dfrac{2}{g_{m3}}$ 的量级，直接闭环求出
- 能不能反接？M2 和 M3 二极管接法，即 $I_{IN},I_{OUT}$ 位置互换
  - 不行，因为输入和输出阻抗也变化了

==The circuit is a feedback amplifier with loop gain $g_{m3}R_{in}$==. Since all time constants in that loop are of the same order of magnitude, they create a system with several poles. As a result, peaking can occur in the current transfer characteristic. When the Wilson current mirror circuit is biased with maximum high frequency the negative feedback loop cause instability in frequency response.

Wilson current mirror circuit creates noise across the output. This is due to the feedback which raises output impedance and directly affect the collector/drain current. The collector/drain current fluctuation contributes noises across the output.

![image](https://github.com/user-attachments/assets/fd12af91-5068-484e-aafc-b059a0220d35)

对于基于信号流图的多反馈环路分析可以参考：[多反馈回路和 Wilson 电流镜](https://zhuanlan.zhihu.com/p/681694941)

#### 小信号分析

在 $V_{OUT}$ 端施加 $I_t$ 有：

1. $I_{t}$ 全部流过 M1，产生相应电压: $v_{gs1}=v_{gs3}=I_t\left( \dfrac{1}{g_{m1}}||r_{o1} \right)$
2. $v_{g1,3}$ 经过 M3 common source 小信号放大: $v_{d3}=\underbrace{-g_{m3}\left( r_{o3}||\left(\frac{1}{g_{m4}}+\infty\right) \right)}_{\text{M1: common source gain}}\cdot v_{gs3} = -g_{m3}r_{o3}\frac{I_t}{g_{m1}}$
3. $v_{g4}=v_{s4}$
   - 从大信号角度分析：流过 M4 的电流恒定为 $I_{IN}$ ，所以 $V_{g4}-V_{s4} = \text{large signal const} = V_{d4}-V_{d3}$
     - 而 $V_{d3}\ne\text{const}$ ，因为 $I_{IN}$ 电流可以通过 $r_{o3}$ 流出
   - 所以从小信号角度分析：$v_{d4}\xlongequal{\substack{\text{physical} \\ \text{connection}}}v_{g4}\xlongequal{\substack{\text{small-signal} \\ \text{clamping}}}v_{s4}\xlongequal{\text{same net}}v_{d3}$

所以：

$$
\begin{gather}
v_{g2}=v_{g4}=v_{d3}=-g_{m3}r_{o3}\frac{I_t}{g_{m1}} \\
g_{m2}v_{gs2} = g_{m2}\left( -g_{m3}r_{o3}\frac{I_t}{g_{m1}} -  \frac{I_t}{g_{m1}}\right) \\
I_t=g_{m2}v_{gs2}+r_{o2}v_{ds2} \qquad V_{t}=v_{ds1}+v_{ds2} \\\\
r_{out}=\left( \frac{1}{g_{m1}}+r_{o2}+\frac{g_{m2}}{g_{m1}}g_{m3}r_{o3}r_{o2} \right)
\end{gather}
$$

如果是比例电流镜，即 $I_{OUT}=NI_{IN}$ 时， $g_{m1}=Ng_{m3},\; r_{o1}=\dfrac{r_{o3}}{N}$

$$
r_{out}\approx g_{m2}r_{o2}\cdot r_{o1} = r_{out,\text{cascode}}
$$

![image](https://github.com/user-attachments/assets/76f86f01-7fd5-49dd-9db9-742dd6d7e7a7)

![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9Ii0xNDAgLTQwIDY0MCAyNjAiPjxkZWZzPjxnIGlkPSJiIiBzdHJva2U9IiMwMDAiIHN0cm9rZS13aWR0aD0iMiI+PHBhdGggZD0iTTMwIDB2NDBNNDAgMHY0ME00MCAwaDMwTTQwIDQwaDMwTTcwIDQwbC0xMC01djEweiIvPjwvZz48ZyBpZD0iYSIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjMDAwIiBzdHJva2Utd2lkdGg9IjIiPjxjaXJjbGUgcj0iMTUiLz48cGF0aCBkPSJNMC04VjgiLz48cGF0aCBmaWxsPSIjMDAwIiBkPSJtMCA4LTQtNmg4eiIvPjwvZz48ZyBpZD0iYyIgc3Ryb2tlPSIjMDAwIiBzdHJva2Utd2lkdGg9IjIiPjxwYXRoIGQ9Ik0tMTIgMGgyNE0tOCA0SDhNLTQgOGg4Ii8+PC9nPjxnIGlkPSJkIiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAiIHN0cm9rZS13aWR0aD0iMiI+PHBhdGggZD0iTTAgMHY1TS02IDVINnY0MEgtNnpNMCA0NXY1Ii8+PC9nPjxnIGlkPSJlIiBmaWxsPSJub25lIiBzdHJva2U9IiMwMDAiIHN0cm9rZS13aWR0aD0iMiI+PHBhdGggZmlsbD0iI2FkZDhlNiIgZD0ibTAgMC01MCAyOXYtNTh6Ii8+PHBhdGggZD0iTS02MCAwaDEwTTAgMGgxMCIvPjx0ZXh0IHg9Ii0zMSIgZmlsbD0iIzAwMCIgc3Ryb2tlPSJub25lIiBkb21pbmFudC1iYXNlbGluZT0ibWlkZGxlIiBmb250LWZhbWlseT0ic2Fucy1zZXJpZiIgZm9udC1zaXplPSIxNCIgdGV4dC1hbmNob3I9Im1pZGRsZSI+6Yit5oqUPHRzcGFuIGJhc2VsaW5lLXNoaWZ0PSJzdWIiIGZvbnQtc2l6ZT0iMTAiPm08L3RzcGFuPnI8dHNwYW4gYmFzZWxpbmUtc2hpZnQ9InN1YiIgZm9udC1zaXplPSIxMCI+bzwvdHNwYW4+PC90ZXh0PjwvZz48L2RlZnM+PHBhdGggZmlsbD0iI2FkZDhlNiIgZD0iTS0xNTAtNDBoMTM1djI3MGgtMTM1eiIvPjx0ZXh0IHg9Ii0xMDAiIHk9Ijk1IiBkb21pbmFudC1iYXNlbGluZT0iY2VudHJhbCIgZm9udC1mYW1pbHk9InNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iMTQiIHRleHQtYW5jaG9yPSJtaWRkbGUiPgogICAgPHRzcGFuIHg9Ii0xMTAiPmNvbW1vbjwvdHNwYW4+CiAgICA8dHNwYW4geD0iLTExMCIgZHk9IjEuMmVtIj5zb3VyY2U8L3RzcGFuPgogIDwvdGV4dD48dXNlIGhyZWY9IiNhIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNzAgLTIwKSIvPjxwYXRoIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIyIiBkPSJNLTcwLTV2NDUiLz48dXNlIGhyZWY9IiNiIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgwIDQwKSIvPjx1c2UgaHJlZj0iI2IiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDAgMTUwKSIvPjxnIHRyYW5zZm9ybT0ic2NhbGUoLTEgMSkiPjx1c2UgaHJlZj0iI2IiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDAgNDApIi8+PHVzZSBocmVmPSIjYiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMCAxNTApIi8+PC9nPjxwYXRoIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIyIiBkPSJNLTMwIDYwaDYwTS0zMCAxNzBoNjBNLTcwIDgwdjcwTTcwIDgwdjcwTTcwIDQwVjIwTS03MCAyMEgwTTAgMjB2NDBNNzAgMTUwdi0yME03MCAxMzBIME0wIDEzMHY0ME0tNzAgMTkwdjIwTTcwIDE5MHYyMCIvPjx1c2UgaHJlZj0iI2MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC03MCAyMTApIi8+PHVzZSBocmVmPSIjYyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNzAgMjEwKSIvPjxnIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIyIj48dXNlIGhyZWY9IiNhIiB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAtMSAxMjAgMTA4KSIvPjxwYXRoIGQ9Ik03MCAyMGg1ME0xMjAgMjB2NzNNMTIwIDEyM3Y4NyIvPjx1c2UgaHJlZj0iI2MiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDEyMCAyMTApIi8+PC9nPjx1c2UgaHJlZj0iI2IiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDM0MCA0MCkiLz48cGF0aCBzdHJva2U9IiMwMDAiIHN0cm9rZS13aWR0aD0iMiIgZD0iTTQxMCA0MFYyMCIvPjxnIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIyIj48dXNlIGhyZWY9IiNhIiB0cmFuc2Zvcm09Im1hdHJpeCgxIDAgMCAtMSA0NTAgMTA4KSIvPjxwYXRoIGQ9Ik00MTAgMjBoNDBNNDUwIDIwdjczTTQ1MCAxMjN2ODciLz48dXNlIGhyZWY9IiNjIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0NTAgMjEwKSIvPjwvZz48cGF0aCBzdHJva2U9IiMwMDAiIHN0cm9rZS13aWR0aD0iMiIgZD0iTTQxMCA4MHY1MCIvPjx1c2UgaHJlZj0iI2QiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDQxMCAxMzApIi8+PHBhdGggc3Ryb2tlPSIjMDAwIiBzdHJva2Utd2lkdGg9IjIiIGQ9Ik00MTAgMTgwdjMwIi8+PHVzZSBocmVmPSIjYyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDEwIDIxMCkiLz48dXNlIGhyZWY9IiNlIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgzMzUgNjApIi8+PHBhdGggc3Ryb2tlPSIjMDAwIiBzdHJva2Utd2lkdGg9IjIiIGQ9Ik0yNTAgNjBoMjVNMzQ1IDYwaDI1TTQxMCAxMzBIMjUwTTI1MCAxMzBWNjAiLz48L3N2Zz4=)

## 总结

> [Difference between simple cascode current source and modified Wilson current source | Forum for Electronics (edaboard.com)](https://www.edaboard.com/threads/difference-between-simple-cascode-current-source-and-modified-wilson-current-source.23031/)

综上，普通的 3T/4T-Wilson 电流镜在 CMOS 下和 cascode 电流镜有着相近的输出电阻、最小工作电压等交直流特性。但是相较于 cascode 电流镜，Wilson 电流镜引入了反馈、引入了相近的零极点，因此高频响应并不好，所以在 CMOS 下 Wilson 电流镜并不常用，直接使用 cascode 即可。只有在 bipolar 的情况下，Wilson 电流镜相较于 cascode 才有优点，这可能也是唯独只有 Razavi 这本较新的 CMOS 书中完全没有提到 Wilson 电流镜的原因。
