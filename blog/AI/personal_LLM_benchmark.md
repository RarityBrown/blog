# My Personal LLM Benchmark

考虑到各种 Benchmark 泄露严重，现在基本上只参考 Arena Hard Prompts (Overall) with Style Control 作为 Benchmark。

同时，在平时（主要是专业相关的）使用过程中，收集选择一些截至2024年11月的第一梯队 LLM (o1, 4oL, Sonnet 3.5 Oct., Gemini 1.5 Pro 2, big-engine-test (Gemini 2 Pro? in Chatbot Arena)) 中部分 LLM 可以答对，部分 LLM 不能答对的适中难度题目，整理于本文。难度过大的，例如~~解个明年的高考数学压轴题~~、明年的物理系考研压轴题、写个 Windows 出来、~~证个哥德巴赫猜想~~等；以及难度过小的，例如 MMLU，都拉不开区分度。

2024/08/22: 我认为 LLM 的发展向“知识库”方向发展比较有前景，像 Mistral 堆代码和数学的训练数据是错误的方向，数学和代码需要很不一样的训练手段，例如 AlphaGeometry。如果依靠现在 LLM 的训练方式，可能需要 500T 级别的参数量级（此时数据的来源又是一个问题）才能达到人类行业中上水平，或者说认为 GPT-5 的水平会接近业内平均水平，这当然是一个了不起的成就，但是也意味着受限于（目前可预估的）算力，至少在未来 30 年内，不可能通过这种通用 LLM 的方式到达超过业内的 top 10% 水平。类似的，人脑中负责语言和数学的中枢显然也是两个。

2024/11/03: o1 出来有段时间了，试用了几次，颇为惊艳，其数学能力可以说从速度和质量上绝对已经超过工科学生闭卷平均水平（当然，如果允许学生使用 MATLAB, Python 等工具则是另当别论，因为这也是工科学生典型的场景），而数学和物理等专业较为优秀的学生尚与 o1 有一战之力。

## 题目列表

### 语言理解

> Q: Delaying graduation because of an exchange program in the US vs. Going on an exchange program in the US because of delayed graduation; Female college student engaging in prostitution vs. A fallen young woman persisting to complete her college education; He smokes while praying vs. He prays while smoking. Are there any other similar examples?
>
> 典型错误：4oL 之类的模型喜欢“为考试而学习 vs. 为学习而考试”和“为生活而工作 vs. 为工作而生活”之类的，但是显然不如例子中给的那么具有戏剧性。o1 则可以准确观察到句中戏剧性的原因，但是给出的其他例子也欠佳。

> Q: Chinese alternatives for "the quick brown fox jumps over the lazy dog"
>
> 典型错误：回答古文或诗词
>
> 正确回答：充分体现各种字形，包括左右结构、上下结构等；或是直接翻译也可以（Edge 浏览器的官方做法）

> "a 1" or "an 1", which one is grammatically correct?
>
> A: a 1

### 知识问题

> Q: 上海四校八大？
> 
> 典型错误：复交同师。基本上只取决对于中文互联网上知识的爬取深入程度和清洗的合理程度，因为这个靠多语言能力翻译没用，同时含有“四校八大”相关的网页内容往往是低质量的。
> 
> 正确情况：4oL 对; Sonnet 3.5 Oct. 错; Gemini 1.5 Pro 2 半对; 


> Q: 分别推荐模拟 EDA 领域和数字 EDA 领域中贡献最显著且最有影响力的三人，仅需分别列出英文名字即可，无需介绍他们的贡献
>
> 典型错误：推荐一些不那么有名的人、模拟数字倒置、把 Razavi, Baker, Thomas Lee 之类的人算在模拟 EDA 开发、把 David Patterson, Moore 之类的人算在数字 EDA 开发
>
> 参考答案：Analog: **Donald O. Pederson (SPICE)**, Laurence(Larry) Nagel (SPICE), Ken Kundert (Spectre); Digital: **Alberto Sangiovanni-Vincentelli**, Kurt Keutzer, Richard Newton, Aart de Geus (Synopsys), Robert K. Brayton 其中加粗项为必答项，其他项有提到一两个且没有提到 Razavi, Moore 等离谱答案则可以认为正确

### 知识-推理混合问题

> Q: 以下这段话有什么根本性的事实错误（正确、不完整、略有不严谨的部分均无需列出与分析）？无机半导体是一种具有特殊电子性质的材料，它在电子学和光电子学领域有着广泛的应用。本文将介绍无机半导体的基本概念、特性以及其在实际应用中的重要性。无机半导体是指由无机材料构成的半导体材料。与有机半导体不同，无机半导体的导电性主要是由其晶体结构和化学成分决定的。具体而言，无机半导体通常是由金属和非金属元素组成的化合物，如二硫化锌、氧化镓等。这些化合物具有特殊的晶体结构，使得它们的电子能带结构在一定温度范围内呈现出半导体的特性。无机半导体的最重要特性之一是能带结构。能带结构决定了材料的导电性质。在无机半导体中，通常存在着价带和导带两个能带。价带中的电子处于较低的能量状态，而导带中的电子处于较高的能量状态。当外界施加电场或加热材料时，一部分价带中的电子会跃迁到导带中，形成自由电子和空穴。这种电子和空穴的运动就是电流的基础。无机半导体的导电性还与掺杂有关。掺杂是指在材料中引入少量的杂质，以改变其导电性质。掺杂可以分为N型和P型两种。在N型掺杂中，引入的杂质具有多余的电子，这些电子可以自由移动，从而增加材料的导电性。而在P型掺杂中，引入的杂质具有少了一个电子的空位，这些空位可以被电子填充，形成空穴，从而增加材料的导电性。N型和P型材料的结合可以形成PN结，这是半导体器件中最基本的结构之一。无机半导体在电子学和光电子学领域有着广泛的应用。例如，半导体二极管是一种常见的电子器件，它利用PN结的特性实现了电流的整流和放大。此外，无机半导体还广泛应用于太阳能电池、激光器、光电探测器等领域。这些应用使得无机半导体成为现代高科技产业的重要基础材料。无机半导体是一种具有特殊电子性质的材料，它在电子学和光电子学领域有着广泛的应用。无机半导体的导电性质与其能带结构和掺杂有关，这使得它成为实现电流控制和光电转换的重要材料。对于人类社会的科技进步和经济发展而言，无机半导体的研究和应用具有重要意义。
> 
> 正确答案：“无机半导体**通常**是由金属和非金属元素组成的化合物”（Si 和 Ge 更通常啊） “它利用PN结的特性实现了电流的整流和**放大**” 都容易被 LLM 遗漏，单独再问 LLM 一次这两句话对不对，往往都能给出正确答案。
>
> 所以现在的 LLM 大海捞针评估我感觉是很有问题，或者说太简单了（大海捞针的插入针对于人类来说极明显，只能说是“大海捞钢筋”），此处稍微难一点点的“水塘捞细针”都捞不到。Jamba 有提到这个问题，并给出了 effective context window。但是显然，对于这个问题而言 1k 至 4k 左右 token 的 context window 都没有，大致只有 0.1k 的水平。不过这段话摘自公开的百度文库，所以这可能进一步加剧了这种情况，因为搞不好这段话还在训练数据集里。

> Q: NMOS 弱反型区电流公式？（不要在最终结果中带 Id0，写在 latex code block 中）
>
> 正确答案： $I_d = \left[ \mu C_{ox} \dfrac{W}{L} (n-1) V_t^2 \right] \exp\left(\dfrac{V_{gs} - V_{TH}}{n V_t}\right) \left(1 - \exp\left(-\dfrac{V_{ds}}{V_t}\right)\right)$
>
> 正确情况：o1 漏了 (n-1) 项; Sonnet 3.5 Oct. 使用 $e^x$ 形式，易读性欠佳; big-engine-test 正确答案; 

> Q: 随便找一篇专业相关的论文的一大段，令其翻译至中文
>
> 典型错误：大部分 LLM 会存在不同程度的专有名词翻译错误，最典型的是 device 没有翻译成“器件”。


> Q: Make `15/9*1e-12` symbolic in matlab within one line. Your answer should be simple.
>
> 典型错误：`expr = sym(15/9 * 1e-12);` 结果有浮点误差
> 
> 正确答案：`expr = 15/9*str2sym('10^(-12)');` 或 `sym(15)/sym(9)*sym(1e-12)` 之类把 1e-12 单独拿出来


> Q: PCIe 6.0 x8 的双向速度上限？以 GB/s 为单位。
>
> 正确答案：[121 GB/s](https://en.wikipedia.org/wiki/PCI_Express#Comparison_table)

### 推理问题

> Q:
> ```verilog
> module shiftreg_PA_rev (
>     output reg A, 
>     input E, clk, rst
> );
>     reg B, C, D;
>     always @ (posedge clk, posedge rst) begin
>         if (rst == 1'b1) begin A = 0; B = 0; C = 0; D = 0; end
>         else begin
>             D = E;
>             C = D;
>             B = C;
>             A = B;
>         end
>     end
> endmodule
> ```
> 
> Schematic of this code?
>
> 典型错误：4-bit 的 serial shift regs。因为 module 名称也具有误导性。
> 
> 正确答案：因为是阻塞赋值，其实是一个 A = E 的 1-bit DFF


> Q: 1 fJ 的能量可以使一个质子加速到多少速度？1 nJ 呢？如果是对于光子呢？
>
> 正确答案： $1.093 \times 10^6 \text{m/s}$, $2.97\times 10^8\text{m/s}=0.9914c$, $\lambda=199\mathrm{pm}$, $\lambda=0.199\mathrm{fm}$


> Q: #D7E8FF + #FFCCCC. Subtractive color mixing result in HEX?
>
> 典型错误：#D7B5CC, #D7B8CC, #D2B4D2, #D7CCCC, #D8CCCC
>
> 正确答案：#EBDAE5, #EBDAE6, #ECDAE6?

### 批判性-推理问题

> Q: 试证明 $x^4 + 4$ 无法因式分解成实数系中的因式
>
> 正确答案： $x^4 + 4 = (x^2 - 2x + 2)(x^2 + 2x + 2)$


> Q:
> ```verilog
> module simple_moore_fsm(
>     input wire clk,
>     input wire rst_n,
>     input wire x,
>     output reg y
> );
>     parameter S0 = 1'b0;
>     parameter S1 = 1'b1;
> 
>     reg current_state, next_state;
> 
>     always @(posedge clk or negedge rst_n) begin
>         if (!rst_n) current_state <= S0;
>         else        current_state <= next_state;
>     end
> 
>     always @(*) begin
>         case (current_state)
>             S0: begin
>                 if (x) next_state = S1;
>                 else   next_state = S0;
>             end
>             S1: begin
>                 if (x) next_state = S1;
>                 else   next_state = S0;
>             end
>             default: next_state = S0;
>         endcase
>     end
> 
>     always @(*) begin
>         case (current_state)
>             S0: begin
>                 if (x) y = 1'b1;
>                 else   y = 1'b0;
>             end
>             S1: begin
>                 if (x) y = 1'b0;
>                 else   y = 1'b1;
>             end
>             default: y = 1'b0;
>         endcase
>     end
> 
> endmodule
> ```
>
> 这段代码是 Moore FSM 还是 Mealy FSM？
>
> 正确答案：Mealy FSM


## 评测的小 ideas

### Bode

由 Bode 图想到是不是可以使用 Bode 图的方式更好的展示不同模型在不同难度下的性能情况。在简单的情况下，小模型的表现有可能会比没有特调过的大模型好；而在多种测试条件下表现良好的小模型在复杂问题下的能力衰退可能会很快，然后如果要求平均能力，直接求个积分就行。如果需要多领域的情况可以使用六边形的立体 Bode 图。

但是这个图要求我们有大量不同难度的测试集，其中比较容易想到的是数学的评估，因为其客观性比较强，我们可以将横轴取小学6年，中学6年，本科4年，硕士3年，共19各数据点的原创数学试题作为评估，拟合出一些漂亮的数学能力 Bode 图。或是小学奥数+初中奥数+高中奥数等...

![](https://github.com/user-attachments/assets/3e18c5c2-ea11-467b-bcbf-2a72b52f77e0)

### 批判性思维和综合能力

- 传统选择题形式的类 GPQA 评测 + 填空题形式的类 GPQA 评测 + 没有一个选项正确的选择题形式的类 GPQA 评测
- 1+1=2: Are you sure? / rethink / recheck
