# 知乎好回答


### [三阶电路和高阶电路都是长得啥样的](https://www.zhihu.com/question/662814871)

主要内容：简单 LC 滤波器、高阶 LC 滤波器、传输线；作者：[niconiconi](https://www.zhihu.com/people/niconiconi-47-68)

#### 级联滤波器的问题：

1. 滤波器不能随意级联：滤波器是针对固定的输入、输出阻抗设计的，而滤波器之所以能滤波，就是靠改变阻抗。级联后，滤波器会偏离其原定工作条件，导致性能大幅下降——但这也难不倒你，在两个滤波器之间加入一个单位增益的射频放大器作为缓冲，两级就能独立运作了，谁在乎成本和功耗呢？
2. 把多个通带滤波器级联后，你发现滤波器从“通带滤波器”变成了“不通滤波器”，无论是通带、阻带都衰减严重：级联后的滤波器会对元器件误差十分敏感，特别是通带滤波器。每个滤波器的中心频率都有偏移，多级叠加之后，通带两侧的衰减也会叠加，原本应该通的频率最后也不通了。因此，传统的模拟电路中，多级滤波器都设有可变电容、电感进行每一级的校准，在无线电接收机中称为“统调”（alignment）。英文更直白：将它们“对齐”。
3. 你好不容易完成了滤波器统调，你却发现这个多级滤波器完全无法达到设计指标。9 阶滤波器明明应该 180 dB/decade 的衰减，为什么实际上却只能达到 5 阶滤波器 100 dB/decade 的水平？假如一滤波器在某个频率上真的有 180 dB 的衰减，那么给滤波器输入 1 kW（1000 瓦）的信号，滤波器的输出功率应该不超过 1 fW（0.000000000000001 瓦）。任何滤波器两级间微小的信号泄漏，或者环境中电场、磁场进入接收机的泄漏，都要大于这个信号功率。甚至连电路中电子无规则运动产生的热噪声，都可能大于它……

#### 传输线：

无损耗传输线的电路模型，是无穷多个完全相同的 LC 电路的级联。为什么要用“无穷电路”如此“不物理”的方式对传输线建模呢？这是集总电路理论的局限性。集总电路中只存在有限个元器件，本质是常微分方程，但分布电路的本质是偏微分方程（电报方程）。集总电路中元器件数量趋向于无穷，就相当于用常微分逼近偏微分。

我们假设一条无损传输线由无数截微小的传输线 dx 构成。在每一截微小的传输线中，存在微小并联电容 dC、微小串联电感 dL。我们假设电路中每个电感和电容都很微小，但其容量比例固定。电容代表电路中的电场、电感代表电路中的磁场。其中电容两端电压、电感两端电流均不能突变，信号只能从一级逐渐传播到下一级——这本质上是一维电磁波在电缆中的传播，逐渐建立电场、磁场的简易模型。

无损传输线存在以下几个反常特性：

**无损传输线是全通滤波器**：我们假设传输线中的每个电感，电容都无穷小，并不会阻碍信号通过，原则上允许所有的频率通过。因此**无损传输线不产生衰减，只改变信号的相位，是一种延迟线**。传输线的电路模型，也给了我们一种延迟电路的设计思路：用许多级重复的 LC 电路，逼近天然存在的传输线。这种电路叫做人工传输线（artificial transmission line）。不同于天然传输线，人工传输线是低通滤波器，带宽有限。

**无损传输线的特性阻抗是实数，只与电缆形状、尺寸与介电质有关**：传输线电路模型中虽然只有电感和电容，但它的阻抗居然和频率无关：分母分子的 jω 互相消去了，其阻抗是一个实数 Z=LC ，瞬态响应看上去就像电阻（我撰写过一个极为初等的推导，见《[电路中，电流有可能是√2安吗？》](https://www.zhihu.com/question/597042407/answer/3399443478)）。特性阻抗只和传输线的几何形状、尺寸、介电质有关，它代表一条信号线或数据线在施加电压的一瞬间，电压与电流的比例。传输线理论在电子电路设计中具有至高地位，是一切无线通信和高速数字电路的理论基础。像 USB、PCIe、DDR 这类高速总线，其工作频率都高于 1 GHz，此时的电路已经不再是由人们熟知的仅由电压、电流描述的集总电路，而是由电磁波构成的分布电路。这时的电路设计必须严格遵循与微波无线电电路相同的设计规则——也就是传输线的设计规则。

**有限传输线会产生信号反射**：一个只存在 LC 元件的电路，却表现为一个电阻，这不是违反能量守恒吗？！这是著名的传输线悖论。其解答是：只有电磁波到达传输线末端并产生反射之后，电路才会呈现产生电感、电抗。**在反射发生前的短时间内，无损传输线是真正的电阻**。我们也可以说传输线末端有什么东西的信息，其传播速度不能超过介质内光速。在无限传输线中，因为传输线是无限长的，永远没有信号反射。相反，只要在有限传输线末端连接一个端接电阻（termination resistor），使其与传输线的特性阻抗相等，它就能模拟无限传输线。这就是高速数字电路阻抗匹配的原理。

### [模拟 IC 中精确分压](https://www.zhihu.com/question/433912978)

已有回答总结：

- 低频信号
  - 1% 精度要求：片内电阻分压 ( + buffer, 或直接连接到栅上)
    - 具体步骤：
      - 电阻的类型和尺寸，参考foundry提供的mismatch参数；
      - mentecaro 前仿，看3sigma分布是否符合预期
      - layout: Razavi Chapter 19 Example 19.2
      - run rc后仿，检查系统偏差，如有，修layout，再后仿
- 高频信号（阻抗匹配）
  - directional coupler + buffer
- 数字域处理
  - PWM
 

个人思考：

dynamic element matching? 

### [Sansen 中文版第50页 源随器幅频特性曲线中尖峰原因](https://www.zhihu.com/question/494496007)
