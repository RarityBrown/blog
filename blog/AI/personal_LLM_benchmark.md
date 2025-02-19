# My Personal LLM Benchmark and Thoughts on LLMs

考虑到各种 Benchmark 泄露严重，现在基本上只参考 Arena Hard Prompts (Overall) with Style Control 作为 Benchmark。

同时，在平时使用过程中，收集选择一些截至 2025 年 2 月的第一梯队 LLM (o1, o3-mini-high, r1, 4oL, Sonnet 3.5, Gemini 2 Pro, 2-flash-thinking) 中部分 LLM 可以答对，部分 LLM 不能答对的适中难度题目，整理于本文。难度过大的，例如~~解个明年的高考数学压轴题~~(我估计 2025 年 6 月的时候可能真可以满分)、明年的物理系考研压轴题(我估计 2025 年 12 月的时候可能真可以满分)、写个更好的红楼梦后 40 回、写个 Windows 出来、~~证个哥德巴赫猜想~~等；以及难度过小的，例如 MMLU 都拉不开区分度。

## 一些个人观点

2024/08/22: 我认为 LLM 的发展向“知识库”方向发展比较有前景，像 Mistral 堆代码和数学的训练数据是错误的方向，数学和代码需要很不一样的训练手段，例如 AlphaGeometry。如果依靠现在 LLM 的训练方式，可能需要 500T 级别的参数量级（此时数据的来源又是一个问题）才能达到人类行业中上水平，或者说认为 GPT-5 的水平会接近业内平均水平，这当然是一个了不起的成就，但是也意味着受限于（目前可预估的）算力，至少在未来 30 年内，不可能通过这种通用 LLM 的方式到达超过业内的 top 10% 水平。类似的，人脑中负责语言和数学的中枢显然也是两个。

2024/11/03: o1p 出来有段时间了，试用了几次，颇为惊艳，其数学能力可以说从速度和质量上绝对已经超过工科学生闭卷平均水平（当然，如果允许学生使用 MATLAB, Python 等工具则是另当别论，因为这也是工科学生典型的场景），而数学和物理等专业较为优秀的学生尚与 o1p 有一战之力。

2024/11/21: 究竟什么容易被 AI 替代？在 Gen-AI 出来之前，主流观点认为 Art 和 Scientific-Research 是 AI 难以替代的两座高山；Gen-AI 井喷式增长后，人们又认为 STEM 相较于文科难以被 AI 替代。从传统的角度思考，我们可以认为 

- ①资料易于被数字化、资料数字化程度高
- ②可用于训练的资料内容多、质量高、定量化评价体系清晰
- ③产出形式单一、数字化程度高

的行业容易被取代。我们不妨先举几个例子：程序员、作家在这种评价标准下容易被取代，而流水线工人（注意此处讨论的是 AI 而不是自动化）、保险经纪人在这种评价指标下难以被取代。司机在媒体的宣传中是非常容易被取代的职业，但是它并不满足我们提到的要求，直到 Tesla FSD V12 的出现。我们细化这三点的同时再举一些例子：

- 满足①而不满足②③的例子是最广泛，有法律、作曲家等一系列所谓的“白领”，每天和电脑打交道的时间长于和人打交道的时间。
- ②可用于训练的资料内容多且质量高，不代表这些数据要是公开的或者开源的，只要有数据即可。例如画家反对 AI 训练，但是大公司直接无视法律风险，直接继续使用大量数据训练；Tesla 收集全球用户的驾驶数据用于训练 FSD。从 2022 LLM 高考语文的水平高于高考数学，到 2025 LLM 满分的高考数学和略微进步的高考语文，就是定量化评价体系中的差别。AlphaGo 也是同理，首先竞技性游戏的评价极为单一和清晰，其次，使用合成棋谱进行 RL。
- ③程序员相较于产品经理恐怕更危险。更宏观的，技术员相较于管理者可能更危险，不过这也是千百年来的主流了。但是这非常危险，因为虽然 AlphaGo 的出现并没有使围棋从业者显著减少，但是对于对着电脑的工程师可没有什么*艺术*可言（会有一些传统和固执工程师说做到极致就是*艺术*，我们先不论证这个），残忍地说，当螺丝钉不能发挥其作用时，其归宿只有垃圾堆。
- 三点都不满足的有农民、蓝领、服务业，这类往往是我们所忽视的“大多数”。当然，实时表演艺术（不包括画家、作曲家，但包括杂技、演奏者）也是难以被直接替代的，但是这就是一个小众领域了。

2025/02/07: **2025 年不会是 AI Computer Agent 的元年。** 更悲观的说，2025 年的 Agent 就像 2000 年本田开发的 ASIMO，年年是元年，但是恐怕始终难堪大用。主要是两点原因：①目前多模态模型的部分短板仍远逊于普通人 ②Agent 在工程上是一个很复杂的问题，Agent 意味着从做题到实践的巨大进步，而且短时间内难以通过基模的提升来解决。其他一些小问题，比如 context window 短、模型后天学习能力、强基模延迟高速度慢价格高、Agent Benchmark 不明晰等等问题，都有望在 2025 年解决。当然啊，还有一个房间里的大象——非公开语料，这对于 AGI 和 Agent 都没有影响，但是对于更好地帮助工作可能有一定影响，因此我相信非公开语料已经不是 OpenAI 和 Google 所关心的主要内容了。

OpenAI 的 Operator 和 Deep Research 从目前的能力上来看还是做题，而非 Agent：Operator 目前只能完成定义清晰、目标明确的简单网页操作，而 Deep Research 更像是一个以自己知识面作为常识，结合公开信息作为辅助判断的做题者。AI Agent 的第一步就是*完全*取代中低端程序员，这也是 Agent 中最简单的一步，配合①更强的多模态模型 ②context window 的 trick ③联网搜索的 trick，还是有机会在 2025 年晚些时候实现的，因为这满足 2024/11/21 观点三条特征。但是正如 AI 永远无法到达 100% 正确率的彼岸一样，不要小看*完全*二字啊，从需求到 demo 完全不用人辅助的一次成功率恐怕在 2025 年难以突破 50%。至于 OpenAI 机器人？那更是遥远的彼岸，会和可控核聚变一样，被物理世界的残酷一次次拖延。未来可能是通过 AI 辅助编写并创新传统的控制方式代码，来实现可以操作物理世界的 Agent ？不过这太远了，我站得太低，而地球又是个球，看不到彼岸啊。

我们在 2025 年期望看到什么？知识面更广更深的做题模型，但是快到头了，而且很显然到不了 AGI；更好的多模态模型，仍有不少发展空间；更多基于 AI 的可有可无的软硬件，火得很，但并非未来；一些打着通用 Agent 旗号的专用 Agent。没有了。人们追求 Scaling Law 的能力远不如追求 Moore's Law 的能力，而不是说 Scaling Law 已经失效了。LLM 会被写入历史书吗？有可能，但是最多最多就是边角的一块豆腐干罢了。

2025/02/15: 从种种小众代码的场景来看，LLM 对训练数据的利用率太低。所以唱一个反调：pre-training 未必到头，只能说基于 GPT 形式和传统 pre-training 方式的、通过 scale-up 来提升性能的 pre-training 到头了。预计 200B 左右 (4o, Sonnet 4, Llama 4) 的 Dense 或者 MoE 的 LLM 仍有不小的提升空间才会饱和（如果要定量的话，认为 200B LLM (w/o RAG) 在 2025 年底达到 GPQA/SimpleQA 90%+；另外一个预测是 HLE/SciCode(Main) 40%+，只不过 pre-training 在其中作用不大了）。唉，还是在做题啊。不过也好，更强的做题能力确实是 Agent 的必要条件。

2025/02/19: 从 GPT3.5-Turbo 到 GPT4 再到 Grok3 的 Arena Hard w/ Style Control 两两间的分差大概都是 100+ 的样子。100分对应64%的胜率，200分对应76%的胜率，很难想象 Grok3 对 GPT3.5-Turbo 的优势居然不是 90%+。由此可见，让普通用户问普通问题是无法高效区分 LLM 能力的。


## 题目列表

[你都有哪些压箱底的测试题，是目前的推理模型做不出来的？ - 知乎](https://www.zhihu.com/question/11758906952)

### 语言和创造力

主要是三部分内容：

1. 语言中的知识
2. "情商", unspoken rules, unspoken expectations
3. 语言中的创造力

> Q: 一个双耳旁两个木读啥（将回答限制在 10 字符以内）
>
> 正确答案：郴（chēn）
>
> 正确情况：Gemini 2 Pro 对对

> Q: Tea and coffee are available, but liquor, wine or beer (?) not.   are / is
>
> 正确答案：is
>
> 正确情况：Gemini 2 Pro 对对, 4oL 对

> Q: This paper should be otherwise read as if aimed at an audience not expert in control. aimed 在从句中是表语。整体句子的结构中起什么语的作用？是状语补语？宾语补语？状语？定语？
>
> 参考答案：as if \[it were\] aimed at ... 状语？装补？我也不确定

> Q: "赣南师大"有一个梗是"江南 style"，为什么赣和江发音相近？
>
> 正确答案：gànnan 和 gangnam
>
> 正确情况：o3-mini 错

> Q: 椭圆内接三角形的一个顶点在椭圆的右侧(a,0)，另外两个顶点分别在椭圆的上顶点 (0,b) 和下顶点 (0,-b)。如果椭圆不是正着放在直角坐标系中间，而且还旋转了，我应该如何用一句话描述这个三角形？
>
> 参考答案：以椭圆长轴一个端点为顶角顶点、短轴两个端点为底角顶点的椭圆内接等腰三角形

> Q: Delaying graduation because of an exchange program vs. Going on an exchange program because of delayed graduation; Female college student engaging in prostitution vs. A fallen young woman persisting to complete her college education; He smokes while praying vs. He prays while smoking. Are there any other similar examples? Give me one.
>
> 典型错误：4oL 之类的模型喜欢“为考试而学习 vs. 为学习而考试”和“为生活而工作 vs. 为工作而生活”之类的，但是显然不如例子中给的那么具有戏剧性。o1p 则可以准确观察到句中戏剧性的原因，但是给出的其他例子也欠佳。

> Q: 在晚宴上嘉宾们觥筹交错，交谈甚欢，这时，一位嘉宾问你：“我们太吵不会影响你吧？” 此时你的回答应该是： A. 不会不会 B. 没有没有。请简要说明理由
>
> 参考答案：A. 不会不会: 隐含承认“吵”这个事实，只是强调“吵”这个事实不会造成影响；**B**. 没有没有: 直接否定“吵”这个前提，表示对方根本不吵，自然也就不存在“影响”的问题

> Q: Chinese alternatives for "the quick brown fox jumps over the lazy dog"
>
> 典型错误：回答古文或诗词
>
> 正确答案：充分体现各种字形，包括左右结构、上下结构等；或是直接翻译也可以（Edge 浏览器的官方做法）

> Q: 设计一道题目：1. 要求 LLM 极易出错，而人类却能轻松解答。所以如果**你**尝试作答后发现可成功正确作答，则说明题目设计不符合要求；2. 题目答案具有客观唯一性。题目不应依赖于实时的、私人的感官信息（例如“现在房间里有什么气味”），而应基于客观事实，类似于“12+21等于几”或“2022年美国总统是谁”这类问题。
>
> 参考答案：文本视觉模式识别（Look-and-say sequence）；脑筋急转弯、谜语；
> 
> 正确情况：Gemini 2 Pro 基本上是 SOTA

### 知识问题（类似于 SimpleQA ）

> Q: 上海四校八大？
> 
> 典型错误：复交同师。基本上只取决对于中文互联网上知识的爬取深入程度和清洗的合理程度，因为这个靠多语言能力翻译没用，同时含有“四校八大”相关的网页内容往往是低质量的。
> 
> 正确情况：4oL 对; Sonnet 3.5 错; Gemini 2 Pro 对; 

> Q: 顺尔宁是 NSAIDs 吗？泰诺呢？开瑞坦呢？双氯芬酸呢？右美沙芬呢？简单回答，即类似于“是、不是、不是、不是、是”。
>
> 正确答案：不是、不是、不是、是、不是。类似地，取决于中文语料，多语言能力翻译没用。这题可以看出不管是开源还是闭源的模型都有明显蒸馏其他家的模型，对于“顺尔宁”这一项的错误认知往往是“顺尔宁就是布洛芬”
>
> 正确情况：Sonnet 3.5 错; 2-flash-thinking 对; Gemini 2 Pro 对; 

> Q: 分别推荐模拟 EDA 领域和数字 EDA 领域中贡献最显著且最有影响力的三人，仅需分别列出英文名字即可，无需介绍他们的贡献
>
> 典型错误：推荐一些不那么有名的人、模拟数字倒置、把 Razavi, Baker, Thomas Lee 之类的人算在模拟 EDA 开发、把 David Patterson, Moore 之类的人算在数字 EDA 开发
>
> 参考答案：Analog: **Donald O. Pederson (SPICE)**, Laurence(Larry) Nagel (SPICE), Arthur Richard Newton (SPICE), Ken Kundert (Spectre); Digital: **Alberto Sangiovanni-Vincentelli**, Kurt Keutzer (Bell Labs, Synopsys, UCB), Aart de Geus (Synopsys), Robert K. Brayton (UCB) 其中加粗项为必答项，其他项有提到一两个且没有提到 Razavi, Moore 等离谱答案则可以认为正确

> Q: The release year of IC Compiler 2? When did ICC1 stop updating?
> 
> 正确答案：2014, 2016
>
> 正确情况：gemini-exp-1121 对对, Sonnet 3.5 对.不会.

> Q: 除了 Logitech MX Master，推荐**一**款有侧向滚轮的鼠标。仅需要名字，无需介绍
> 
> Q: Apart from the Logitech MX Master, recommend **one** mouse with a side scroll wheel. Only the name is needed, no description.
>
> 典型错误：Razer Pro Click, Microsoft Sculpt Ergonomic Mouse
>
> 正确情况：4oL 错, Sonnet 3.5 错

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


> Q: Considering support for various devices (Windows, Mac, Android, iOS without requiring any extra installation, Linux can be ignored), please choose two CJK sans-serif fonts for me?
>
> 正确答案：没有


> Q: customize Word/Powerpoint highlight colors?
>
> 正确答案：就是不行。使用 shading 或文本框背景替代，但是无法被 ctrl+h 搜索到。

### 知识-推理混合问题

#### 代码相关

也许可以搞一个代码复现测试 testbench，将已有的代码提供给 LLM，使用文字描述后，开启一个新 context，使用文字复现已有代码。测试了代码理解能力和代码编写能力，也方便自动化。

##### LaTeX 相关

###### LaTeX

> Q: `A{\scriptstyle{\boxed{A}}}A` box 中的 A 会变小吗？   In the LaTeX expression `A{\scriptstyle{\boxed{A}}}A`, is the boxed "A" rendered smaller? Yes/No without any further explanation.
>
> 正确答案：No
>
> 正确情况：Gemini 2 Pro 错, 4oL 错 

> Q: `\xrightarrow[p+q = a+b+c]{x+y+z = m+n}` How to align at the `=`?
>
> 参考答案：`\xrightarrow[\hspace{-2em}\phantom{x+y+z} p+q = a+b+c \hspace{-2em}\phantom{m+n}]{\hspace{-2em}\phantom{p+q} x+y+z = m+n \hspace{-2em}\phantom{a+b+c} }`

> Q: Draw a cross using `\rule` in latex. The commands `\raisebox`, `\rotatebox`, `\makebox`, `\vspace`, `\noindent`, `\put`, `\par` and `tabular` are not allowed. Width and length of the arms of the cross are 1em and 6em.
>
> 参考答案：
> 
> ```latex
> \rule{1em}{6em} \hspace{-3.5em}            \rule[+2.5em]{6em}{1em}
> \rule{6em}{1em} \kern{-3.5em}              \rule[-2.5em]{1em}{6em}
>
> \rlap{\hskip 2.5em \rule[-3em]{1em}{6em}}  \rule[-0.5em]{6em}{1em}  % laps? \smash?
> ```

> Q:
> 
> ```latex
> \[
> \begin{cases} l\ddot{\theta}=g\sin\theta-\ddot{x}\cos\theta  \\ y=x+l_0\sin\theta+n \end{cases} \xRightarrow{\displaystyle \theta \sim 0} \begin{cases} l\ddot{\theta}=g\theta-\ddot{x}  \\ y=x+l_0\theta+n \end{cases} % How to add a new line here?
> \xRightarrow{\displaystyle \mathcal{L}} \begin{cases} Y = \dfrac{(l-l_0)s^2 - g}{s^2(Mls^2-(M+m)g)}(U + R) + N \end{cases}
> \]
> ```
>
> 参考答案：加上 `\begin{gathered}` 或 `\begin{align*}` 等环境
>
> 正确情况：Gemini 2 Pro 对, Sonnet 3.5 错错(提醒后对), experimental-router-0207 错错(提醒后对), grok3 对

> Q: The `\rightarrow`, `\xrightarrow{}` and `\uparrow` are commands available in LaTeX, but how to achieve `\xuparrow{}`, a lengthened vertical arrow with text *beside* it, analogous to how `\xrightarrow[\begin{cases}1\\2\end{cases}]{\begin{gather}x+y \\ \sin +\sum \\ x+y+z \end{gather}}` creates a lengthened horizontal arrow with text *above* and *below* it. `amsmath` and `mathtools` are available, but TikZ, `graphicx` or `calc` is not.  (Hint: `\left.\vphantom{#1}\right\uparrow` to achieve extensible arrow.)
>
> 参考答案：
>
> ```latex
> \newcommand{\xuparrow}[2][]{
>     \hspace{0.3em}{\scriptstyle{#1}}\hspace{-0.3em}
>     \left.\vphantom{#1#2}\right\uparrow
>     \hspace{-0.3em}{\scriptstyle{#2}}\hspace{0.3em}
> }
>
> A \xuparrow[\begin{cases}1\\2\\3\\4\\5\\6\\7\end{cases}]{\begin{aligned}x+y \\ \sin +\sum_i \\ x+y+z \end{aligned}} B
> ```
> 

> Q: Why the `\scriptstyle` does not work for `\scriptstyle{\scriptstyle{\scriptstyle\begin{cases}A \\B+\sum_i \end{cases}+\scriptstyle\begin{aligned}1\\2\\3\end{aligned}}}`? How to make it work without applying `\scriptstyle` to every individual lines?
> 
> 参考答案：目前来看没办法。只能通过 `\scriptsize` 模拟实现。`\mathchoice` `\crampedclap` `\forcedscriptstyle` 等命令也无用。

> Q: How to make $\boldsymbol{\tau_{Y}}$ even bolder without any other formatting change and without `\usepackage{bm}`? Answer within 1 line in a code block.
>
> 参考答案：`\pmb{\boldsymbol{\tau_{Y}}} \boldsymbol{\pmb{\tau_{Y}}}`

###### MathJax / KaTeX

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

###### tikz

> Q: use CircuiTikz to draw a basic common source without bias or ac coupling
>
> 参考答案：
>
> ```latex
> \ctikzset{
> 	bipoles/thickness=1,  % \ctikzset{resistors/thickness=1}
> 	monopoles/ground/thickness/.initial=1,
> 	monopoles/ground/connectionthickness/.initial=1,
> 	monopoles/tground/thickness/.initial=1,
> 	transistors/thickness=1.618,
> 	% \ctikzset{transistors/scale=1.2}
> 	resistors/scale=0.75,
> 	capacitors/scale=0.65,
> 	transistors/arrow pos=end,
> 	tripoles/mos style/arrows,
> 	tripoles/pmos style/emptycircle,
> 	resistors/zigzag hook/.code={\pgfsetroundcap\pgfsetroundjoin},
> 	resistors/zigzag stub=0.02,
> }
> 
> \begin{circuitikz}[american, line width=1.6pt]
>     % \draw (0,0)                                   node[nmos, font=\sffamily\bfseries] (M1)  {M1};
> 	    % \draw (0,0)                                   node[nmos] (M1)  {\textbf{\fontfamily{phv}\selectfont M1}};
>     \draw (0,0)                                   node[nmos] (M1)  {\textbf{\fontspec{Segoe UI}M1}};
>     \draw (M1.gate)    to [short, -o]   ++(-1,0)  node[left]       {$V_{in}$};
>     \draw (M1.source)                             node[tlground]   {};
>     \draw (M1.drain)   to [R=$R_D$]     ++(0,2)   node[tground]    {$V_{DD}$};
>     \draw (M1.drain)   to [short, *-o]  ++(1,0)   node[right]      {$V_{out}$};
> \end{circuitikz}
> ```


> Q: use CircuiTikz to draw a basic two-stage amplifier in CMOS with differential input and common source output
>
> 参考答案：
>
> ```latex
> \begin{circuitikz}[american, line width=1.6pt]
> 	\draw[help lines] (0,0) grid (6,6);
> 	
> 	% Stage 1: Differential pair with current mirror load
> 	\draw
> 	(0,4) node [pmos, xscale=-1] (M3) {\ctikzflipx{$M_3$}}
> 	(2,4) node [pmos] (M4) {$M_4$}
> 	(M3.source) -- ++(0,0.2) coordinate (vdd1)
> 	(M4.source) -- ++(0,0.2) coordinate (vdd2)
> 	% (vdd1) -- (vdd2)
> 	(M4.gate) -- (M3.gate)
> 	(M4.gate) |- (M3.drain);
> 	
> 	\draw
> 	(0,2) node [nmos] (M1) {$M_1$}
> 	(2,2) node [nmos, xscale=-1] (M2) {\ctikzflipx{$M_2$}}
> 	(M1.drain) -- (M3.drain)
> 	(M2.drain) -- (M4.drain)
> 	(M1.gate) to[short, -o] ++(-0.2,0) node[left] {$V_{in}^-$}
> 	(M2.gate) to[short, -o] ++(0.2,0) node[right] {$V_{in}^+$};
> 	
> 	\draw
> 	($(M1.source)!0.5!(M2.source)$) ++(0,-0.5) node[nmos, anchor=drain] (M5) {$M_5$} % Corrected: Anchor at drain
> 	(M5.source) -- ++(0,-0.2) coordinate (gnd1)
> 	(M1.source) -| (M5.drain)
> 	(M2.source) -| (M5.drain)
> 	(M5.gate) to[short, -o] ++(-0.5,0) node[left] {$V_{bias1}$};
> 	
> 	% Stage 2: Common source amplifier
> 	\draw
> 	(6,0) node [nmos] (M6) {$M_6$}
> 	(6,4) node [pmos] (M7) {$M_7$}
> 	(M7.source) -- ++(0,0.2) coordinate (vdd3)
> 	(vdd1) -- (vdd3) node[above] {VDD} % VDD track
> 	(M6.source) -- ++(0,-0.2) coordinate (gnd2)
> 	(gnd1) -- (gnd2) node[below] {GND} % GND track
> 	(M6.gate) to[short, -o] ++(-0.7,0) node[left] {$V_{bias2}$}
> 	(M6.drain) -- (M7.drain)
> 	(M6.drain) -- ++(0, 1.23) to[short, -o] ++(1,0) node[right] {$V_{out}$};
> 	
> 	% connect two stage
> 	\draw (M4.drain) |- ++(1,-0.23) coordinate (Vo1) -- ++(1/3,0)  to[R=Rz] ++(4/3,0) to[C=Cc] ++(4/3,0);
> 	\draw (Vo1) |- (M7.gate);
> \end{circuitikz}
> ```

##### 前端开发全流程

背景：

- 准备通过 Electron + React  + Vite + TypeScript 在 Windows 上写一个小工具 app
- 但是我对前端开发一无所知，准备全部依赖于 LLM 实现开发
- 首先通过跑几次 LLM，大致知道了环境配置流程
  - 创建 Vite 项目
  - 安装 Electron
  - 项目文件夹结构创建与调整
  - 编写 Electron 主进程文件
  - 配置 `package.json`
- 以下是一个初学者在开发过程中，按照时间顺序遇到的、无法被 LLM 很好解决（或者 LLM 没有意识到）的问题 

> Q: 
> 
> ```
> `npm create vue@latest` 如何自动给如下参数
> √ Project name: mathforge
> √ Add TypeScript? ... Yes
> √ Add JSX support? ... No
> √ Add Vue Router for Single Page Application development? ... Yes
> √ Add Pinia for state management? ... Yes
> √ Add Vitest for Unit testing? ... No
> √ Add Cypress for E2E testing? ... No
> √ Add ESLint for code quality? ... Yes
> √ Add Prettier for code formatting? ... Yes
> ```
>
> 参考答案：目前来看是没有办法实现全自动传参的。（这些选项的选择建议也是通过 AI 先行给出的）
>
> 正确情况：o3-mini-median-search 错, 2-flash-thinking 错错, 4oL 半对

> Q: 帮我用 PowerShell 写一个脚本：1. 现有 src 目录下的所有东西都移动到 src/renderer 中（src/renderer 还不存在）2. 在 src 创建 main, shared 两文件夹。运行中多加一点状态提示。
>
> 典型错误：使用在 PowerShell 脚本中使用中文字符串。Windows 11 默认预装 PowerShell 5.1 默认编码格式不是 UTF-8，而保存的 `.ps1` 脚本的编码格式默认是 UTF-8。导致脚本无法正确运行。
>
> 参考答案：使用纯英语撰写 ps 脚本；提示编码问题；建议更新 PowerShell 7


Q: 

通过如下命令：

```shell
npm create vite@latest mathforge  # (React - Typescript)
cd mathforge
npm install
npm install electron electron-builder --save-dev
npm install @electron/vite-plugin.js --save-dev
```

用 React + Vite + Electron + Typescript 开发应用的 `package.js` 中的 `scripts` 应该怎么写（别的字段不用写）？ Vite 自动生成的 `scripts` 如下：

```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "lint": "eslint .",
    "preview": "vite preview"
    
    // 需要写的 electron:build 等等
  },
```

Q: 用 React + Vite + Electron + Typescript 开发应用

```shell
npm create vite@latest mathforge # (React + Typescript)
cd mathforge
npm install
npm install electron electron-builder --save-dev
```

下一条命令应该是什么？



##### Python 小众库

> Q: 在 R3 的左侧，即 R4 的下侧，添加一个接地符号
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += elm.Resistor().label('R1')
>     d += elm.Resistor().label('R2').down()
>     d += elm.Resistor().label('R3').left()
>     d += elm.Resistor().label('R4').up()
> d.draw()
> ```
> 
> 参考答案：
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += elm.Resistor().label('R1')
>     d += elm.Resistor().label('R2').down()
>     R3 = elm.Resistor().label('R3').left()
>     d += R3
>     d += elm.Resistor().label('R4').up()
>     
>     d += elm.Ground().at(R3.end) # or d += elm.Ground().at(R4.start)
> d.draw()
> ```



> Q: 这是电容的一阶时间常数电路图，画一个电感的，和电容的图并排放置
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>  d.add(elm.Ground())
>  d.add(elm.SourceV().label('$V_{in}$'))
>  d.add(elm.Switch(action='close').right().label('S'))
>  d.add(elm.Resistor().right().label('$R$'))
>  d.add(elm.Dot(open=True).label('$V_{out}$'))
>  d.add(elm.Capacitor().down().label('$C$'))
>  d.add(elm.Ground())
> 
>  d.draw()
> ```
>
> 参考答案：
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Resistor().right().label('$R$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Capacitor().down().label('$C$'))
>     d += (elm.Ground())
>     
>     d.move(3, 0)
>     
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Inductor().right().label('$L$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
>     
>     d.draw()
> ```
>
> 正确情况：o1错,
>
> 两个关键点：1. `d.move(3, 0)` 2. RC, LR 的顺序


> Q: 这是电压源激励的一阶电路，在同一幅图下面画上电流源激励的一阶电路
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Resistor().right().label('$R$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Capacitor().down().label('$C$'))
>     d += (elm.Ground())
>     
>     d.move(3, 0)
>     
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Inductor().right().label('$L$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
>     
>     d.draw()
> ```
>
> 参考答案：
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Resistor().right().label('$R$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Capacitor().down().label('$C$'))
>     d += (elm.Ground())
>     d.move(3, 0)
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Inductor().right().label('$L$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
> 
>     d.move(-15, -5)
>     
>     d += (elm.Ground())
>     d += (elm.SourceI().label('$I_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Dot())
>     d += (R1 := elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
>     d += (elm.Line().right().at(R1.start))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Capacitor().down().label('$C$'))
>     d += (elm.Ground())
>     d.move(3, 0)
>     d += (elm.Ground())
>     d += (elm.SourceI().label('$I_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Dot())
>     d += (R2 := elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
>     d += (elm.Line().right().at(R2.start))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Inductor().down().label('$L$'))
>     d += (elm.Ground())
>     
>     d.draw()
> ```

##### MATLAB

> Q: Make `15/9*1e-12` symbolic in matlab within one line. Your answer should be simple.
>
> 典型错误：`expr = sym(15/9 * 1e-12);` 结果有浮点误差
> 
> 正确答案：`expr = 15/9*str2sym('10^(-12)');` 或 `sym(15)/sym(9)*sym(1e-12)` 之类把 1e-12 单独拿出来

##### Mermaid

> Q: How to print quotes within a node in a Mermaid flowchart? Answer within 1 line in a code block.
>
> 典型错误：`A["Node with \"quotes\""]`
>
> 正确答案：`A["Node with #quot;quotes#quot;"]` ref: [link](https://mermaid.js.org/syntax/flowchart.html#entity-codes-to-escape-characters)
>
> 正确情况：o1p 错错错; 4oL 错错错错; secret-chatbot 对对对错错; Sonnet 3.5 错错错错; Gemini 2 Pro 错错错错错错
>
> 思考：泛化和对齐未必是好事，也可能增加幻觉（gemini-exp-1114 小概率答对）；说“不会”的能力，目前主流方向是让模型强到没有不会的问题；模型应知道何时调用搜索，如何参考信源


> Q: 第几行代码不符合 Mermaid 语法要求，会导致报错？直接简单回答行号，例如，"2, 30, 31"
> 
> ```
> graph TD
>     subgraph Attempt 4: \genfrac and Prime Symbol
>         V[Use \genfrac or similar construct] --> W(Build vertical arrow with text)
>         W --> X[Consider using prime symbol (') for arrowhead]
>         X --> Y[Probably won't look like an up arrow]
>         AC[Use \left\uparrow and \vphantom to control height] --> AD(Test this approach)
>         AD --> AE[\left and \right are for delimiters, \uparrow has fixed sizes]
>         AE --> AF[Doesn't stretch infinitely, chooses from available sizes]
>     end
> 
>     subgraph Attempt 7: \stackrel, \underset, \overset
>         AG[Consider \stackrel] --> AH(For stacking symbols *over* each other)
>         AH --> AI[User wants text *beside* the arrow]
>         AI --> AJ[\underset and \overset place text above/below]
>         AU[Use \vcenter to center arrow and text] --> AV(Create box with arrow and text side-by-side)
>         AV --> AW[\vcenter centers them vertically, but arrow doesn't lengthen]
>         AW --> AX[Arrow height should match text height]
>         BA --> BB[How to implement without graphicx/TikZ?]
>         BB --> BC[Use \vphantom{#1} to get text height]
>         BC --> BD[But how to stretch arrow vertically?]
>         BE[Arrowhead (\uparrow)] --> BF(Vertical shaft (rule) matching text height)
>         BG --> BH[Standard \uparrow is a compound character]
>         BH --> BI[Break into parts or extend shaft?]
>         BI --> BJ["Draw" arrow: vertical rule + arrowhead]
>         BO --> BP[Use \setbox, \ht, \dp, \dimen, \mkern, \llap]
>         BP --> BQ[Final Code: \newcommand{\xuparrow}[1]{% \setbox0=\hbox{$\scriptstyle#1$}% \dimen0=\ht0 \advance\dimen0 by \dp0 \mathrel{\uparrow\mkern-5mu\rule[-.7ex]{0.4pt}{\dimen0}\llap{$\scriptstyle#1$}}% }]
>         BQ --> BR[Explanation of the code and its limitations]
>         BR --> BS[Acknowledge approximation and need for fine-tuning]
>     end
> 
>     BS --> Final[Final Answer: \boxed{\xuparrow}]
> ```
>
> 正确答案：4, 7, 11, 14, 16, 19, 21, 26, 31

##### AHK

> Q: How to send the string "{\" (a left brace + a backslash) in ahkv2 using the `Send` function? Answer within 1 line in a code block.
>
> 正确答案：`Send('{{}\')` or `Send "{Raw}{\"` or `Send("{{}" Chr(92))`
>
> 正确情况：Gemini 2 Pro 错, o3-mini-high 错对错, o3-mini 错, o1 错错, 4oL 对, Haiku 3.5 对对, Sonnet 3.5 对


> Q: two ways to simplify this
> 
> ```ahk
> #Requires AutoHotkey >=2.0
>    :?*:1/:: {
>        Send '\frac{{}1{}}{{}{}}{Left 1}'
>    }
>    :?*:2/:: {
>        Send '\frac{{}2{}}{{}{}}{Left 1}'
>    }
>    :?*:3/:: {
>        Send '\frac{{}3{}}{{}{}}{Left 1}'
>    }
>    ; ...
>    :?*:9/:: {
>        Send '\frac{{}9{}}{{}{}}{Left 1}'
>    }
> ```
>
> 参考答案：
>
> ```ahk
> #Requires AutoHotkey >=2.0
> 
> loop 9 {
>     num := A_Index
>     Hotstring(":?*:" . num . "/", "\frac{{}" . num . "{}}}{{}{}}{Left 1}")
> }
>
> #Include RegExHotstring.ahk ; https://github.com/8LWXpg/RegExHotstring/blob/master/RegExHotstring.ahk
> RegExHotstring("(\d+)/", "\frac{{}$1{}}{{}{}}{Left 1}", "?*")
> ```


#### 专业相关问题

> Q: 以下这段话有什么根本性的事实错误（正确、不完整、略有不严谨、正确但笼统、正确但过于简单的部分均无需列出与分析）？无机半导体是一种具有特殊电子性质的材料，它在电子学和光电子学领域有着广泛的应用。本文将介绍无机半导体的基本概念、特性以及其在实际应用中的重要性。无机半导体是指由无机材料构成的半导体材料。与有机半导体不同，无机半导体的导电性主要是由其晶体结构和化学成分决定的。具体而言，无机半导体通常是由金属和非金属元素组成的化合物，如二硫化锌、氧化镓等。这些化合物具有特殊的晶体结构，使得它们的电子能带结构在一定温度范围内呈现出半导体的特性。无机半导体的最重要特性之一是能带结构。能带结构决定了材料的导电性质。在无机半导体中，通常存在着价带和导带两个能带。价带中的电子处于较低的能量状态，而导带中的电子处于较高的能量状态。当外界施加电场或加热材料时，一部分价带中的电子会跃迁到导带中，形成自由电子和空穴。这种电子和空穴的运动就是电流的基础。无机半导体的导电性还与掺杂有关。掺杂是指在材料中引入少量的杂质，以改变其导电性质。掺杂可以分为N型和P型两种。在N型掺杂中，引入的杂质具有多余的电子，这些电子可以自由移动，从而增加材料的导电性。而在P型掺杂中，引入的杂质具有少了一个电子的空位，这些空位可以被电子填充，形成空穴，从而增加材料的导电性。N型和P型材料的结合可以形成PN结，这是半导体器件中最基本的结构之一。无机半导体在电子学和光电子学领域有着广泛的应用。例如，半导体二极管是一种常见的电子器件，它利用PN结的特性实现了电流的整流和放大。此外，无机半导体还广泛应用于太阳能电池、激光器、光电探测器等领域。这些应用使得无机半导体成为现代高科技产业的重要基础材料。无机半导体是一种具有特殊电子性质的材料，它在电子学和光电子学领域有着广泛的应用。无机半导体的导电性质与其能带结构和掺杂有关，这使得它成为实现电流控制和光电转换的重要材料。对于人类社会的科技进步和经济发展而言，无机半导体的研究和应用具有重要意义。
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
>
> 正确情况（使用**什么**作为关键词）：o3-mini-high 1;

> Q: !(AB+C) 逻辑表达式对应的 standard cell 叫什么？在 CMOS 逻辑中需要几个 MOSFET？
>
> 正确答案：2-1 AND-OR-Invert gate (AOI21), 6个
>
> 正确情况： o1 对, 3-opus 半对, 2-flash-thinking 对对对对, Gemini 2 Pro 半对

> Q: 理想 LC tank 有 τ 吗？从以下几方面思考 1. τ 的定义是什么？2. LC tank 是几阶系统？给出总计 30 个字以内的解答。
>
> 正确答案：没有。因为 τ 针对 first-order LTI, LC tank 是二阶系统

> Q: NMOS 弱反型区电流公式？（不要在最终结果中带 $I_{d0}$ 或 $I_S$ ，写在 latex code block 中）
>
> 正确答案： $I_d = \left[ \mu C_{ox} \dfrac{W}{L} (n-1) V_t^2 \right] \exp\left(\dfrac{V_{gs} - V_{TH}}{n V_t}\right) \left(1 - \exp\left(-\dfrac{V_{ds}}{V_t}\right)\right)$
>
> 正确情况：o1p 漏了 (n-1) 项; Sonnet 3.5 对; big-engine-test 对; 3-opus 对

> Q: 随便找一篇专业相关的论文的一大段，令其翻译至中文
>
> 典型错误：大部分 LLM 会存在不同程度的专有名词翻译错误，最典型的是 device 没有翻译成“器件”。


> Q: PCIe 6.0 x8 的双向速度上限？以 GB/s 为单位。
>
> 正确答案：[121 GB/s](https://en.wikipedia.org/wiki/PCI_Express#Comparison_table)


> Q: PSRR of 5T-OTA in $g_m$ and $r_o$?
>
> 正确答案：对于 PMOS 输入的 5T-OTA 有 $\text{PSRR}_+\approx\dfrac{1}{2g_{m,\text{current mirror}}r_{o,\text{tail}}}  \qquad  \text{PSRR}_-=1$
>
> 这道题好像有一些过难了，如果通过记忆来回答的话训练中的可参考语料太少，如果通过推理来回答的话 LLM 对于电路这一块的推理能力几乎为高中生水平。

#### 其他

> Q: 6米长的竹竿能否通过高4米宽3米的门？6米长的队伍能不能通过高4米宽3米的门？ [ref](https://zhuanlan.zhihu.com/p/23434595912)
>
> 正确答案：可以, 可以
>
> 正确情况（都答对算对）：o3-mini-high 对对对, 4oL 错, 2-flash-thinking 错错, o1 错, Gemini 2 Pro 错, grok3 错

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


> Q: 1 fJ 的能量可以使一个质子加速到多少速度？1 nJ 呢？如果是对于光子呢？ 1 fJ of energy can accelerate a proton to what speed? What about 1 nJ? And what about for photons?
>
> 正确答案： $1.093 \times 10^6 \text{m/s}$, $2.97\times 10^8\text{m/s}=0.9914c$, $\lambda=199\mathrm{pm}$, $\lambda=0.199\mathrm{fm}$


> Q: #D7E8FF + #FFCCCC. Subtractive color mixing result in HEX?
>
> 典型错误：#D7B5CC, #D7B8CC, #D2B4D2, #D7CCCC, #D8CCCC
>
> 正确答案：#EBDAE5, #EBDAE6, #ECDAE6?


> Q: 1145141919810 在任意数字之间插入 +- 使得等式 = 2025 (不用代码，不用过程，仅直接给出两种答案，给出答案后再检查一下正确性)  Insert + or - between the digits of 1145141919810 to make the equation equal to 2025. (No code, no process, just provide two solutions directly. Check the correctness after giving the solutions.)  [ref] (https://www.zhihu.com/question/7671636421/answer/68993839512)
>
> 参考答案：
> 
> - 1 + 1 + 4 + 5 + 14 + 19 + 1981 + 0 = 2025 (原作者)
> - 1 + 14 + 5 + 14 + 1 + 9 + 1981 + 0 = 2025 (o3-min + aid)
> - 11 + 4 + 5 + 14 + 1 + 9 + 1981 + 0 = 2025 (o3-min + aid)
> - 11 + 4 + 5 + 1 + 4 + 19 + 1981 + 0 = 2025 (2-flash-thinking)
> - 11 + 4 + 5 + 1 + 4 + 1919 + 81 + 0 = 2025 (o1-min)
> - 1 + 1 + 4 + 5 + 1 + 41 - 9 + 1981 + 0 = 2025 (o1-min)
>
> 代码遍历：
> 
> - 1+1+4+5+1+41-9+1981+0=2025 1+1+4+5+14+19+1981+0=2025 1+1+4+5+14+1919+81+0=2025 1+1-4-5+1+41+9+1981+0=2025 1+1+45+1+4+1-9+1981+0=2025
> - 1+14+5+1+4+19+1981+0=2025 1+14+5+1+4+1919+81+0=2025 1+14+5+14+1+9+1981+0=2025 1-14+51-4+1+9+1981+0=2025
> - 11+4+5+1+4+19+1981+0=2025 11+4+5+1+4+1919+81+0=2025 11+4+5+14+1+9+1981+0=2025 11-4+51-4-1-9+1981+0=2025
> - 114+5+1+4+1919-8-10=2025 114-5-1-4+1919-8+10=2025
> - 1145+1+41+9+19+810=2025 1145+1+41+919-81+0=2025
> 
> 正确情况：o1-min, o3-mini 对/回答不会/回答不可能, o1 超时, 2-flash-thinking 有时超时




### 批判性-推理问题

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
> 正确情况：Sonnet 3.5 对, Gemini 2 Pro 错错错, o1-mini 对对, llama-3.1-405b / 3.3-70b 对对对对, 4oL 错错, 3-opus 对


## 评测的小 ideas

### Bode

由 Bode 图想到是不是可以使用 Bode 图的方式更好的展示不同模型在不同难度下的性能情况。在简单的情况下，小模型的表现有可能会比没有特调过的大模型好；而在多种测试条件下表现良好的小模型在复杂问题下的能力衰退可能会很快，然后如果要求平均能力，直接求个积分就行。如果需要多领域的情况可以使用六边形的立体 Bode 图。

但是这个图要求我们有大量不同难度的测试集，其中比较容易想到的是数学的评估，因为其客观性比较强，我们可以将横轴取小学6年，中学6年，本科4年，硕士3年，共19各数据点的原创数学试题作为评估，拟合出一些漂亮的数学能力 Bode 图。或是小学奥数+初中奥数+高中奥数等...

![](https://github.com/user-attachments/assets/3e18c5c2-ea11-467b-bcbf-2a72b52f77e0)

### 批判性思维和综合能力

- 传统选择题形式的类 GPQA 评测 + 填空题形式的类 GPQA 评测 + 没有一个选项正确的选择题形式的类 GPQA 评测
- 1+1=2: Are you sure? / rethink / recheck
