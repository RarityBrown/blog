# My Personal LLM Benchmark and Thoughts on LLMs

考虑到各种 Benchmark 泄露严重，现在基本上只参考 Arena Hard Prompts (Overall) with Style Control 作为 Benchmark。

同时，在平时使用过程中，收集选择一些截至 2025 年 6 月的第一梯队 LLM (GPT4.5; Gemini 2.5 Pro, Opus 4 thinking, o3, o4-mini-high, R1-0528) 中部分 LLM 可以答对，部分 LLM 不能答对的适中难度题目，整理于本文。难度过大的，例如~~解个明年的高考数学压轴题~~(我估计 2025 年 6 月的时候可能真可以满分)、明年的物理系考研压轴题(我估计 2025 年 12 月的时候可能真可以满分)、写个更好的红楼梦后 40 回、写个 Windows 出来、~~证个哥德巴赫猜想~~等；以及难度过小的，例如 ~~MMLU~~GPQA 都拉不开区分度。

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

2025/02/25: 去年，Jensen 和 Zuckerberg 有一次公开对话，其中两人对 LLM 的未来是专用还是通用有着不同看法：Jensen 认为通用 LLM 是未来，人们无不希望在各方面都更强大的 AI；Zuckerberg 则认为专用是未来。今日，Sonnet 3.7 发布，过去以来一直认同 Jensen 观点的我产生了动摇。随着 scaling law 的瓶颈愈发显现，应该用 200B 的参数训练一个啥都过得去，但是不专精的通用 LLM；或是用 200B 的参数训练一个更专精于代码的模型，以此在该领域产生真正的“价值”？这个问题在过去可以随意 scaling 的时代是不存在的，而且这不仅是一个技术问题，更是一个商业问题。To be, or not to be, that is the question. 也许 UCB 的 experiment-router，后端配上具有一定通用能力的多个领域专用 LLM 才是未来？人类社会也是如此啊。但是除了数学、理论物理、计算机等少部分信息公开程度高、定量化评价体系清晰 (RL 方便) 的领域可以方便地使用传统方法训练 200B 左右的专用 LLM，其他领域的专用 LLM 还是面临着两个问题，一是 AI 领域老生常谈的问题——少样本训练，二是性价比——小企业的工厂里为什么自动化程度不高？因为对于小批量细分领域，人比机器便宜，主要原因是 robustness 和 versatility。

2025/02/28: 除了 A 家的大基模以外，GPT4.5, grok3, Gemini 2 Pro 都已上菜完毕。More Scaling 已经基本结束; More than Scaling 方兴未艾; Beyond Transformer 遥不可及。

![image](https://github.com/user-attachments/assets/522a1600-971b-4934-94b3-af8fa37a4ac6)

2025/03/06：LLM 需要一个推理 FoM 值，类似于 $\log(1/\text{average end time}\cdot\text{average first token time}\cdot\text{average token})\cdot \text{Raw Performance}$ 之类的。QwQ 32B 的推理过程动辄消耗 2 万个 token，不比 preview 版好多少，仍然是刷榜的废物。Groq 之类的硬件加速方案还是有一定前途的，就等 Jensen 下场了。

2025/03/24: 加入 HardQA (SimpleQA 的困难版本，需要阅读大量网页和一点点的推理能力才能答对，利用 LLM 自身知识储备几乎不可能答对)。2025/04/11: OpenAI 的 BrowseComp 基本上就是也。更印证了没有一家在解决模型说“不会”的能力，而都是在通过加强模型能力来减轻幻觉的影响。

2025/03/30: Deepseek v3-20250324 和 OpenAI 4oL-20250326 从 benchmark 结果来看应该是用了非常类似的方法。很难想象 Perplexity 和 Cursor 这种产品的估值会如此之高，应用层没有护城河，时间会碾碎一切的。今天闲，再写一点预测吧：Llama 4 通用任务的文字能力(不考虑多模态)非推理水平应该在 Claude 3.7 左右，恐怕是不如 v3-20250324 / Gemini 2 Pro / 4oL-20250326 的。GPT5 和 Claude4 才是真正的 Game Changer，就等下半年体验了，这个预测不准的。

2025/04/06：Qwen3 的 llama4 压力小多了，但是内在压力还是挺大的。如果五六月份发布的 Qwen3 72B 目标是和 ds-v3.0 乃至 Qwen2.5 Max 打平，还是难的，估计今年年末或者明年年初的 Qwen3.5 72B 有戏，如果那时候还发 Dense 的话。但是我认为这个尺寸就是应该发 dense 的，至少 llama4 Scout 的失败会让业界长记性的。

2025/05/01: benchmark 确实是 AI 未来两年内最大的问题。通过 reasoning 刷 AIME, 刷 HLE(评测集里面数学题 40%, 物化生各 10%), 刷 GPQA Diamond (考虑到是四项选择题，现在的正确率看来好像也没那么好刷) 本质上都是为了解决真实世界问题而做准备的考试。这些学科的答案清晰，但是对于 Engineering 和 Social Science 问题则更为复杂。上半年唯一比较满意的 benchmark 是 openai 的 BrowseComp。当然，现在这个问题还没有体现出来，因为 AI 的全方面能力提升似乎还有余量，所以各团队尚未对这些学科针对性的优化。但是到今年年底的时候，reasoning 的红利类似于 FinFET 一样被彻底吃干净的时候，如果仅由 GPQA, AIME 和 HLE 来引导 LLM 下一步的发展方向，只会发展出类似于 AlphaGo 的专用人工智能，而不是通用的。虽然我高度怀疑 Google 内部现在应该是有团队在向哥德巴赫或者黎曼之类的东西发起冲锋的，就像曾经的围棋一样，当这一步成功的时候，数学可能就会比围棋率先走到尽头了。如果 Google 能在 2030 年之前做到，那么世界上将再无 OpenAI。

2025/06/01: 一个月过去了。Claude 4 Opus 来了，而 o4 还很遥远；Gemini Diffusion 和 gpt-image-1 来了，而全模态输入输出还很遥远。如果 Gemini 3 无法引领 Benchmark 分数进一步进步，下半年恐怕只有应用层面创新的 GPT5 了。Autoregressive 确实是快到头了，Sudoku-Bench 和 ascii-art 等等一系列顶着 Autoregressive 打的 benchmark 越来越多才是好事；当然，这个我也早有体会，比如让 AI 解一个 5-OTA + CS 的二级运放的 PSRR 之类的问题也是因为这个完全不行 。AGI 或是全方面超越人类的 ASI 不可能通过纯文字实现的，所以即使证明出哥猜也不是 AGI/ASI，不然 AlphaGo 就是一种 ASI 了。顺便再来接着 0501 的碎碎念，喷一下 Benchmark 过于注重理科而轻视工科的问题，是是非非曲曲折折，unspoken rules 让 AI 摇摆不定。

2025/07/05: 直至今日，所有 Agents 都还不堪大用。输入能力：context 能力、现场学习能力、视觉能力；输出能力：鼠标操作。

### QC 系列

- 加入 QC (Question with Critical Thinking, 题目就是错的
  - 例如 "证明 $\frac{1}{2}=\frac{2}{2+2-1}$", "Asheville, Akita, Kanazawa 哪个城市没有开过奥运会？"
  - 可以考虑传统选择题形式的类 GPQA 评测 + 填空题形式的类 GPQA 评测 + 没有一个选项正确的选择题形式的类 GPQA 评测。

一些类似的项目：

[MATH-Perturb](https://math-perturb.github.io/)

## 纯文本题目列表

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
> 正确情况：Gemini 2.5 Pro 对对对; 4oL 错; Sonnet 3.7 thinking 错

> Q: Tea and coffee are available, but liquor, wine or beer (?) not.   are / is
>
> 正确答案：is
>
> 正确情况：Gemini 2 Pro 对对, 4oL 对, grok-3 错

> Q: This paper should be otherwise read as if aimed at an audience not expert in control. aimed 在从句中是表语。整体句子的结构中起什么语的作用？是状语补语？宾语补语？状语？定语？
>
> 参考答案：as if \[it were\] aimed at ... 状语？装补？我也不确定

> Q: "赣南师大"有一个梗是"江南 style"，为什么赣和江发音相近？
>
> 正确答案：gànnan (中文) 和 gangnam (韩语); 和 (Jiang) 没关系
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
> 参考答案：
> 
> 1. 脑筋急转弯、谜语、双关；
> 2. 纯语言难以理解的、必须用到多模态的问题
>     - 视觉：文本视觉模式识别 (Look-and-say sequence), 竹竿问题, 用 tikz, svg, python 等画图
>     - 听觉: 发音, 谐音梗, 双语笑话
> 
> 正确情况：Gemini 2 Pro 基本上是 SOTA

### 知识问题（类似于 SimpleQA ）

LLM without RAG 可能答对，LLM with RAG 几乎必对

> Q: 上海四校八大？
>
> QC: 控江中学和七宝中学，哪个不是上海八大金刚？
> 
> 典型错误：复交同师。基本上只取决对于中文互联网上知识的爬取深入程度和清洗的合理程度，因为这个靠多语言能力翻译没用，同时含有“四校八大”相关的网页内容往往是低质量的。
> 
> 正确情况：4oL 对; Sonnet 3.5 错错; Gemini 2 Pro 对;
>
> QC 正确情况：Sonnet 3.7 thinking 错; Gemini 2.5 Pro 错; kingfall 错

> Q: 顺尔宁是 NSAIDs 吗？泰诺呢？开瑞坦呢？双氯芬酸呢？右美沙芬呢？简单回答，即类似于“是、不是、不是、不是、是”。注意，这只是一个回答格式示例，并不是/不一定是正确答案。
>
> QC: 泰诺和顺尔宁哪个是抗组胺药？
>
> 正确答案：不是、不是、不是、是、不是。类似地，取决于中文语料，多语言能力翻译没用。这题可以看出不管是开源还是闭源的模型都有明显蒸馏其他家的模型，对于“顺尔宁”这一项的错误认知往往是“顺尔宁就是布洛芬”
>
> Q 正确情况：Sonnet 3.5 错; 2-flash-thinking 对; Gemini 2 Pro 对; *4oL 错*; grok3 错; o3-mini 错; o3-mini-high 对; GPT4.5 对
>
> QC 正确情况：grok3 错错对; Gemini 2.5 Pro 对; v3-0324 对对; Sonnet 3.7 thinking 错错错; o3-mini 错; kingfall 对
>
> 注：非常确定这道题被 OpenAI 拿去做 post-train 了，最新的 4o/4.1 可以答对一模一样的 Q，但是仍然不知道顺尔宁是什么药。

> Q: 1700, 1800, 1900  的英国国旗中心对称吗？轴对称吗？简单回答，回答格式例如：1700 不中心对称, 不轴对称; 1800 中心对称, 不轴对称; 1900 不中心对称, 不轴对称。注意，这只是一个回答格式示例，并不是/不一定是正确答案。 [ref](https://www.zhihu.com/question/13900016892/answer/116203857857)
>
> 正确答案：1700 中心对称, 轴对称; 1700 中心对称, 轴对称; 1900 中心对称, 不轴对称

> Q: 分别推荐模拟 EDA 领域和数字 EDA 领域中贡献最显著且最有影响力的三人，仅需分别列出英文名字即可，无需介绍他们的贡献. Recommend the three most significant and influential people in the analog EDA field and the digital EDA field, respectively. Just list their names, without introducing their contributions.
>
> QC: Razavi 和 Thomas Lee 哪个不是模拟 EDA 领域的专家？
>
> 典型错误：推荐一些不那么有名的人、模拟数字倒置、把 Razavi, Baker, Paul R. Gray, Thomas Lee, Bob Pease, Murmann, Willy 之类的人算在模拟 EDA 开发、把 David Patterson, Moore 之类的人算在数字 EDA 开发
>
> 参考答案：
> 
> - Analog:
>   - **Donald O. Pederson (SPICE)**
>   - Laurence(Larry) Nagel (SPICE)
>   - Arthur Richard Newton (SPICE)
>   - Ronald A. Rohrer (SPICE)
>   - Ken Kundert (Spectre)
>   - Jacob K. White (Spectre)
>   - Rob A. Rutenbar
>   - Georges Gielen
>   - Alberto Sangiovanni-Vincentelli
> - Digital:
>   - Alberto Sangiovanni-Vincentelli
>   - Kurt Keutzer (Bell Labs, Synopsys, UCB)
>   - Aart de Geus (Synopsys)
>   - Phil Moorby (Verilog)
>   - Robert K. Brayton (UCB)
>   - Hugo De Man (IMEC)
>   - Giovanni De Micheli
>   - Robert K. Brayton
>   - Ernest S. Kuh (葛守仁)
> 
> 其中加粗项为必答项，其他项有提到一两个且没有提到 Razavi, Moore 等离谱答案则可以认为正确
>
> Q 正确情况：Sonnet 3.7 错; o1 错; grok3 错; Gemini 2 Pro 半对; GPT4.5 错错; Kingfall 对

> Q: The release year of IC Compiler 2? When did ICC1 stop updating?
> 
> 正确答案：2014, 2016?
>
> 正确情况：gemini-exp-1121 对对, Sonnet 3.5 对.不会.

> Q: 除了 Logitech MX Master，推荐**两**款有侧向滚轮的鼠标。仅需要名字，无需介绍
> 
> Q: Apart from the Logitech MX Master, recommend **two** mice with a side scroll wheel. Only the name is needed, no description.
>
> 参考答案：Kensington Pro Fit Ergo Vertical Wireless Trackball; Keychron M6 Wireless; rapoo mt760l; DeLUX M913GX; Mad Catz R.A.T. 8+
> 
> 典型错误：Razer Pro Click, Microsoft Sculpt Ergonomic Mouse, Microsoft Surface Precision Mouse, MX Anywhere
>
> 正确情况：4oL 错, Sonnet 3.7 错错, Sonnet 3.7 thinking 错错, GPT4.5 错; Kingfall 半对

> Q: Verilog 中 `always @(posedge clk, negedge rst_n)` 和 `always @(posedge clk or negedge rst_n)` 哪个更好？为什么？好像和 Verilog 标准也有关系？
> 
> 正确答案(by perplexity)：The use of commas in Verilog sensitivity lists is a feature introduced in the Verilog-2001 standard. This change provides an alternative syntax to the traditional "or" keyword used in Verilog-1995, offering a more intuitive and consistent approach to specifying multiple signals in the sensitivity list. The comma-separated sensitivity list does not add new functionality compared to the "or" keyword. It simply provides an alternative, more readable syntax. Many developers prefer the comma-separated style as it aligns better with other list-based constructs in Verilog and other programming languages.
>
> 正确情况：gemini-exp-1114 错错对对; Sonnet 3.7 错; o1 半对

> Q: Considering support for various devices (Windows, Mac, Android, iOS without requiring any extra installation, Linux can be ignored), please choose two CJK sans-serif fonts for me?
>
> 正确答案：没有

> Q: 地球上最光滑的人造物是什么？
>
> 正确答案：EUV 镜头，RMS=0.02nm

> Q: Intel 在 2025 年 2 月 24 日的 CEO 是谁？
>
> 正确答案：无

> Q: 中国国内目前排名前20的医院里，前身是教会医院的有哪些？超级简单回答。例如 “是：仁济、浙一、华西、华山...；不是：北大三院、积水潭、中山、瑞金...”。注意，这只是一个回答格式示例，并不是/不一定是正确答案。
>
> 正确答案：是教会医院：北京协和、中国医大一院、仁济、瑞金、浙二、武汉协和、湘雅、华西；不是教会医院：301、北大一院、北大三院、中山、华山、浙一、郑大一附院、武汉同济、湘雅二院、中山一院、南方医院、西京。参考[2023复旦版排名](https://rank.cn-healthcare.com/fudan/national-general) (2024年11月发布)
>
> 正确情况：Gemini 2.5 Pro w Google 对

> Can gemini-cli read audio, pdf and docx files (not talking about gemini api, but gemini-cli)? answer within 50 words.
>
> 正确答案：yes, yes, no

### 困难知识问题 (也许我们可以取名叫 HardQA? )

LLM w/o RAG 几乎不可能答对；为评估 Deep Search 而生，但不是 Deep Research，详见 Jina AI 的 Blog。Search 有非常多的 corner cases，一点都不优雅，频率依次倒序，包括但不限于

- **无关、干扰、矛盾信息**
  - 页面内广告等无关信息、整个页面和搜索问题无关或低密度信息、不同页面间信息矛盾
- **非纯文本内容**
  - 图片：搜索模型的确需要强视觉能力的
    - 例如在 20250406 搜索 "llama 4 maverick vs deepseek v3 0324. Give me a benchmark table, including GPQA etc." Sonar, gpt-4o-search, Gemini 2.5 Pro Grounding, Jina Deep Search 提供的对比表格没有一个是 100% 正确的，而且每次搜索结果非常不稳定，相对来说后两者略好一些。因为 llama 官方的对比表格就是图片，而那时候媒体转载也是直接通过图片，还没有任何成文的纯文本内容。
    - 又例如“中国博士历年延毕率”
  - 网页表格、图表
  - 视频：例如有的视频教程，比如教你怎么在 Word 中实现一个功能
    - 这一点 Google 做得不错了，YouTube 视频字幕可以低幻觉作为参考资料，但是视频画面仍然是一个问题
- **非标准网页类型**
  - 动态加载的网页
    - 不同 tab 但网址相同的网页（例如 `lmarena.ai: The (2nd) best LLM on lmarena today?`）
    - 点击/滚动才展开的评论区
    - 折叠或需要翻页的内容（例如 `https://github.com/electron/electron/issues/9035`）
    - 知乎文章的登录框
  - 在线超长 .pdf 文件，通过 pdf.js 加载的在线 pdf 文件
  - 隐藏的网页、登录墙、付费墙：只可能本地解决，靠一个个去谈不可能覆盖完全
    - 用户可以通过推理实现隐藏网页的查看，例如找到一个 `https://example.com/article13` 用户可能会直接输入 url 去看看 `https://example.com/` 和 `https://example.com/article14` 网页上有不有相关的内容
    - 例如查询 `the speaker of the ISSCC 2014 tutorial 3?`；现在 OpenAI 之类的只是和新闻媒体在谈，这种学术等等完全不可能一个个谈下来的，比如需要 license 才能查看的文档等等。所以最好的方式还是用户侧，而不是服务商的容器中
  - 非常老的网页，现代浏览器的 TLS 版本默认不支持
    - 例如 `https://ccf.ee.ntu.edu.tw/~cchen/cadence/simulation.htm`
- **用户侧**
  - 用户输入笔误
  - 用户输入的无效信息（这个在经典的 Benchmark 也可以体现一些，有题目里是有无效信息的）
  - 用户需求理解，例如 "Alternatives to Manus AI" 其实用户想搜 General Purpose AI Agents，例如 convergence AI, runner H，但是现在搜出来都是 MS Copilot 之类的
- **搜索方式**
  - 一般大家认为 Google, 英文的搜索方式，往往会优于 Bing, 中文的搜索方式。但是当搜索结果不理想时，是否能够主动切换搜索方式？例如下文的几个例子：
    - 非英语的搜索结果反而好于英语搜索结果
      - 例如 `pdk 中的 mac 管是什么？` 全网只有三个中文网页 [1](https://blog.csdn.net/weixin_42310516/article/details/133688562), [2](https://bbs.eetop.cn/thread-890470-1-1.html), [3](https://bbs.eetop.cn/thread-861115-2-1.html) (其中还有一个是许多程序员认为的低质量网页 csdn) 提到了答案，而英文搜索反而找不到信息
    - Google 的搜索质量反而不如 Bing
      - 例如 `ipdk_crn28hpc+` 和 `iPDK_CRN28HPL` 由于两搜索引擎对于 `_` 的处理方式不同，Bing 的搜索结果要显著好于 Google
  - 使用传统搜索引擎的筛选进行搜索
    - 例如 site:example.com, "exact_match_with_qutoes"，在 2015 年的新闻
- **嵌套**：以上所有情况的嵌套
  - 例如 PDF 中的图片、表格
    - 案例：搜索 `Command A gpqa`，标准答案 **50.8** 在 `https://cohere.com/research/papers/command-a-technical-report.pdf` 的表格中
  - 例如登录墙中的评论区

> Q: Alternatives to OpenAI's Deep Research / Deep Search apart from Grok, Gemini, Perplexity and open-source alternatives.
>
> 参考答案: [Genspark](https://www.genspark.ai/agents?type=moa_deep_research), [h2oGPTe](https://h2ogpte.genai.h2o.ai/), [flowith](https://flowith.io/), [suna](https://www.suna.so/), [Minimax](https://agent.minimax.io/), [Jina AI](https://search.jina.ai/), [Komo](https://komo.ai/)

> Q: search with quotes “tsmchome”. Based on online information, infer the folder structure. Show me the results in an output format similar to the `tree` command.
>
> 参考答案：

```
TSMCHOME/
├── digital/
│   ├── Front_End/
│   │   ├── timing_power_noise/
│   │   │   ├── NLDM/
│   │   │   │   ├── tcbn65gplus_200a/
│   │   │   │   ├── tcbn40lpbwp_200a/
│   │   │   │   ├── tcbn28hpcplusbwp30p140_180a/
│   │   │   │   ├── tpdn65gpgv2od3_sd_200a/
│   │   │   │   ├── tcbn65gplus_140b/
│   │   │   │   └── [various process node libraries]/
│   │   │   └── CCS/
│   │   │       └── tcbn28hpcplusbwp30p140hvt_180a/
│   │   └── verilog/
│   │       └── [Verilog source files]
│   ├── Back_End/
│       ├── lef/
│       │   ├── tcb018gbwp7t_270a/
│       │   │   ├── lef/
│       │   │   │   └── tcb018gbwp7t_5lm.lef
│       │   │   └── techfiles/
│       │   ├── tcbn65gplus_200a/
│       │   │   └── lef/
│       │   │       └── tcbn65gplus_9lmT2.lef
│       │   └── tcbn16ffcllbwp16p90pm_100a/
│       │       └── lef/
│       │           └── tcbn16ffcllbwp16p90pm.lef
│       └── milkyway/
│           └── tcbn65gplus_200a/
│               └── techfiles/
│                   └── tsmcn65_9lmT2
```

> Q: Alternatives to cursor app?
>
> 参考答案：Windsurf, Trae, Kiro, VSCode + Copilot   (典型错误：Codeium, Zed Editor)

> Q: The command recompiles all out-of-date files in a QuestaSim project? (not `vlog` or `vcom`)
>
> 正确答案：`project compileoutofdate`    (典型错误：`vlog -work work +acc=r *.v`)

> Q: "hiFormDone" 函数中的 hi 是什么意思？
> 
> 正确答案：[Human Interface](https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/50958/whats-the-difference-between-le-commands-and-hi-commands)

> Q: The latest sub-version for Cadence Virtuoso 6.1.8 and Virtuoso 23.1?
>
> 正确答案：[ISR34](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuoso-icadvm20-1-isr34-and-ic6-1-8-isr34-now-available), 当然如果你再细一点，可以发现有 [ISR36](https://bbs.eetop.cn/thread-991360-1-1.html), 不过这个要非常细，这些链接也是可以的 [1](https://www.nulledfrm.com/threads/cadence-virtuoso-ic06-18-360-linux.133645/#post-815659)[2](https://dl4all.org/software/graphics-design/866023-cadence-virtuoso-ic0618360-linux.html)[3](https://downloadly.ir/software/engineering-specialized/cadence-ic-design-virtuoso/)[4](https://www.iranhack.com/forum/forum/%D9%86%D8%B1%D9%85-%D8%A7%D9%81%D8%B2%D8%A7%D8%B1/188483-cadence-virtuoso-ic06-18-360-linux)[5](https://bbs.eetop.cn/thread-991360-1-1.html)[6](https://bbs.eetop.cn/thread-984059-1-1.html); [ISR14](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuoso-ic23-1-isr-14-now-available), 这个的话官方确实就是最新，"IC23.10.130" 尚可搜到，14 就搜不到了。

> Q: function to get variable type in cadence virtuoso?
>
> 正确答案：`type()`

> Q: How to draw a rounded rectangle in originpro?
>
> 正确答案：there is no simple way

> Q: virtuoso schematic lock placement. not in layout view or locking the file. but locking instance positions in schematic view. answer within 50 words.
>
> 正确答案：no you can't

> Q: Packages Explicitly NOT Included in Mathjax `AllPackages` by Default?
>
> 正确答案：`physics`, `autoload`, `require`, `setoptions`, (`colorv2`)
>
> 参考来源：[所有包](https://docs.mathjax.org/en/latest/input/tex/extensions/index.html), [启用的包](https://github.com/mathjax/MathJax-src/blob/master/ts/input/tex/AllPackages.ts), [参考链接](https://github.com/jupyterlab/jupyter-renderers/issues/229)

> Q: Quantus, Raphael, StarRC, RaptorX, RaptorH, Exalto, EMX, xRC and xACT. Which are Cadence's? Which are Synopsys's?
>
> QX: Help me research the Quantus, Raphael, StarRC, RaptorX, RaptorH, Exalto, EMX, Calibre xRC, Calibre xACT, and then sort them into tables.
>
> 正确答案：Cadence: Quantus, EMX (acquired); Synopsys: Raphael, StarRC, RaptorX (acquired), RaptorH (acquired), Exalto (acquired)

> Q: What is the newer version of ICADVM20.1, and what is the older version of ICADVM18.1? (ISR is just a minor version number, no need to mention it, do not mention any versions related to ISR, I only want the major versions)
>
> 正确答案：ICADV12.3, IC23.1

> Q: Do TSMC Shanghai fab and Nanjing fab offer MPW shuttles? Answer within 50 words. Don't tell me you're not sure, I'm very sure the definite answer is online (it might not be a direct answer, but after synthesizing the information, it's enough for you to make a definite judgment), so your final answer will be something like Shanghai: No, Nanjing: Yes. Note that this is just an example of the answer format, and is not necessarily the correct answer.
>
> 正确答案：Shanghai Fab10 yes; Nanjing Fab16 no. ref: [2025 TSMC CyberShuttle Service Plan](http://www.szicc.org.cn/attachment/0/80/80748/1230778.pdf)

> Q: A comparative table summarizing the performance of Claude Sonnet 3.5 (aka the old Sonnet 3.5), Sonnet 3.6 (aka the Sonnet 3.5 new), Sonnet 3.7, Sonnet 4 on the SWE-bench Verified.
>
> 正确答案：pass@1: 33%, 49%, 62.3%, 72.7%; thinking: N/A, N/A, 70.3%, 80.2%

半开放问题：

> Q: I want to create something similar to Cadence Virtuoso ViVA. Which one should I use among ECharts with lttb, Plotly.js, or uPlot?
>
> 答案：Grok 3 DeeperSearch, Plotly.js > ECharts > uPlot; OpenAI o4-mini DR, uPlot > ECharts > Plotly.js; Perplexity DR, uPlot > ECharts = Plotly.js; Gemini 2.5 flash DR, uPlot > Plotly.js > ECharts 

> Q: 中英文搜索针对小众领域代码的 LLM benchmarks。一般的 code benchmark for LLM 都是大众的 C++, Python, Javascript 之类的。但是有很多小众代码领域，包括但不限于 SystemVerilog, LaTeX, CMake, AHK, PowerShell, Assembly, Lisp, tcl 等小众代码有什么 benchmark 吗？例如，针对 Verilog 有 VerilogEval, RTLLM, [scale-lab/MetRex](https://github.com/scale-lab/MetRex), [ProtocolLLM](https://arxiv.org/abs/2506.07945)（在最终报告中不要再提及这些了）; 针对 LaTeX 的 [TeXpert](https://arxiv.org/abs/2506.16990), [vTikZ](https://arxiv.org/abs/2505.04670); 针对全面的有 [McEval](https://mceval.github.io/)。不要背景、意义、挑战与解决方案之类的空话。


### 实践问题（也许我们可以叫 AgentQA？）

> Q: customize Word/Powerpoint text highlight colors?
>
> 网上答案：认为无法实现，使用 shading 或文本框背景替代，不过无法被 ctrl+h 搜索到。
> 
> 正确答案：先使用 Font Color - Eyedropper 添加到 Recent Color 中，再在 Text Highlight Color 选项卡选择 Recent Color

> Q: How to paste OMML into Word?

> 网上答案：无
> 
> 正确答案：使用 `text/html` 类型的剪贴板，用特定的 html 包裹 OMML

> Q: 在 iPhone 14 中从底部小横条上划并迅速松开（所以不是 App Switcher 或 Spotlight），完成两下这个操作后会回到哪个界面？
>
> 正确答案：第一次上划会关闭当前应用，回到主屏幕 Home Screen；第二次上划会从当前主屏幕页面回到第一页（最左侧的）主屏幕
>
> 正确情况：Sonnet 3.7 对; r1-0528 错; Gemini 2.5 Pro 错

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

<!-- 太简单了，淘汰
> QC: 理想 LC 的 τ 是什么？一阶 RC 低通滤波器的 natural frequency 是什么（不是截止频率）？给出总计 30 个字以内的解答。
> What is the τ of an ideal LC? What is the natural frequency of a first-order RC low-pass filter (not the cutoff frequency)? Answer in under 30 words total.
>
> 正确答案：没有、没有。因为 τ 针对 first-order LTI, LC tank 是二阶系统；因为 natural frequency 适用于 second-order LTI
>
> 正确情况：GPT4.5 对; Sonnet 3.7 错; Sonnet 4 对
-->

> Q: NMOS 弱反型区电流公式？（不要在最终结果中带 $I_{d0}$ 或 $I_S$ ，写在 latex code block 中）
>
> 正确答案： $I_d = \left[ \mu C_{ox} \dfrac{W}{L} (n-1) V_t^2 \right] \exp\left(\dfrac{V_{gs} - V_{TH}}{n V_t}\right) \left(1 - \exp\left(-\dfrac{V_{ds}}{V_t}\right)\right)$
>
> 正确情况：o1p 漏了 (n-1) 项; Sonnet 3.5 对; big-engine-test 对; 3-opus 对

> QC: 试推导 MOSFET 的亚阈值 $r_o=\frac{V_T}{I_{d}} \exp(\frac{V_{ds}}{V_T}-1)$, 其中 $I_d$ 是 MOSFET 目前的亚阈值电流
>
> 正确答案：公式就是不对的，应当为 $\frac{V_T}{I_{d}} \left( \exp(\frac{V_{ds}}{V_T})-1 \right)$
>
> 正确情况：2-flash-thinking 对; Sonnet 3.7 thinking 对; o3-mini 对但没指出错误

> Q: 随便找一篇专业相关的论文的一大段，令其翻译至中文
>
> 典型错误：大部分 LLM 会存在不同程度的专有名词翻译错误，最典型的是 device 没有翻译成“器件”。

<!-- 太简单了，淘汰
> Q: NMOS + 一个电阻的 source follower 的 $A_{V_{DD}}$ 是多少？不考虑体效应，但是考虑 CLM
>
> 正确答案：$\dfrac{1}{1+g_mr_o+\frac{r_o}{R_S}}$ 或 $\frac{g_{ds}}{g_m+g_{ds}+\frac{1}{R_S}}$
>
> 正确情况：o3-mini-high 对错; Gemini 2.5 Pro 对; Grok3 对
-->

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

#### 其他

> Q: 4.5米, 6米, 20米长的竹竿能否通过高4米宽3米的门？Can poles of 4.5 meters, 6 meters, and 20 meters in length pass through a door 4 meters high and 3 meters wide? Omit the process and give the answer directly, for example, "Yes, No, Yes"          [ref](https://zhuanlan.zhihu.com/p/23434595912)
>
> 更简单的版本：6米长的队伍能不能通过高4米宽3米的门？ 
>
> 正确答案：都可以
>
> 正确情况：o3-mini-high 对对对对 (加上20米后, 错错); 4oL 错; o1 错; Gemini 2.5 Pro 错错; grok3 错错错; r1 错; GPT4.5 错

> Q: #D7E8FF + #FFCCCC. Subtractive color mixing result in HEX?
>
> 典型错误：#D7B5CC, #D7B8CC, #D2B4D2, #D7CCCC, #D8CCCC
>
> 正确答案：#EBDAE5, #EBDAE6, #ECDAE6? #D7BACC?

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
> 
> 人脑思路：
> 1. 因为第一个1必是正号，所以其实就是通过五个1、两个4、一个5、一个8、两个9（所有数字不应全部用上）来加减得到个位是 4 的一个数字，可以凑 4 + 0 , 14 + 0, 24 + 0, 34 + 0, 44 + 0
> 2. 
> 
> 正确情况：o1-min, o3-mini 对/回答不会/回答不可能; o1 超时超时超时; o3-mini-high 超长思考后超时; Gemini 2.5 Pro 对对
>
> 本题可以充分测试 max output token (o3-mini 原生的 1M 确实是有用的)

> Q: 0.4646018366... 这个无理数对应的符号表示结果是什么？例如 0.1415926... 的符号表示结果是 \pi-3。0.4646018366... 这个数据在我给你的有效位数内没有任何的四舍五入错误
>
> 正确答案： $\frac{5-\pi}{4}$
>
> 正确情况：Gemini 2.5 Pro 错错错; o3 错; o4-mini 错; grok-4 超时

> Q: 2025 年 7 月 22 日的农历和 2003 年 7 月 27 日的农历是同一天吗？
>
> 正确答案：都是六月廿八
>
> 正确情况：Gemini 2.5 Pro 错错; o3 错

> Q: $\left[ \mu C_{ox} \frac{W}{L_2} (n-1) V_T^2 \right] \exp \left( \frac{V_{G} - V_{S2} - V_{TH2}}{n V_T} \right) \left( 1 - \exp \left( - \frac{V_D - V_{S2}}{V_T} \right) \right)=\left[ \mu C_{ox} \frac{W}{L_3} (n-1) V_T^2 \right] \exp \left( \frac{V_{G} - V_{TH3}}{n V_T} \right) \left( 1 - \exp \left( - \frac{V_{S2}}{V_T} \right) \right)$ 除了 $V_{S2}$ 不知道，别的都已知，且 $V_{TH2}=V_{TH3}=V_{TH}$ ，求 $V_{S2}$
>
> 正确答案：下一题


> Q: $V_{S2} = V_T\ln(\frac{1}{x})\quad\text{with}\quad x^{1/n} = \frac{L_2}{L_3}(1-x)$ 和 $V_{S2} = nV_T\ln(\frac{1}{x})\quad\text{with}\quad x^n + \frac{L_3}{L_2}x - 1 = 0$ 两个 $V_{S2}$ 的表达式等价吗？
>
> 正确答案：等价。令 $x_2=x_1^{1/n}$ 即可。


> Q: Solve $y^n + \frac{L_3}{L_2}y - 1 = 0$ analytically in a closed-form, where $1<n<2$. Solution should not be numerical nor approximate (such as series expansion). The solution does exist.
>
> Q: Given $x^n + ax - 1 = 0$, solve for $x$ in a closed-form analytically, where $1<n<2$. Solution should not be numerical nor approximate (such as series expansion). The solution does exist, but not in elementary functions.
>
> 正确?答案：$y=\left\{\frac{1}{\frac{L_3}{L_2}(n-1)}\,W\!\Biggl[\frac{n}{n-1}\Bigl(\frac{L_3}{L_2}\Bigr)^{-\frac{n}{n-1}}\Biggr]\right\}^{\frac1{n-1}}=1 - \frac{1}{n}\frac{L_3}{L_2} + \frac{(3-n)}{2n^2}\left(\frac{L_3}{L_2}\right)^2 - \frac{(n^2-5n+10)}{6n^3}\left(\frac{L_3}{L_2}\right)^3 + ...$
>
> 正确情况：grok3 thinking 不会; qwq 32b 不会; o3-mini 对


> Q: What is the relationship between the transcendental equation $x=x^{m}+q$ and the Lambert W function?
>
> 正确答案：Not sure $x=\exp\left[-\frac{1}{m-1}\,W\!\left(-\frac{m-1}{m}\,q^{\frac{m}{m-1}}\right)\right]$
>
> 正确情况：o3-mini 对


> Q: Are $x=\exp\left[-\frac{1}{m-1} W\left(-\frac{m-1}{m}q^{\frac{m}{m-1}}\right)\right]$ and $x = x^m + q$ equivalent?
>
> 正确答案：Yes? Not sure
>
> 正确情况：o3-mini 对; Sonnet 3.7 对; grok 3 thinking 对
>
> - Set $t = -\frac{1}{m-1}W\left(-\frac{m-1}{m}q^{\frac{m}{m-1}}\right)$, so $x = e^t$.
> - Substituting into $x = x^m + q$: $e^t - e^{mt} = q$
> - If $W(z) = w$, then $z = we^w$: In our case, $W\left(-\frac{m-1}{m}q^{\frac{m}{m-1}}\right) = -(m-1)t$,  so: $-\frac{m-1}{m}q^{\frac{m}{m-1}} = -(m-1)t \cdot e^{-(m-1)t}$​
> - Simplifying: $\frac{m-1}{m}q^{\frac{m}{m-1}} = (m-1)t \cdot e^{-(m-1)t}$
> - Now, let's examine our equation $e^t - e^{mt} = q$: $e^t - e^{mt} = e^t(1 - e^{(m-1)t}) = q$
> - Since $e^{(m-1)t} = (e^t)^{m-1} = x^{m-1}$, we have: $e^t(1 - x^{m-1}) = x - x^m = q$

> Q: Given $y^n + \frac{L_3}{L_2}y - 1 = 0, \text{where} 1<n<2, 0.01<\frac{L_3}{L_2}<100$. How to approximate the analytical solution of $y$? The final approximate analytical solution should avoid case discussion and transcendental functions. Within the range of $1<n<2, 0.01<\frac{L_3}{L_2}<100$, the error of the approximate solution should be controlled within 5%, and the solution should be as concise as possible while ensuring accuracy.
>
> 参考答案：


## Agent 能力测试

Q: 世界 500 强中的行业分布，搜索后做成 pie chart，同时提供一份 csv 表格，包含公司英文名、中文名、行业、Revenues 和 Profits

Q: 用 mathjax 4 的版本构建一个在线数学编辑器

## 评测的小 ideas

### Bode

由 Bode 图想到是不是可以使用 Bode 图的方式更好的展示不同模型在不同难度下的性能情况。在简单的情况下，小模型的表现有可能会比没有特调过的大模型好；而在多种测试条件下表现良好的小模型在复杂问题下的能力衰退可能会很快，然后如果要求平均能力，直接求个积分就行。如果需要多领域的情况可以使用六边形的立体 Bode 图。

但是这个图要求我们有大量不同难度的测试集，其中比较容易想到的是数学的评估，因为其客观性比较强，我们可以将横轴取小学6年，中学6年，本科4年，硕士3年，共19各数据点的原创数学试题作为评估，拟合出一些漂亮的数学能力 Bode 图。或是小学奥数+初中奥数+高中奥数等...

![](https://github.com/user-attachments/assets/3e18c5c2-ea11-467b-bcbf-2a72b52f77e0)

## VLLM 题目列表

Use your native image editing capability to make the following virtuoso schematic screenshot to a Visio-style white-background circuit schematic for academic papers (not simply invert color, but make the wire thicker, delete the annotations on components, etc. to make the schematic publish-ready)

The first image acts as a style reference for you.

![image](https://github.com/user-attachments/assets/dbb993b9-2d15-43b1-bfc9-eee475d5375b)

