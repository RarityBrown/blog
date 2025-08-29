# My Personal Basic Benchmark

考虑到各种 Benchmark 泄露严重，在平时使用过程中，收集选择一些第一梯队 LLM (GPT-5, Gemini 2.5 Pro, Opus 4.1 thinking, Grok 4) 中部分 LLM 可以答对，部分 LLM 不能答对的适中难度题目，整理于本文。难度过大的，例如~~解个明年的高考数学压轴题~~(我估计 2025 年 6 月的时候可能真可以满分，edit: 结果没一个满分，栽在图形上了)、明年的物理系考研压轴题(我估计 2025 年 12 月的时候可能真可以满分)、写个更好的红楼梦后 40 回、写个 Windows 出来、~~证个哥德巴赫猜想~~等；以及难度过小的，例如 ~~MMLU~~GPQA 都拉不开区分度。

### QC 系列

- 加入 QC (Question with Critical Thinking, 题目就是错的)
  - 例如 "证明 $\frac{1}{2}=\frac{2}{2+2-1}$", "Asheville, Akita, Kanazawa 哪个城市没有开过奥运会？"
  - 可以考虑传统选择题形式的类 GPQA 评测 + 填空题形式的类 GPQA 评测 + 没有一个选项正确的选择题形式的类 GPQA 评测。

一个典型的 QC 问答示例：

> Question: 15-4=?  A. 10  B. 9  C. 8  D. 7    Answer within 10 words.
>
> Answer1✔️: The correct answer, 11, is not one of the options. 
> 
> Answer2❌: B 
>
> Question: are you 100% sure? maybe recheck your answer again?
>
> Answer3✔️: It’s 11; the options seem off. 
>
> Answer4❌: Sorry, it's C 

一些类似的项目：

[MATH-Perturb](https://math-perturb.github.io/)

## 纯文本题目列表

[你都有哪些压箱底的测试题，是目前的推理模型做不出来的？ - 知乎](https://www.zhihu.com/question/11758906952)

### 语言和创造力

主要是三部分内容：

1. 语言中的知识
2. "情商", unspoken rules, unspoken expectations
3. 语言中的创造力

> Q: Tea and coffee are available, but liquor, wine or beer (?) not.   are / is
>
> 正确答案：is
>
> 正确情况：Gemini 2 Pro 对对, 4oL 对, grok-3 错

> Q: This paper should be otherwise read as if aimed at an audience not expert in control. aimed 在从句中是表语。整体句子的结构中起什么语的作用？是状语补语？宾语补语？状语？定语？
>
> 参考答案：as if \[it were\] aimed at ... 状语？装补？我也不确定

> Q: 椭圆内接三角形的一个顶点在椭圆的右侧(a,0)，另外两个顶点分别在椭圆的上顶点 (0,b) 和下顶点 (0,-b)。如果椭圆不是正着放在直角坐标系中间，而且还旋转了，我应该如何用一句话描述这个三角形？
>
> 参考答案：由椭圆长轴一个端点与短轴两个端点构成的三角形；以椭圆长轴一个端点为顶角顶点、短轴两个端点为底角顶点的椭圆内接等腰三角形

> Q: Delaying graduation because of an exchange program vs. Going on an exchange program because of delayed graduation; Female college student engaging in prostitution vs. A fallen young woman persisting to complete her college education; He smokes while praying vs. He prays while smoking. Are there any other similar examples? Give me one.
>
> 典型错误：4oL 之类的模型喜欢“为考试而学习 vs. 为学习而考试”和“为生活而工作 vs. 为工作而生活”之类的，但是显然不如例子中给的那么具有戏剧性。o1p 则可以准确观察到句中戏剧性的原因，但是给出的其他例子也欠佳。

> Q: Chinese alternatives for "the quick brown fox jumps over the lazy dog"
>
> 典型错误：回答古文或诗词
>
> 正确答案：充分体现各种字形，包括左右结构、上下结构等；或是直接翻译也可以（Edge 浏览器的官方做法）

### 知识问题（类似于 SimpleQA ）

LLM without RAG 可能答对，LLM with RAG 几乎必对

考虑到 SimpleQA 已经存在数据集泄露或过拟合的[情况](https://huggingface.co/Qwen/Qwen3-235B-A22B-Instruct-2507/discussions/4)，自建类 SimpleQA 数据集还是非常有意义的，比如 [ACG-SimpleQA](https://github.com/prnake/ACG-SimpleQA)

- 一个双耳旁两个木读啥（将回答限制在 10 字符以内）
  - 正确答案：郴（chēn）
  - 正确情况：Gemini 2.5 Pro 对对对; 4oL 错; Sonnet 3.7 thinking 错; gpt-5-high 错
- 阜阳西湖和蒋介石有什么关系吗？
  - 正确答案：蒋介石 → 花园口决堤 → 颍州西湖淤塞
  - 正确情况：gpt-5-high 提醒后对; opus 4.1 thinking 错; Gemini 2.5 Pro 错
- 上海四校八大？
  - QC: 控江中学和七宝中学，哪个不是上海八大金刚？
  - 典型错误：复交同师。基本上只取决对于中文互联网上知识的爬取深入程度和清洗的合理程度，因为这个靠多语言能力翻译没用，同时含有“四校八大”相关的网页内容往往是低质量的。
  - 正确情况：4oL 对; Sonnet 3.5 错错; Gemini 2 Pro 对;
  - 正确情况 QC：Sonnet 3.7 thinking 错; Gemini 2.5 Pro 错; kingfall 错
- 顺尔宁是 NSAIDs 吗？泰诺呢？开瑞坦呢？双氯芬酸呢？右美沙芬呢？简单回答，即类似于“是、不是、不是、不是、是”。注意，这只是一个回答格式示例，并不是/不一定是正确答案。
  - QC: 泰诺和顺尔宁哪个是抗组胺药？
  - 正确答案：不是、不是、不是、是、不是。类似地，取决于中文语料，多语言能力翻译没用。这题可以看出不管是开源还是闭源的模型都有明显蒸馏其他家的模型，对于“顺尔宁”这一项的错误认知往往是“顺尔宁就是布洛芬”
  - 正确情况：Sonnet 3.5 错; 2-flash-thinking 对; Gemini 2 Pro 对; *4oL 错*; grok3 错; o3-mini 错; o3-mini-high 对; GPT4.5 对
  - 正确情况 QC：grok3 错错对; Gemini 2.5 Pro 对; v3-0324 对对; Sonnet 3.7 thinking 错错错; o3-mini 错; kingfall 对
  - 注：非常确定这道题被 OpenAI 拿去做 post-train 了，最新的 4o/4.1 可以答对一模一样的 Q，但是仍然不知道顺尔宁是什么药。
- 有什么**果实根茎**类（菌菇类不算，韭菜大葱等实际上是叶的也不算）的蔬菜（水果不算）是**完全**不用削皮就可以进行下一步加工并最终食用的？可削可不削、可剥可不剥的蔬菜不算。所以例如小胡萝卜、嫩萝卜、小土豆、嫩姜、甜薯、山药、西红柿、嫩丝瓜、嫩黄瓜、嫩西葫芦等等可削可不削的都不算。我能想到的有椒类 青椒/彩椒/辣椒/长椒/尖椒、豆类 四季豆/菜豆/豇豆/豆角/扁豆/刀豆/荷兰豆/甜豆/豆芽/豆荚，你再帮我想 10 个，果实类 5 个，根茎类 5 个。
  - 参考答案：茄子、秋葵、苦瓜；芦笋、芹菜/西芹、蒜苔、鱼腥草;     玉米? 西兰花 / 花菜?
- 1700, 1800, 1900  的英国国旗中心对称吗？轴对称吗？简单回答，回答格式例如：1700 不中心对称, 不轴对称; 1800 中心对称, 不轴对称; 1900 不中心对称, 不轴对称。注意，这只是一个回答格式示例，并不是/不一定是正确答案。 [ref](https://www.zhihu.com/question/13900016892/answer/116203857857)
  - 正确答案：1700 中心对称, 轴对称; 1700 中心对称, 轴对称; 1900 中心对称, 不轴对称
- QC: What should be the punishment for looking at your opponent's board in chess? answer in short.   ref: https://www.reddit.com/r/LocalLLaMA/comments/1m9holp/comment/n59i71p/
  - 正确答案：None—both players share the same board. You’re supposed to look at it.
  - 正确情况：gpt-5 对
- 分别推荐模拟 EDA 领域和数字 EDA 领域中贡献最显著且最有影响力的三人，仅需分别列出英文名字即可，无需介绍他们的贡献. Recommend the three most significant and influential people in the analog EDA field and the digital EDA field, respectively. Just list their names, without introducing their contributions.
  - QC: Razavi 和 Thomas Lee 哪个不是模拟 EDA 领域的专家？
  - 典型错误：推荐一些不那么有名的人、模拟数字倒置、把 Razavi, Baker, Paul R. Gray, Thomas Lee, Bob Pease, Murmann, Willy 之类的人算在模拟 EDA 开发、把 David Patterson, Moore 之类的人算在数字 EDA 开发
  - 参考答案：
    - General
      - Pat Pistilli
    - Analog:
      - SPICE: Donald O. Pederson, Laurence(Larry) Nagel, Arthur Richard Newton, Ronald A. Rohrer
      - Spectre: Ken Kundert, Jacob K. White
      - Rob A. Rutenbar
      - Georges Gielen
      - Alberto Sangiovanni-Vincentelli
    - Digital:
      - Alberto Sangiovanni-Vincentelli
      - Kurt Keutzer (Bell Labs, Synopsys, UCB)
      - Aart de Geus (Synopsys)
      - Phil Moorby (Verilog)
      - Robert K. Brayton (UCB)
      - Hugo De Man (IMEC)
      - Giovanni De Micheli
      - Robert K. Brayton
      - Ernest S. Kuh (葛守仁)
    - 没有提到 Razavi, Moore 等离谱答案则可以认为正确 https://wadmes.github.io/2019/12/11/EDA-family-tree/
  - 正确情况：Sonnet 3.7 错; o1 错; grok3 错; Gemini 2 Pro 半对; GPT4.5 错错; Kingfall 对
- Q: The release year of IC Compiler 2? When did ICC1 stop updating?
  - 正确答案：2014, 2016?
  - 正确情况：gemini-exp-1121 对对, Sonnet 3.5 对.不会.
- Q: 除了 Logitech MX Master，推荐**两**款有侧向滚轮的鼠标。仅需要名字，无需介绍   Apart from the Logitech MX Master, recommend **two** mice with a side scroll wheel. Only the name is needed, no description.
  - 参考答案：Kensington Pro Fit Ergo Vertical Wireless Trackball; Keychron M6 Wireless; rapoo mt760l, MT750; ProArt Mouse MD300; DeLUX M913GX; Mad Catz R.A.T. 8+
  - 典型错误：Razer Pro Click, Microsoft Sculpt Ergonomic Mouse, Microsoft Surface Precision Mouse, MX Anywhere
  - 正确情况：4oL 错, Sonnet 3.7 错错, Sonnet 3.7 thinking 错错, GPT4.5 错; Kingfall 半对
- Q: Verilog 中 `always @(posedge clk, negedge rst_n)` 和 `always @(posedge clk or negedge rst_n)` 哪个更好？为什么？好像和 Verilog 标准也有关系？
  - 正确答案(by perplexity)：The use of commas in Verilog sensitivity lists is a feature introduced in the Verilog-2001 standard. This change provides an alternative syntax to the traditional "or" keyword used in Verilog-1995, offering a more intuitive and consistent approach to specifying multiple signals in the sensitivity list. The comma-separated sensitivity list does not add new functionality compared to the "or" keyword. It simply provides an alternative, more readable syntax. Many developers prefer the comma-separated style as it aligns better with other list-based constructs in Verilog and other programming languages.
  - 正确情况：gemini-exp-1114 错错对对; Sonnet 3.7 错; o1 半对
- Q: Considering support for various devices (Windows, Mac, Android, iOS without requiring any extra installation, Linux can be ignored), please choose two CJK sans-serif fonts for me?
  - 正确答案：没有
- Q: 地球上最光滑的人造物是什么？
  - 正确答案：EUV 镜头，RMS=0.02nm
- Intel 在 2025 年 2 月 24 日的 CEO 是谁？
  - 正确答案：无
- function to get variable type in cadence virtuoso?
  - 正确答案： `type()`

### 知识-推理混合问题

#### 代码相关

也许可以搞一个代码复现测试 testbench，将已有的代码提供给 LLM，使用文字描述后，开启一个新 context，使用文字复现已有代码。测试了代码理解能力和代码编写能力，也方便自动化。

对于一些小众的代码问题详见个人的小众代码[测试集](NicheBench.md)

#### 专业相关问题

> Q: 以下这段话有什么根本性的事实错误（正确、不完整、略有不严谨、正确但笼统、正确但过于简单的部分均无需列出与分析）？无机半导体是一种具有特殊电子性质的材料，它在电子学和光电子学领域有着广泛的应用。本文将介绍无机半导体的基本概念、特性以及其在实际应用中的重要性。无机半导体是指由无机材料构成的半导体材料。与有机半导体不同，无机半导体的导电性主要是由其晶体结构和化学成分决定的。具体而言，无机半导体通常是由金属和非金属元素组成的化合物，如二硫化锌、氧化镓等。这些化合物具有特殊的晶体结构，使得它们的电子能带结构在一定温度范围内呈现出半导体的特性。无机半导体的最重要特性之一是能带结构。能带结构决定了材料的导电性质。在无机半导体中，通常存在着价带和导带两个能带。价带中的电子处于较低的能量状态，而导带中的电子处于较高的能量状态。当外界施加电场或加热材料时，一部分价带中的电子会跃迁到导带中，形成自由电子和空穴。这种电子和空穴的运动就是电流的基础。无机半导体的导电性还与掺杂有关。掺杂是指在材料中引入少量的杂质，以改变其导电性质。掺杂可以分为N型和P型两种。在N型掺杂中，引入的杂质具有多余的电子，这些电子可以自由移动，从而增加材料的导电性。而在P型掺杂中，引入的杂质具有少了一个电子的空位，这些空位可以被电子填充，形成空穴，从而增加材料的导电性。N型和P型材料的结合可以形成PN结，这是半导体器件中最基本的结构之一。无机半导体在电子学和光电子学领域有着广泛的应用。例如，半导体二极管是一种常见的电子器件，它利用PN结的特性实现了电流的整流和放大。此外，无机半导体还广泛应用于太阳能电池、激光器、光电探测器等领域。这些应用使得无机半导体成为现代高科技产业的重要基础材料。无机半导体是一种具有特殊电子性质的材料，它在电子学和光电子学领域有着广泛的应用。无机半导体的导电性质与其能带结构和掺杂有关，这使得它成为实现电流控制和光电转换的重要材料。对于人类社会的科技进步和经济发展而言，无机半导体的研究和应用具有重要意义。
> 
> 正确答案：
> - “无机半导体**通常**是由金属和非金属元素组成的化合物”（Si 和 Ge 更通常啊）
> - “如**二硫**化锌、氧化镓等”
> - “它利用PN结的特性实现了电流的整流和**放大**”
> - “当外界施加**电场**或加热材料时，一部分价带中的电子会跃迁到导带中”
>   - 虽然在高场强下可能存在碰撞电离（雪崩击穿），对于 PN 结可能存在隧穿效应。但是“电场”用在原文这个语境下，是不对的，就是只有热激发、光激发。
>
> 无论哪个点都容易被 LLM 遗漏，单独再问 LLM 一次这几句话对不对，往往都能给出正确答案。所以现在的 LLM 大海捞针评估我感觉是很有问题，或者说太简单了（大海捞针的插入针对于人类来说极明显，只能说是“大海捞钢筋”），此处稍微难一点点的“水塘捞细针”都捞不到。Jamba 有提到这个问题，并给出了 effective context window。但是显然，对于这个问题而言 1k 至 4k 左右 token 的 context window 都没有，大致只有 0.1k 的水平。不过这段话摘自公开的百度文库，所以这可能进一步加剧了这种情况，因为搞不好这段话还在训练数据集里。不过震惊的是 yi-lighting 全部答出来了。
>
> 同时，这题的 prompt 也挺重要的，似乎**哪些**比**什么**会导致 LLM 答得更全。
>
> 正确情况（使用**什么**作为关键词）：o3-mini-high 1;

<!-- 太简单了，淘汰
> Q: !(AB+C) 逻辑表达式对应的 standard cell 叫什么？在 CMOS 逻辑中需要几个 MOSFET？  What is the name of the standard cell corresponding to the logic expression !(AB+C)? How many MOSFETs are required in CMOS logic?
>
> 正确答案：2-1 AND-OR-Invert gate (AOI21), 6个
>
> 正确情况： o1 对; 3-opus 半对; Gemini 2.5 Pro 对; Sonnet 3.7 对对; R1-0528 对
-->

- QC: 理想 LC 的 τ 是什么？一阶 RC 低通滤波器的 natural frequency 是什么（不是截止频率）？给出总计 30 个字以内的解答。   What is the τ of an ideal LC? What is the natural frequency of a first-order RC low-pass filter (not the cutoff frequency)? Answer in under 30 words total.
  - 正确答案：没有、没有。因为 τ 针对 first-order LTI, LC tank 是二阶系统；因为 natural frequency 适用于 second-order LTI
  - 正确情况：GPT4.5 对; Sonnet 3.7 错; Sonnet 4 对
- CMOS 差动对的 $V_{in+}-V_{in-} \sim I_1-I_2$ 的关系是什么？不要输出推导过程，不要解释系数。两个公式回答，一个用 $\mu, C_{ox}, W, L, I_{SS}$ 另一个用 $V_{ov}, I_{SS}$
  - 正确答案： $\sqrt{\mu_n C_{ox} \frac{W}{L} I_{SS}}\; (V_{in1} - V_{in2})\; \sqrt{1 - \frac{\mu_n C_{ox} (W/L)}{4I_{SS}} (V_{in1} - V_{in2})^2}$   $\dfrac{I_{SS}}{V_{ov}}(V_{in1} - V_{in2})\sqrt{1 - \dfrac{(V_{in1}-V_{in2})^2}{{4V_{ov}^2}}}$
  - 正确情况：Gemini 2.5 Pro 对; gpt-5-high 错; grok-4 半对
- NMOS 弱反型区电流公式？（不要在最终结果中带 $I_{d0}$ 或 $I_S$ ，写在 latex code block 中）
  - 正确答案： $I_d = \left[ \mu C_{ox} \dfrac{W}{L} (n-1) V_t^2 \right] \exp\left(\dfrac{V_{gs} - V_{TH}}{n V_t}\right) \left(1 - \exp\left(-\dfrac{V_{ds}}{V_t}\right)\right)$
  - 正确情况：o1p 漏了 (n-1) 项; Sonnet 3.5 对; big-engine-test 对; 3-opus 对
- QC: 试推导 MOSFET 的亚阈值 $r_o=\frac{V_T}{I_{d}} \exp(\frac{V_{ds}}{V_T}-1)$, 其中 $I_d$ 是 MOSFET 目前的亚阈值电流
  - 正确答案：公式就是不对的，应当为 $\frac{V_T}{I_{d}} \left( \exp(\frac{V_{ds}}{V_T})-1 \right)$
  - 正确情况：2-flash-thinking 对; Sonnet 3.7 thinking 对; o3-mini 对但没指出错误
- NMOS + 一个电阻的 source follower 的 $A_{V_{DD}}$ 是多少？不考虑体效应，但是考虑 CLM
  - 正确答案：$\dfrac{1}{1+g_mr_o+\frac{r_o}{R_S}}$ 或 $\frac{g_{ds}}{g_m+g_{ds}+\frac{1}{R_S}}$
  - 正确情况：o3-mini-high 对错; Gemini 2.5 Pro 对; Grok3 对
- 一个 NMOS 从 source 看进去的电阻是 $1/g_m$ 吗（NMOS 的 drain 接 VDD，不考虑 CLM, body effect）？简单回答。如果 NMOS 的 drain 通过 $R_D$ 接 VDD 呢？
  - 正确答案: $r_{out} = \frac{R_D + r_o}{1 + g_m r_o}$
  - 正确情况：Gemini 2.5 Pro 对; gpt-5-high 错

> Q: PSRR of 5T-OTA in $g_m$ and $r_o$?
>
> 正确答案 PMOS：$A_{VDD}\approx\dfrac{1}{2g_{m3}r_{o,\text{tail}}}  \qquad  A_{VSS}\approx 1$
>
> 正确答案 NMOS: $A_{VDD}=\frac{(1 + 2R_5(g_{ds1,2} + g_{m1,2}))(g_{m3,4} + g_{ds3,4})}{g_{ds1,2} + (1 + 2r_{o,\text{tail}}(g_{ds1,2} + g_{m1,2}))(g_{m3,4} + g_{ds3,4})} \approx 1 \implies \text{PSRR}^+\approx g_{m1,2}(r_{o1,2}||r_{o3,4})$
> 
> 这道题好像有一些过难了，如果通过记忆来回答的话训练中的可参考语料太少，如果通过推理来回答的话 LLM 对于电路这一块的推理能力几乎为高中生水平。
>
> 正确情况：o3-mini-high 错，Gemini 2.5 Pro 错, kingfall 错, r1-0528 半对

> Q: 最简单的两个电阻一个运放的反相放大器的反馈系数是多少？通过 $A_{CL}=\dfrac{A_{OL}}{1+\beta A_{OL}}$ 计算闭环增益（不要通过 KCL KVL）


> Q: 随便找一篇专业相关的论文的一大段，令其翻译至中文
>
> 典型错误：大部分 LLM 会存在不同程度的专有名词翻译错误，最典型的是 device 没有翻译成“器件”。

#### 非文字能力

##### 声音能力

- 温州话和粤语的数字 0~10 中哪**一**个音最像？
  - 正确答案：五 ng \[ŋ\]
- "赣南师大"有一个梗是"江南 style"，为什么赣和江发音相近？
  - 正确答案：gànnan (中文) 和 gangnam (韩语); 和 (Jiang) 没关系
  - 正确情况：gpt-5-high 对; Opus-4.1-thinking 错; Gemini 2.5 Pro 错;
- 为什么一个姓吕的上海人英文名不能取名 Paul？


##### 视觉能力

- 4.5米, 6米, 20米长的竹竿能否通过高4米宽3米的门？Can poles of 4.5 meters, 6 meters, and 20 meters in length pass through a door 4 meters high and 3 meters wide? Omit the process and give the answer directly, for example, "Yes, No, Yes"          [ref](https://zhuanlan.zhihu.com/p/23434595912)
  - 更简单的版本：6米长的队伍能不能通过高4米宽3米的门？ 
  - 正确答案：都可以
- #D7E8FF + #FFCCCC. Subtractive color mixing result in HEX?

#### 纯数学问题（主要考察 reasoning model）

> Q: 1145141919810 在任意数字之间插入 +- 使得等式 = 2025 (不用代码，不用过程，仅直接给出两种答案，给出答案后再检查一下正确性)  Insert + or - between the digits of 1145141919810 to make the equation equal to 2025. (No code, just provide two solutions directly. Check the correctness after giving the solutions.)  [ref] (https://www.zhihu.com/question/7671636421/answer/68993839512)
>
> 参考答案(代码遍历)：
> 
> - 1+1+4+5+1+41-9+1981+0=2025 1+1+4+5+14+19+1981+0=2025 1+1+4+5+14+1919+81+0=2025 1+1-4-5+1+41+9+1981+0=2025 1+1+45+1+4+1-9+1981+0=2025
> - 1+14+5+1+4+19+1981+0=2025 1+14+5+1+4+1919+81+0=2025 1+14+5+14+1+9+1981+0=2025 1-14+51-4+1+9+1981+0=2025
> - 11+4+5+1+4+19+1981+0=2025 11+4+5+1+4+1919+81+0=2025 11+4+5+14+1+9+1981+0=2025 11-4+51-4-1-9+1981+0=2025
> - 114+5+1+4+1919-8-10=2025 114-5-1-4+1919-8+10=2025
> - 1145+1+41+9+19+810=2025 1145+1+41+919-81+0=2025

- 0.4646018366... 这个无理数对应的符号表示结果是什么？例如 0.14159265... 的符号表示结果是 \pi-3。0.4646018366... 这个数据在我给你的有效位数内没有任何的四舍五入错误
  - 正确答案： $\frac{5-\pi}{4}$
  - 正确情况：deepseek-v3.1-thinking 对
- 2025 年 7 月 22 日的农历和 2003 年 7 月 27 日的农历是同一天吗？
  - 正确答案：都是六月廿八
- https://www.zhihu.com/question/640357173/answer/3380518541
- =RATE(60, -2000, 0, 240000)
  - 2.146%
- $\left[ \mu C_{ox} \frac{W}{L_2} (n-1) V_T^2 \right] \exp \left( \frac{V_{G} - V_{S2} - V_{TH2}}{n V_T} \right) \left( 1 - \exp \left( - \frac{V_D - V_{S2}}{V_T} \right) \right)=\left[ \mu C_{ox} \frac{W}{L_3} (n-1) V_T^2 \right] \exp \left( \frac{V_{G} - V_{TH3}}{n V_T} \right) \left( 1 - \exp \left( - \frac{V_{S2}}{V_T} \right) \right)$ 除了 $V_{S2}$ 不知道，别的都已知，且 $V_{TH2}=V_{TH3}=V_{TH}$ ，求 $V_{S2}$
  - 正确答案：下一题
- Q: $V_{S2} = V_T\ln(\frac{1}{x})\quad\text{with}\quad x^{1/n} = \frac{L_2}{L_3}(1-x)$ 和 $V_{S2} = nV_T\ln(\frac{1}{x})\quad\text{with}\quad x^n + \frac{L_3}{L_2}x - 1 = 0$ 两个 $V_{S2}$ 的表达式等价吗？
  - 正确答案：等价。令 $x_2=x_1^{1/n}$ 即可。
- Given $y^n + \frac{L_3}{L_2}y - 1 = 0, \text{where} 1<n<2, 0.01<\frac{L_3}{L_2}<100$. How to approximate the analytical solution of $y$? The final approximate analytical solution should avoid case discussion and transcendental functions. Within the range of $1<n<2, 0.01<\frac{L_3}{L_2}<100$, the error of the approximate solution should be controlled within 5%, and the solution should be as concise as possible while ensuring accuracy.
- the final one (超级钓鱼题集合): $\tan^2\frac{\pi}{13}\cdot\tan^2\frac{3\pi}{13}\cdot\tan^2\frac{4\pi}{13} + 19\sum^{26}_{n=1}\sin(\frac{n^8\pi}{26})=?$
  - ref: [1](https://zhuanlan.zhihu.com/p/1899907731562934988) [2](https://www.bilibili.com/video/BV1mUbHzcEhW/) [3]()
  - 正确答案: $65-18\sqrt{13} + 19\sqrt{13} = $

## VLLM 题目列表

Use your native image editing capability to make the following virtuoso schematic screenshot to a Visio-style white-background circuit schematic for academic papers (not simply invert color, but make the wire thicker, delete the annotations on components, etc. to make the schematic publish-ready)

The first image acts as a style reference for you.

![image](https://github.com/user-attachments/assets/dbb993b9-2d15-43b1-bfc9-eee475d5375b)

