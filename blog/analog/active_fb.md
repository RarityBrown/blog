# Active Feedback in Analog Circuit

to be continued

### 单端信号的 Active Feedback

---

> Active Feedback
>
> The AFA is a simple enough concept: use an output sensing stage similar to the input stage and use a feedback loop to force the output sensing stage to equal the input sensing stage. This basic form is shown in Figure 2(a). The distinguishing feature here is the active circuitry in the feedback path. We rarely do that with op-amps.
>
> [Beware! The naming of AFA terminals is not standardized. Some block diagrams show a minus sign at the summing junction, revealing that the feedback terminal with a plus sign actually has a negative effect on the output. (Hey, I don’t run this zoo. I’m just the tour guide.)]

> [!NOTE]
>
> 其中原文 Fig2 (a) 图中的 Gmf 应该为 "-Gmf"，本质上是 active negative feedback，要注意 active ≠ positive

所以有两种画法，分别是：

<svg xmlns="http://www.w3.org/2000/svg" width="836" height="228" viewBox="3392 -3224 836 228"><g font-family="Arial, Helvetica, sans-serif"><polyline data-wire-id="2d9f913e-3cce-4d15-99f4-60be81d781ea" points="3420,-3160 3460,-3160" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="b63f5aa2-5212-446d-959a-356d5f3d915c" points="3700,-3160 3740,-3160" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="54a24e57-458a-4fc4-9411-c09a94ec9c5a" points="3780,-3160 3740,-3160" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="6cde50eb-0a6c-493d-a8d9-25bf1bab3549" points="3840,-3160 3880,-3160" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="56900bc7-d576-45b8-94ff-448084e9c109" points="4200,-3160 4160,-3160" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="56900bc7-d576-45b8-94ff-448084e9c109-segment-1" points="4160,-3160 4120,-3160" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="d373a693-a29a-41f8-93c1-5f39625d1882" points="3580,-3060 3620,-3060" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="85e31d5c-f747-4142-b43f-695cb289db52" points="3700,-3060 3740,-3060" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="4c9cb207-6937-4761-bf28-b07004e078c7" points="4000,-3060 4040,-3060" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="0fb42984-8f8f-4b19-9b18-407bb6f61530" points="4120,-3060 4160,-3060" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="d373a693-a29a-41f8-93c1-5f39625d1882-segment-1" points="3580,-3120 3580,-3060" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="85e31d5c-f747-4142-b43f-695cb289db52-segment-1" points="3740,-3060 3740,-3160" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="4cb0e29e-677d-4d72-8075-93dadea6aff9" points="4000,-3120 4000,-3060" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><polyline data-wire-id="0fb42984-8f8f-4b19-9b18-407bb6f61530-segment-1" points="4160,-3060 4160,-3160" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" /><g data-component-id="5bb17323-5b40-41ad-ab90-d73df993476d" transform="translate(3540 -3200)"><path data-selector="symbolBody" d="M 0 40 L 18 40 M 62 40 L 80 40 M 40 62 L 40 80" transform="translate(0 0)" fill="none" stroke="#111111" stroke-width="2" /><path data-selector="symbolAccent" d="M 62 40 A 22 22 0 1 1 18 40 A 22 22 0 1 1 62 40 M 28 40 L 52 40 M 40 28 L 40 52" transform="translate(0 0)" fill="none" stroke="#111111" stroke-width="4" /><path data-selector="symbolPinMarks" d="M 6 34 L 12 34 M 9 31 L 9 37 M 31 71 L 37 71" transform="translate(0 0)" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="square" stroke-linejoin="miter" /></g><g data-component-id="58a967c3-774a-4e4e-9c01-69475ff61a1a" transform="translate(3620 -3200)"><path data-selector="symbolBody" d="M 10 32 L 21.4 32 M 78.6 32 L 90 32" transform="translate(-10 8)" fill="none" stroke="#111111" stroke-width="2" /><path data-selector="symbolAccent" d="M 21.4 -5.700000000000003 L 78.6 32 L 21.4 69.7 Z" transform="translate(-10 8)" fill="none" stroke="#111111" stroke-width="4" /><text x="32" y="47" fill="#111111" text-anchor="middle" dominant-baseline="alphabetic" font-family="Arial, Helvetica, sans-serif"><tspan data-selector="refLabelSign" x="24" y="46.3" text-anchor="end" font-weight="700" font-style="normal" font-size="18"></tspan><tspan data-selector="refLabelHead" x="32" y="47" text-anchor="middle" font-weight="700" font-style="italic" font-size="20">A</tspan><tspan data-selector="refLabelTail" x="40" y="49.2" text-anchor="start" font-weight="700" font-style="normal" font-size="12" baseline-shift="baseline"></tspan></text></g><g data-component-id="896b2bf7-241a-4fcb-9426-375516cbba63" transform="translate(3460 -3200)"><path data-selector="symbolBody" d="M 10 32 L 20 32 M 80 32 L 90 32" transform="translate(-10 8)" fill="none" stroke="#111111" stroke-width="2" /><path data-selector="symbolAccent" d="M 20 -8 L 80 12 L 80 52 L 20 72 Z" transform="translate(-10 8)" fill="none" stroke="#111111" stroke-width="4" /><text x="40" y="47" fill="#111111" text-anchor="middle" dominant-baseline="alphabetic" font-family="Arial, Helvetica, sans-serif"><tspan data-selector="refLabelSign" x="32" y="46.3" text-anchor="end" font-weight="700" font-style="normal" font-size="18"></tspan><tspan data-selector="refLabelHead" x="40" y="47" text-anchor="middle" font-weight="700" font-style="italic" font-size="20">G</tspan><tspan data-selector="refLabelTail" x="48" y="49.2" text-anchor="start" font-weight="700" font-style="normal" font-size="12" baseline-shift="baseline">mi</tspan></text></g><g data-component-id="1502a3d2-ec56-420a-ade2-6a8a1845c224" transform="translate(3620 -3100)"><path data-selector="symbolBody" d="M 10 32 L 20 32 M 80 32 L 90 32" transform="matrix(-1 0 0 1 90 8)" fill="none" stroke="#111111" stroke-width="2" /><path data-selector="symbolAccent" d="M 20 -8 L 80 12 L 80 52 L 20 72 Z" transform="matrix(-1 0 0 1 90 8)" fill="none" stroke="#111111" stroke-width="4" /><text x="40" y="47" fill="#111111" text-anchor="middle" dominant-baseline="alphabetic" font-family="Arial, Helvetica, sans-serif"><tspan data-selector="refLabelSign" x="32" y="46.3" text-anchor="end" font-weight="700" font-style="normal" font-size="18">+</tspan><tspan data-selector="refLabelHead" x="40" y="47" text-anchor="middle" font-weight="700" font-style="italic" font-size="20">G</tspan><tspan data-selector="refLabelTail" x="48" y="49.2" text-anchor="start" font-weight="700" font-style="normal" font-size="12" baseline-shift="baseline">mf</tspan></text></g><g data-component-id="19923447-b9df-4eb1-85c1-4d32a320c7e6" transform="translate(3960 -3200)"><path data-selector="symbolBody" d="M 0 40 L 18 40 M 62 40 L 80 40 M 40 62 L 40 80" transform="translate(0 0)" fill="none" stroke="#111111" stroke-width="2" /><path data-selector="symbolAccent" d="M 62 40 A 22 22 0 1 1 18 40 A 22 22 0 1 1 62 40 M 28 40 L 52 40 M 40 28 L 40 52" transform="translate(0 0)" fill="none" stroke="#111111" stroke-width="4" /><path data-selector="symbolPinMarks" d="M 6 34 L 12 34 M 9 31 L 9 37 M 31 71 L 37 71 M 34 68 L 34 74" transform="translate(0 0)" fill="none" stroke="#111111" stroke-width="2" stroke-linecap="square" stroke-linejoin="miter" /></g><g data-component-id="b8b7ab15-a622-4c77-86e7-a8b188d8ac1c" transform="translate(4040 -3200)"><path data-selector="symbolBody" d="M 10 32 L 21.4 32 M 78.6 32 L 90 32" transform="translate(-10 8)" fill="none" stroke="#111111" stroke-width="2" /><path data-selector="symbolAccent" d="M 21.4 -5.700000000000003 L 78.6 32 L 21.4 69.7 Z" transform="translate(-10 8)" fill="none" stroke="#111111" stroke-width="4" /><text x="32" y="47" fill="#111111" text-anchor="middle" dominant-baseline="alphabetic" font-family="Arial, Helvetica, sans-serif"><tspan data-selector="refLabelSign" x="24" y="46.3" text-anchor="end" font-weight="700" font-style="normal" font-size="18"></tspan><tspan data-selector="refLabelHead" x="32" y="47" text-anchor="middle" font-weight="700" font-style="italic" font-size="20">A</tspan><tspan data-selector="refLabelTail" x="40" y="49.2" text-anchor="start" font-weight="700" font-style="normal" font-size="12" baseline-shift="baseline"></tspan></text></g><g data-component-id="6cd93ae5-c8f6-4f8c-a48f-af95ad2984e8" transform="translate(3880 -3200)"><path data-selector="symbolBody" d="M 10 32 L 20 32 M 80 32 L 90 32" transform="translate(-10 8)" fill="none" stroke="#111111" stroke-width="2" /><path data-selector="symbolAccent" d="M 20 -8 L 80 12 L 80 52 L 20 72 Z" transform="translate(-10 8)" fill="none" stroke="#111111" stroke-width="4" /><text x="40" y="47" fill="#111111" text-anchor="middle" dominant-baseline="alphabetic" font-family="Arial, Helvetica, sans-serif"><tspan data-selector="refLabelSign" x="32" y="46.3" text-anchor="end" font-weight="700" font-style="normal" font-size="18"></tspan><tspan data-selector="refLabelHead" x="40" y="47" text-anchor="middle" font-weight="700" font-style="italic" font-size="20">G</tspan><tspan data-selector="refLabelTail" x="48" y="49.2" text-anchor="start" font-weight="700" font-style="normal" font-size="12" baseline-shift="baseline">mi</tspan></text></g><g data-component-id="341b331b-6c7e-4d00-9f60-c855d5129043" transform="translate(4040 -3100)"><path data-selector="symbolBody" d="M 10 32 L 20 32 M 80 32 L 90 32" transform="matrix(-1 0 0 1 90 8)" fill="none" stroke="#111111" stroke-width="2" /><path data-selector="symbolAccent" d="M 20 -8 L 80 12 L 80 52 L 20 72 Z" transform="matrix(-1 0 0 1 90 8)" fill="none" stroke="#111111" stroke-width="4" /><text x="40" y="47" fill="#111111" text-anchor="middle" dominant-baseline="alphabetic" font-family="Arial, Helvetica, sans-serif"><tspan data-selector="refLabelSign" x="32" y="46.3" text-anchor="end" font-weight="700" font-style="normal" font-size="18">−</tspan><tspan data-selector="refLabelHead" x="40" y="47" text-anchor="middle" font-weight="700" font-style="italic" font-size="20">G</tspan><tspan data-selector="refLabelTail" x="48" y="49.2" text-anchor="start" font-weight="700" font-style="normal" font-size="12" baseline-shift="baseline">mf</tspan></text></g><circle data-junction="3740,-3160" cx="3740" cy="-3160" r="5" fill="#111111" stroke="#111111" stroke-width="1" /><circle data-junction="4160,-3160" cx="4160" cy="-3160" r="5" fill="#111111" stroke="#111111" stroke-width="1" /></g></svg>

假设 A 输入为高阻时，对于 Fig2 (a) 或上图放大器 A 输入节点 KCL 有：

$$
V_{in}G_{mi} + V_{out} (-G_{mf})=0 
\implies 
\frac{V_{out}}{V_{in}} = \dfrac{G_{mi}}{G_{mf}}
$$

> The AFA loop forces the current generated by the feedback Gm to equal that of the input Gm. If the Gms do not match, the input and output voltages won’t match either.

所以对于单独的一个 Gmi 或者 Gmf 而言，可以有非线性。但是如果 Gmi 和 Gmf 之间的比值有非线性时（Gms do not match），闭环转递函数就会存在非线性。

对于 Fig2 (b) 同理有：

$$
V_{in}G_{mi} + V_{out}\cdot\frac{R_4}{R_3+R_4} (-G_{mf})=0 
\implies 
\frac{V_{out}}{V_{in}} = \dfrac{G_{mi}}{G_{mf}}\cdot\frac{R_3+R_4}{R_4}
$$

---

> As in op-amp circuits, the gain accuracy increases with loop gain, but—unlike op-amps—not all of that gain has to reside in the forward path (the “A” gain block) if the impedance at the summing junction (the input node of A) is large.

假设 A 的输入阻抗是 $Z_{in}$ 时，Fig2 (a) 放大器 A 输入节点 KCL 变为：

$$
V_{in}G_{mi} + V_{out} (-G_{mf}) + \frac{V_{out}}{A}\cdot\frac{1}{Z_{in}}=0 
\implies 
\frac{V_{out}}{V_{in}} = \frac{G_{mi}}{G_{mf} + \frac{1}{A \cdot Z_{in}}} = \frac{G_{mi}}{G_{mf}} \cdot \frac{1}{1 + \frac{1}{A \cdot Z_{in} \cdot G_{mf}}}
$$

特别地，我们假设 A 是一根导线。则此时 $A=1,Z_{in}=Z_{L,next}+Z_{in,-G_{mf}}$ ，闭环增益变为

$$
\frac{V_{out}}{V_{in}} = \frac{G_{mi}}{G_{mf} + \frac{1}{Z_{in}}} = \frac{G_{mi}}{G_{mf}} \cdot \frac{1}{1 + \frac{1}{Z_{in} \cdot G_{mf}}}
$$

当 $Z_{L,next}$ 较大时，退化成一种 Gm-Ratio 放大器。但是这种方式真的好吗？ Chris Mangelsdorf  继续说到：

---

> The idea of active circuitry in the feedback path goes against everything we’ve been taught. The classic high-gain op-amp with passive feedback solves a myriad of amplifier problems because it pushes all of the closed-loop performance requirements, such as gain accuracy, temperature stability, and linearity, on to the passives. All that’s required of the active circuitry is very high gain, not even a specific gain value as long as it’s high enough. The endless variety of useful configurations available from different connections of the passives made the universal op-amp the building block for board-level design. Its wild success as a stand-alone component made the op-amp the darling of the industry, and we brought it with us when we started to do more complex functions on chip. Now it’s everywhere, from power management to data conversion. That’s not a bad thing. The opamp/OTA is the right choice for many situations. But not for everything.

随后 Chris Mangelsdorf  直接给出了多条优点的结论，但是我们显然还无法直接领悟到。所以我们先暂且按下不表。

---

> It may not be immediately obvious from the basic forms in Figure 2, but the AFA is intended to operate without input resistors. The amp inputs connect directly to the signal, as they do in Figure 1. Unlike the traditional op-amp/OTA, the input stages are designed to accommodate large—usually differential—inputs and often feature substantial resistive degeneration. This kind of large-input front end is something that AFAs have in common with other in-amps.

对于传统的模拟电路设计，如果我们需要一种差动输入的、输入高阻的、工作频段可以到 DC 的、增益不大而且固定的放大器。则传统上会用三个运放组成 instrumentation amplifier (in-amp)，如 Fig S1(b) 所示。非常粗略的理解可以认为前两个运放负责高阻、后面一个运放负责 passive fb 的放大。

但是如果我们使用 Active FB Amplifier (AFA) 时，一个放大器就可以解决，因为看进去的阻抗就是高阻。

---

> However, great pains are taken with most in-amps to make the input transconductors linear. Such linearity is not necessarily a priority for AFAs, and it is one of their most interesting aspects. If a matching transconductor is used for the feedback path, the feedback loop will drive the output to follow the input, no matter what the shape of the transconductance profile... as long as it is monotonic, of course.
>
> ...

电路一：随后，作者给出了 Fig S2 (a) 的电路图。其中 $G_{mi}$ 通过两个反相器实现（所以其实是 $-G_{mi}$ ），同相放大器 A 通过两个 Gm-Ratio 放大器实现 4 倍增益，有源反馈 $-G_{mf}$ 通过一个反相器实现反馈和反相。

> ...
>
> the gain of two is generated by doubling the input transconductance compared to the feedback path. While this does nominally create the right closed loop gain, it doesn’t do it very well. The output stage does not operate over the same voltage range as the input stage. As the signal gets farther away from mid-supply, the mismatch becomes greater. So, for large signals, the distortion is obvious.

但是由于 $V_{out}$ 节点的电压和 $V_{in}$ 节点的电压一直不相等（不管是摆幅还是正负），所以导致大信号下， $G_{mi}$ 和  $G_{mf}$ 存在不等量的失真。

> In the second example, Figure S2(b), the gain of two is created by dividing down the output before passing it to the feedback stage. Now the two transconductors operate over the same range, and to the extent they are both symmetric around zero (mid-supply in this case), they match very well. This leads to a much more improved linearity in the output. So much so that you need to look at the derivative of the output (Figure S2e) to see any deviation from ideal. But even though the designer (moi) did his best to match the PMOS and NMOS in the inverters, the drive in the positive and negative directions are not perfectly symmetrical, and a slight error results.

电路二：一种改进方式如图 Fig S2 (b) 所示，此时输入输出节点的摆幅相等了，但是正负还是相反。所以由于 PMOS 和 NMOS 不对称，小信号增益 $\dfrac{\mathrm{d}V_{out}}{\mathrm{d}V_{vin}}$ 关于 $V_{in}$ 的图像还是明显存在非线性。

> If this example were differential, the fix would be trivial: just reverse the polarity of the input Gm. That would make both Gms increase and decrease together. No symmetry required. But this is unlikely to be a problem with differential Gms because—by definition—they are pretty darn symmetric. (This is why even-order distortion is rarely an issue in differential structures.)

电路二补：作者没有给出差动形式的电路图，我们此处给出：





电路三：





### 差动信号的 Active Feedback

> Parlor Tricks.
>
> 
>
> When you have two large-signal, differential inputs at your disposal, there are quite a few “cute” things you can do [1]. 
>
> Figure 4(a) shows the standard differential operation of subtracting one voltage from another. 
>
> Figure 4(b) shows how to add two voltages. The ability to add two voltages means you can add a voltage to itself, producing a gain of two in Figure 4(c)—all of this done with no additional components. Once you start adding passives, more options appear. 
>
> Figure 4(d) is a current source. 
>
> Figure 4(e) shows how to drive a flash converter reference ladder. (This flash example could of course be done with a gain of two, but this AFA configuration sets the voltage across the “nominal range” more accurately.) Figure 4(e) also illustrates 1) dividing down the output to get gains greater than two, and 2) how the differential nature of the input allows you to safely bring precision signals on chip. You can see why the AFA makes a compelling stand-alone building block.
>
> 
>
> The Figure 4 examples suggest some very important concepts about the use of the differential AFA. 
>
> - You analyze an op-amp circuit with the assumption that the two inputs are at the same voltage. 
> - You analyze an AFA by assuming the two Gms produce equal and opposite currents. This means equal and opposite input and feedback voltages unless the input and feedback Gms are intentionally mismatched.
> - Notice that the feedback is always  closed with the “Y-” terminal closest to the output to insure negative feedback. These may not be opamps, but they are still feedback loops, and they need to be stable.
> - Except for the loading of the summing junction, the input stage does not affect the loop gain or the dynamics of the feedback loop in any way. You can hang just about anything on the input stage Gm with impunity, as long as the inputs stay with the functional range. You wouldn’t put a 100-nF cap across the inputs to your op-amp now, would you?
> - It follows from the foregoing that  you can change the closed-loop gain of many setups without changing the bandwidth if you only change the input Gm.
> - In all of the examples so far, there  has been no difference between X and Y inputs and they appear interchangeable. In practice, however, it’s a good idea to have the input Gm limit or saturate before the feedback Gm does. This ensures that the input cannot drive the feedback Gm out of its operating range, and the loop remains closed under all conditions.
> - It’s trivial to add more input Gms if  you want. What you’d do with them isn’t immediately obvious, but there they are.
> - For remote loads or signal sources,  the Gms do not necessarily have to be colocated. The feedback Gm can be placed next to the load, for example, and transmit its current output over a considerable distance to the rest of the AFA. This is not good for Gm matching, but it can solve some harsh interference problems.

> [!NOTE]
>
> 作者 Fig4 中画的三角形符号表示 Gm 电流源，而非运放





### Practical Example: Variable Gain Amplifier

