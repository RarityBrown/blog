# My Personal LLM Benchmark

考虑到各种 Benchmark 泄露严重，现在基本上只参考 Arena Hard Prompts (Overall) with Style Control 作为 Benchmark。

同时，在平时（主要是专业相关的）使用过程中，收集选择一些截至2024年11月的第一梯队 LLM (o1p, 4oL, Sonnet 3.5 Oct., Gemini 1.5 Pro 2, gemini-exp-1121, big-engine-test (Gemini 2 Pro? in Chatbot Arena), secret-chatbot (in arena)) 中部分 LLM 可以答对，部分 LLM 不能答对的适中难度题目，整理于本文。难度过大的，例如~~解个明年的高考数学压轴题~~、明年的物理系考研压轴题、写个 Windows 出来、~~证个哥德巴赫猜想~~等；以及难度过小的，例如 MMLU，都拉不开区分度。

2024/08/22: 我认为 LLM 的发展向“知识库”方向发展比较有前景，像 Mistral 堆代码和数学的训练数据是错误的方向，数学和代码需要很不一样的训练手段，例如 AlphaGeometry。如果依靠现在 LLM 的训练方式，可能需要 500T 级别的参数量级（此时数据的来源又是一个问题）才能达到人类行业中上水平，或者说认为 GPT-5 的水平会接近业内平均水平，这当然是一个了不起的成就，但是也意味着受限于（目前可预估的）算力，至少在未来 30 年内，不可能通过这种通用 LLM 的方式到达超过业内的 top 10% 水平。类似的，人脑中负责语言和数学的中枢显然也是两个。

2024/11/03: o1p 出来有段时间了，试用了几次，颇为惊艳，其数学能力可以说从速度和质量上绝对已经超过工科学生闭卷平均水平（当然，如果允许学生使用 MATLAB, Python 等工具则是另当别论，因为这也是工科学生典型的场景），而数学和物理等专业较为优秀的学生尚与 o1p 有一战之力。

2024/11/21: 究竟什么容易被 AI 替代？在 Gen-AI 出来之前，主流观点认为 Art 和 Scientific-Research 是 AI 难以替代的两座高山；Gen-AI 井喷式增长后，人们又认为 STEM 相较于文科难以被 AI 替代。从传统的角度思考，我们可以认为 

- ①资料易于被数字化、资料数字化程度高
- ②可用于训练的资料内容多、质量高、定量化评价体系清晰
- ③产出形式单一、数字化程度高

的行业容易被取代。我们不妨先举几个例子：程序员、作家在这种评价标准下容易被取代，而流水线工人（注意此处讨论的是 AI 而不是自动化）、保险经纪人在这种评价指标下难以被取代。司机在媒体的宣传中是非常容易被取代的职业，但是它并不满足我们提到的要求，直到 Tesla FSD V12 的出现。

我们先把三点细化后再举一些例子。

1. 满足①而不满足②③的例子是最广泛，有法律等一系列
2. 可用于训练的资料内容多且质量高。不代表这些数据要是公开的或者开源的，只要有数据即可。例如画家反对 AI 训练，但是大公司直接无视法律风险，直接继续使用大量数据训练；Tesla 收集全球用户的驾驶数据用于训练 FSD。从 2022 LLM 高考语文的水平高于高考数学，到 2025 LLM 满分的高考数学和略微进步的高考语文，就是定量化评价体系中的差别。AlphaGo 也是同理，首先竞技性游戏的评价极为单一和清晰，其次，使用合成棋谱进行 RL。
3. 



## 题目列表

### 语言理解

> Q: Delaying graduation because of an exchange program vs. Going on an exchange program because of delayed graduation; Female college student engaging in prostitution vs. A fallen young woman persisting to complete her college education; He smokes while praying vs. He prays while smoking. Are there any other similar examples?
>
> 典型错误：4oL 之类的模型喜欢“为考试而学习 vs. 为学习而考试”和“为生活而工作 vs. 为工作而生活”之类的，但是显然不如例子中给的那么具有戏剧性。o1p 则可以准确观察到句中戏剧性的原因，但是给出的其他例子也欠佳。

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
> 参考答案：Analog: **Donald O. Pederson (SPICE)**, Laurence(Larry) Nagel (SPICE), Arthur Richard Newton (SPICE), Ken Kundert (Spectre); Digital: **Alberto Sangiovanni-Vincentelli**, Kurt Keutzer (Bell Labs, Synopsys, UCB), Aart de Geus (Synopsys), Robert K. Brayton (UCB) 其中加粗项为必答项，其他项有提到一两个且没有提到 Razavi, Moore 等离谱答案则可以认为正确

> Q: The release year of IC Compiler 2? When did ICC1 stop updating?
> 
> 正确答案：2014, 2016
>
> 正确情况：gemini-exp-1121 对对

> Q: 除了 Logitech MX Master，推荐**一**款有侧向滚轮的鼠标。仅需要名字，无需介绍    Apart from the Logitech MX Master, recommend **one** mouse with a side scroll wheel. Only the name is needed, no description.
>
> 典型错误：Razer Pro Click, Microsoft Sculpt Ergonomic Mouse
>
> 正确情况：4oL 错, Sonnet 3.5 Oct. 错

> Q: How to print quotes within a node in a Mermaid flowchart? Answer within 2 lines in a code block.
>
> 典型错误：`A["Node with \"quotes\""]`
>
> 正确答案：`A["Node with #quot;quotes#quot;"]` ref: [link](https://mermaid.js.org/syntax/flowchart.html#entity-codes-to-escape-characters)
>
> 正确情况：gemini-exp-1114 对错错; o1p 错错错; 4oL 错错错错; secret-chatbot 对对对错错; Sonnet 3.5 Oct. 错错错错; Gemini 1.5 Pro 2 错错


> Q: The command recompiles all out-of-date files in a QuestaSim project? (not `vlog` or `vcom`)
>
> 典型错误：`vlog -work work +acc=r *.v`
> 
> 正确答案：`project compileoutofdate`


> Q: Verilog 中 `always @(posedge clk, negedge rst_n)` 和 `always @(posedge clk or negedge rst_n)` 哪个更好？为什么？好像和 Verilog 标准也有关系？
>
> 典型错误：推荐使用 IEEE 1364-2001 标准下的 `always @(posedge clk or negedge rst_n)` 写法。某种是同步/异步的，导致竞争。
> 
> 正确答案(by perplexity)：The use of commas in Verilog sensitivity lists is a feature introduced in the Verilog-2001 standard. This change provides an alternative syntax to the traditional "or" keyword used in Verilog-1995, offering a more intuitive and consistent approach to specifying multiple signals in the sensitivity list. The comma-separated sensitivity list does not add new functionality compared to the "or" keyword. It simply provides an alternative, more readable syntax. Many developers prefer the comma-separated style as it aligns better with other list-based constructs in Verilog and other programming languages.
>
> 正确情况：gemini-exp-1114 错错对对; 

### 知识-推理混合问题

> Q: 以下这段话有哪些根本性的事实错误（正确、不完整、略有不严谨、正确但笼统、正确但过于简单的部分均无需列出与分析）？无机半导体是一种具有特殊电子性质的材料，它在电子学和光电子学领域有着广泛的应用。本文将介绍无机半导体的基本概念、特性以及其在实际应用中的重要性。无机半导体是指由无机材料构成的半导体材料。与有机半导体不同，无机半导体的导电性主要是由其晶体结构和化学成分决定的。具体而言，无机半导体通常是由金属和非金属元素组成的化合物，如二硫化锌、氧化镓等。这些化合物具有特殊的晶体结构，使得它们的电子能带结构在一定温度范围内呈现出半导体的特性。无机半导体的最重要特性之一是能带结构。能带结构决定了材料的导电性质。在无机半导体中，通常存在着价带和导带两个能带。价带中的电子处于较低的能量状态，而导带中的电子处于较高的能量状态。当外界施加电场或加热材料时，一部分价带中的电子会跃迁到导带中，形成自由电子和空穴。这种电子和空穴的运动就是电流的基础。无机半导体的导电性还与掺杂有关。掺杂是指在材料中引入少量的杂质，以改变其导电性质。掺杂可以分为N型和P型两种。在N型掺杂中，引入的杂质具有多余的电子，这些电子可以自由移动，从而增加材料的导电性。而在P型掺杂中，引入的杂质具有少了一个电子的空位，这些空位可以被电子填充，形成空穴，从而增加材料的导电性。N型和P型材料的结合可以形成PN结，这是半导体器件中最基本的结构之一。无机半导体在电子学和光电子学领域有着广泛的应用。例如，半导体二极管是一种常见的电子器件，它利用PN结的特性实现了电流的整流和放大。此外，无机半导体还广泛应用于太阳能电池、激光器、光电探测器等领域。这些应用使得无机半导体成为现代高科技产业的重要基础材料。无机半导体是一种具有特殊电子性质的材料，它在电子学和光电子学领域有着广泛的应用。无机半导体的导电性质与其能带结构和掺杂有关，这使得它成为实现电流控制和光电转换的重要材料。对于人类社会的科技进步和经济发展而言，无机半导体的研究和应用具有重要意义。
> 
> 正确答案：
> - “无机半导体**通常**是由金属和非金属元素组成的化合物”（Si 和 Ge 更通常啊）
> - “它利用PN结的特性实现了电流的整流和**放大**”
> - “当外界施加**电场**或加热材料时，一部分价带中的电子会跃迁到导带中”
>   - 这个 o1-mini 认为是错的。虽然在高场强下可能存在碰撞电离（雪崩击穿），对于 PN 结可能存在隧穿效应。但是“电场”用在原文这个语境下，应该是不对的，就是只有热激发、光激发。所以 o1-mini 的观点应该是正确的？我也没看出来
>
> 无论哪个点都容易被 LLM 遗漏，单独再问 LLM 一次这几句话对不对，往往都能给出正确答案。所以现在的 LLM 大海捞针评估我感觉是很有问题，或者说太简单了（大海捞针的插入针对于人类来说极明显，只能说是“大海捞钢筋”），此处稍微难一点点的“水塘捞细针”都捞不到。Jamba 有提到这个问题，并给出了 effective context window。但是显然，对于这个问题而言 1k 至 4k 左右 token 的 context window 都没有，大致只有 0.1k 的水平。不过这段话摘自公开的百度文库，所以这可能进一步加剧了这种情况，因为搞不好这段话还在训练数据集里。不过震惊的是 yi-lighting 全部答出来了。
>
> 同时，这题的 prompt 也挺重要的，似乎**哪些**比**什么**会导致 LLM 答得更全。

> Q: !(AB+C) 逻辑表达式对应的 standard cell 叫什么？在 CMOS 逻辑中需要几个 MOSFET？
>
> 典型错误：12个
> 
> 正确答案：2-1 AND-OR-Invert gate (AOI21), 6个


> Q: NMOS 弱反型区电流公式？（不要在最终结果中带 Id0，写在 latex code block 中）
>
> 正确答案： $I_d = \left[ \mu C_{ox} \dfrac{W}{L} (n-1) V_t^2 \right] \exp\left(\dfrac{V_{gs} - V_{TH}}{n V_t}\right) \left(1 - \exp\left(-\dfrac{V_{ds}}{V_t}\right)\right)$
>
> 正确情况：o1p 漏了 (n-1) 项; Sonnet 3.5 Oct. 使用 $e^x$ 形式，易读性欠佳; big-engine-test 正确答案; 

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


> Q: Create a code block containing all possible methods for inserting a new line within a `\texttt` in LaTeX, ensuring compatibility with Mathjax/Katex.
>
> 典型错误：
>
> ```latex
> \texttt{line1 \\       line2}
> \texttt{line1 \newline line2}
> \texttt{line1 \cr      line2}
> \begin{verbatim}
> line1
> line2
> \end{verbatim}
> ```
>
> 正确答案：There is no direct way, some alternative ways are
> 
> ```latex
> \begin{array}{l}  \texttt{line1} \\  \texttt{line2}  \end{array}
> 
> \begin{aligned}   \texttt{line1} \\  \texttt{line2}  \end{aligned}
>
> \verb|line1|  \\  \verb|line2|
> ```

> Q: I'm trying to typeset text in LaTeX with specific spacing, resembling `\texttt{\textcolor{red}{METAL1}~~~~~~~~\textcolor{blue}{cm1}}`, ensuring the code block maintains an exact width equivalent to eight spaces between the colored words within the `\texttt{}` environment. My current attempts at achieving this have failed, as the multiple spaces collapse into a single space, deviating from the desired output. Can you provide two distinct LaTeX methods to accomplish this precise formatting, demonstrating them within a single code block without additional commentary?
>
> 典型错误：
>
> 1. `\texttt{\textcolor{red}{METAL1}\hspace{8em}\textcolor{blue}{cm1}}`. 因为 `\hspace{8em}` 的宽度和 `\texttt{}` 中 8 个连续的 monospace 不一样宽
> 2. `\texttt{\textcolor{red}{METAL1}\phantom{xxxxxxxx}\textcolor{blue}{cm1}}`. `\phantom` is only supported in math mode
> 
> 参考答案：`\textcolor{red}{\texttt{METAL1}} \verb|        | \textcolor{blue}{\texttt{cm1}}`
>
> 正确情况：grok2 对错错, gemini-exp-1121 错错错错, o1-min 错错错, o1p 错, 4oL 错错错

> Q: PSRR of 5T-OTA in $g_m$ and $r_o$?
>
> 正确答案：对于 PMOS 输入的 5T-OTA 有 $\text{PSRR}_+\approx\dfrac{1}{2g_{m,\text{current mirror}}r_{o,\text{tail}}}  \qquad  \text{PSRR}_-=1$
>
> 这道题好像有一些过难了，如果通过记忆来回答的话训练中的可参考语料太少，如果通过推理来回答的话 LLM 对于电路这一块的推理能力几乎为高中生水平。

> Q: 可以让 `STOP_ADDR:      en     <= 1'b0;`这句话延迟 3 个时钟周期执行吗？
> ```verilog
> module Auto_Read #(
>     parameter DATA_WIDTH = 8,
>     parameter ADDR_WIDTH = 6,
>     parameter JUMP_FROM_ADDR = 6'b001111,
>     parameter JUMP_TO_ADDR   = 6'b011010,
>     parameter STOP_ADDR      = 6'b100100,
>     parameter COUNTER_MAX = 16
> )(
>     input  wire                    por,        // Power-on reset, active low
>     input  wire                    clk,        // Clock input
>     input  wire [DATA_WIDTH-1:0]   DOUT_reg,   // Serial data input from MTP_Interface
>     output reg                     en,         // Enable signal
>     output reg  [DATA_WIDTH-1:0]   data_0,     // Parallel output to Reg_File
>     output reg  [ADDR_WIDTH-1:0]   addr_0,     // Main counter (row address to MTP_LUT, and address to Reg_File)
>     output reg                     READ_0      // READ_0 signal to MTP_Interface
> );
>     reg [4:0] counter;
>     reg [1:0] en_d;
> 
>     always @(posedge clk, negedge por) begin
>         if (!por) begin
>             addr_0      <= {ADDR_WIDTH{1'b0}};
>             data_0      <= {DATA_WIDTH{1'b0}};
>             en          <= 1'b1;
>             en_d        <= 2'b00;
>             READ_0      <= 1'b0;
>             counter     <= 0;
>         end
>         else begin
>             en_d <= {en_d[0], en}; // delay READ_0 by two clock cycles
>             if (en_d[1]) begin
>                 if (counter == COUNTER_MAX) begin
>                     READ_0      <= 1'b0;
>                     counter     <= 0;
>                     data_0      <= DOUT_reg;
>                     case (addr_0)
>                         JUMP_FROM_ADDR: addr_0 <= JUMP_TO_ADDR;
>                         STOP_ADDR:      en     <= 1'b0;
>                         default:        addr_0 <= addr_0 + 1'b1;
>                     endcase
>                 end else begin
>                     READ_0 <= 1'b1;
>                     counter <= counter + 1'b1;
>                 end
>             end
>         end
>     end
> ```
>
> 
> 参考答案：
>
> ```verilog
>          ...
>          en_d <= {en_d[0], en};
>          stop_d <= {stop_d[1:0], (addr_0 == STOP_ADDR && en_d[1])};
>          if (en_d[1]) begin
>              if (counter == COUNTER_MAX) begin
>                  READ_0      <= 1'b0;
>                  counter     <= 0;
>                  data_0      <= DOUT_reg;
>                  case (addr_0)
>                      JUMP_FROM_ADDR: addr_0 <= JUMP_TO_ADDR;
>                      default:        addr_0 <= addr_0 + 1'b1;
>                  endcase
>                  if (stop_d[2]) begin
>                      en <= 1'b0;
>                  end
>              end else begin
>                  READ_0 <= 1'b1;
>                  counter <= counter + 1'b1;
>              end
>          end
>          ...
> ```
>
> 不好的答案：

> Q: 椭圆内接三角形的一个顶点在椭圆的右侧(a,0)，另外两个顶点分别在椭圆的上顶点 (0,b) 和下顶点 (0,-b)。如果椭圆不是正着放在直角坐标系中间，而且还旋转了，我应该如何用一句话描述这个三角形？
>
> 参考答案：一椭圆内接三角形的其中一个顶点是椭圆长轴的一个端点，另外两个顶点是椭圆短轴的两个端点。一个以椭圆长轴一个端点和短轴两个端点为顶点的椭圆内接等腰三角形


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
> ```python
> def accumulate(x):
>     sum = 0
>     for counter in range(x):
>         sum = sum + x
>     return sum
> ```
>
> 这个函数执行什么功能？输入 4 后是不是输出 3+2+1+0=6 ？
>
> A: https://www.zhihu.com/question/616737341




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
> 
> 正确情况：Sonnet 3.5 Oct. 对, gemini-exp-1206 错错错, Gemini 1.5 Pro 2 错, o1-mini 对对, llama-3.1-405b / 3.3-70b 对对对, 4oL 错错


## 评测的小 ideas

### Bode

由 Bode 图想到是不是可以使用 Bode 图的方式更好的展示不同模型在不同难度下的性能情况。在简单的情况下，小模型的表现有可能会比没有特调过的大模型好；而在多种测试条件下表现良好的小模型在复杂问题下的能力衰退可能会很快，然后如果要求平均能力，直接求个积分就行。如果需要多领域的情况可以使用六边形的立体 Bode 图。

但是这个图要求我们有大量不同难度的测试集，其中比较容易想到的是数学的评估，因为其客观性比较强，我们可以将横轴取小学6年，中学6年，本科4年，硕士3年，共19各数据点的原创数学试题作为评估，拟合出一些漂亮的数学能力 Bode 图。或是小学奥数+初中奥数+高中奥数等...

![](https://github.com/user-attachments/assets/3e18c5c2-ea11-467b-bcbf-2a72b52f77e0)

### 批判性思维和综合能力

- 传统选择题形式的类 GPQA 评测 + 填空题形式的类 GPQA 评测 + 没有一个选项正确的选择题形式的类 GPQA 评测
- 1+1=2: Are you sure? / rethink / recheck
