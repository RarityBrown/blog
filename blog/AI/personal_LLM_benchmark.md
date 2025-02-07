# My Personal LLM Benchmark and Thoughts on LLMs

考虑到各种 Benchmark 泄露严重，现在基本上只参考 Arena Hard Prompts (Overall) with Style Control 作为 Benchmark。

同时，在平时（主要是专业相关的）使用过程中，收集选择一些截至 2025 年 2 月的第一梯队 LLM (o1, o3-mini, r1, Sonnet 3.5, Gemini 2 Pro, 2-flash-thinking) 中部分 LLM 可以答对，部分 LLM 不能答对的适中难度题目，整理于本文。难度过大的，例如~~解个明年的高考数学压轴题~~(我估计 2025 年 6 月的时候可能真可以满分)、明年的物理系考研压轴题(我估计 2025 年 12 月的时候可能真可以满分)、写个更好的红楼梦后 40 回、写个 Windows 出来、~~证个哥德巴赫猜想~~等；以及难度过小的，例如 MMLU 都拉不开区分度。

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

## 题目列表

### 语言和创造性

越往上，越偏向于语言；越往下，越偏向于语言中的创造力

> Q: 两个木一个双耳旁读啥
>
> 正确答案：郴（chēn）
>
> 正确情况：Gemini 2 Pro 对

> Q: "赣南师大"有一个梗是"江南 style"，为什么赣和江发音相近？
>
> 正确答案：gànnan 和 gangnam
>
> 正确情况：o3-mini 错

> Q: 椭圆内接三角形的一个顶点在椭圆的右侧(a,0)，另外两个顶点分别在椭圆的上顶点 (0,b) 和下顶点 (0,-b)。如果椭圆不是正着放在直角坐标系中间，而且还旋转了，我应该如何用一句话描述这个三角形？
>
> 参考答案：一个以椭圆长轴一个端点和短轴两个端点为顶点的椭圆内接等腰三角形

> Q: Delaying graduation because of an exchange program vs. Going on an exchange program because of delayed graduation; Female college student engaging in prostitution vs. A fallen young woman persisting to complete her college education; He smokes while praying vs. He prays while smoking. Are there any other similar examples?
>
> 典型错误：4oL 之类的模型喜欢“为考试而学习 vs. 为学习而考试”和“为生活而工作 vs. 为工作而生活”之类的，但是显然不如例子中给的那么具有戏剧性。o1p 则可以准确观察到句中戏剧性的原因，但是给出的其他例子也欠佳。

> Q: Chinese alternatives for "the quick brown fox jumps over the lazy dog"
>
> 典型错误：回答古文或诗词
>
> 正确答案：充分体现各种字形，包括左右结构、上下结构等；或是直接翻译也可以（Edge 浏览器的官方做法）

> Q: 出一道 LLM 非常容易答错、但人类很容易答对、有客观正确答案的题。所以这道题你应该拼尽全力也无法答对才满足我的要求，即如果你试作答这道题，发现可以答对，则不符合我的要求。但是不能出什么“现在房间里有什么气味”之类的利用缺乏实时的个人信息的问题。应该是类似于 12+21 等于几、2022 年谁是美国总统之类的客观问题。

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

> Q: How to print quotes within a node in a Mermaid flowchart? Answer within 2 lines in a code block.
>
> 典型错误：`A["Node with \"quotes\""]`
>
> 正确答案：`A["Node with #quot;quotes#quot;"]` ref: [link](https://mermaid.js.org/syntax/flowchart.html#entity-codes-to-escape-characters)
>
> 正确情况：gemini-exp-1114 对错错; o1p 错错错; 4oL 错错错错; secret-chatbot 对对对错错; Sonnet 3.5 错错错错; Gemini 2 Pro 错错


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

### 知识-推理混合问题

#### 代码相关

##### LaTeX 相关

###### LaTeX

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
> \rlap{\hskip 2.5em \rule[-3em]{1em}{6em}}  \rule[-0.5em]{6em}{1em}
> ```
> 

> Q: How to make $\boldsymbol{\tau_{Y}}$ even bolder without any other formatting change and without `\usepackage{bm}`? Answer within 2 lines in a code block.
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

> Q: !(AB+C) 逻辑表达式对应的 standard cell 叫什么？在 CMOS 逻辑中需要几个 MOSFET？
>
> 正确答案：2-1 AND-OR-Invert gate (AOI21), 6个
>
> 正确情况： o1 对, 3-opus 半对, 2-flash-thinking 对对对对, Gemini 2 Pro 半对

> Q: 理想 LC tank 有 τ 吗？从以下几方面思考 1. τ 的定义是什么？2. LC tank 是几阶系统？给出总计 30 个字以内的解答。
>
> 正确答案：没有。因为 τ 针对 first-order LTI, LC tank 是二阶系统

> Q: NMOS 弱反型区电流公式？（不要在最终结果中带 Id0，写在 latex code block 中）
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
