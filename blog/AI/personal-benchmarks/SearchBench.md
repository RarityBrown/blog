## My Personal Search Benchmark

### Background

#### Models

<details>
<summary>Models</summary>

- Domain-specific LLMs (One-stop search + LLM answer APIs)
  - [Perplexity](https://docs.perplexity.ai/getting-started/models)
  - [Linkup](https://app.linkup.so/playground?example=deepSourcedAnswer)
  - [Exa](https://docs.exa.ai/reference/answer)
  - [Liner](https://liner.com/features/ai-search)
  - [Jina](https://jina.ai/deepsearch/)
  - [You](https://documentation.you.com/api-modes/search-api)
- General LLMs with search + browse tool
  - [Gemini](https://ai.google.dev/gemini-api/docs/google-search) based on Google
  - [Gemini url context](https://ai.google.dev/gemini-api/docs/url-context)
  - [OpenAI](https://platform.openai.com/docs/guides/tools-web-search) based on Bing
  - [Claude](https://docs.anthropic.com/en/docs/agents-and-tools/tool-use/web-search-tool) based on [Brave](https://simonwillison.net/2025/Apr/21/ai-assisted-search/)
  - [Grok](https://docs.x.ai/docs/guides/live-search)
  - [openrouter](https://openrouter.ai/docs/features/web-search) based on Exa
- Agents with "deep" search + browse + (visual)
  - [Genspark](https://www.genspark.ai)
  - [h2oGPTe](https://h2ogpte.genai.h2o.ai/)
  - [skywork](https://skywork.ai)
  - [MiroThinker](https://dr.miromind.ai/)
  - [flowith](https://flowith.io/)
  - [suna](https://www.suna.so/)
  - [Minimax](https://agent.minimax.io/)
  - [Komo](https://komo.ai/)

</details>

#### Existing Benchmarks

- SimpleQA
- BrowseComp
- LMArena - Search Arena

#### Corners

Search 有非常多的 corner cases，一点都不优雅，频率依次倒序，包括但不限于：

<details>
<summary>Corners</summary>

- **无关、干扰、矛盾信息**
  - 页面内广告等无关信息；整个页面和搜索问题无关或低密度信息；
  - 不同页面间信息矛盾；页面信息过时；SEO 优化的看似相关、实则劣质页面；官方网站信息不如第三方中肯客观，没有小道消息
    - 例如：`Where does the AI researcher Jason Wei work?` 其个人主页上还未更新工作单位
    - 例如：在 [Alternative](#Alternative-类) 类型的搜索过程中，SEO 优化的劣质页面问题非常明显
- **不可交互的非纯文本内容**
  - 静态内容
    - 图片：搜索模型的确需要强视觉能力的
      - 例如在 20250406 搜索 "llama 4 maverick vs deepseek v3 0324. Give me a benchmark table, including GPQA etc." Sonar, gpt-4o-search, Gemini 2.5 Pro Grounding, Jina Deep Search 提供的对比表格没有一个是 100% 正确的，而且每次搜索结果非常不稳定，相对来说后两者略好一些。因为 llama 官方的对比表格就是图片，而那时候媒体转载也是直接通过图片，还没有任何成文的纯文本内容。
      - 例如“中国博士历年延毕率”
    - 网页表格、图表
    - OpenAI 给出的答案是 Agent，我还不确定合不合理。
  - 动态内容
    - 视频：例如有的视频教程，比如教你怎么在 Word 中实现一个功能
      - 这一点 Google 做得不错了，YouTube 视频字幕可以低幻觉作为参考资料，但是视频画面仍然是一个问题
      - 视频画面需要要求 AI 有一定的动态视力能力，目前 Google 的做法是 1 fps 采样视频，然后全部图片喂给 AI。这显然和人类相去甚远，可能需要加一个前置模型来处理视频数据（类似于现在这么多文档预处理 - ocr 结构提取等的小模型），高信息密度和低信息密度和画面应该通过压缩的方式传给 vLLM。当然，如果哪天 context window 扩大到 1B 了，那可能除了算力和速度外，这个前置模型也没必要了。
    - Gif
- **非标准网页类型**
  - 动态加载的网页
    - 例如
      - 不同 tab 但网址相同的网页（例如 `lmarena.ai: The (2nd) best LLM on lmarena today?`）
      - 点击/滚动才展开的评论区
      - 折叠或需要翻页的内容（例如 `https://github.com/electron/electron/issues/9035`）
      - 社交媒体的登录框
      - 人机验证码
    - OpenAI 的[答案](https://youtu.be/twXsAiTINO0?t=567)是 Agent。我认为这是正确的，因为本质上只有这种 Agent 的方式可以实现通用性，只要人能过去的地方 Agent 理论上都能过去，而不是一个个去写规则。但是速度目前还是一个问题（也就是 vLLM 的问题），这个问题 Agent 需要 10 分钟，而有经验的相关人类应该 1 分钟以内就可以解决。
    - Google 目前的公开简单 [url context](https://ai.google.dev/gemini-api/docs/url-context) 方案仍然是抓取[静态内容](https://simonwillison.net/2025/Aug/18/google-gemini-url-context/)。但是 Gemini Doc 里面写明是支持图片的。
  - 在线超长 .pdf 文件，通过 pdf.js 加载的在线 pdf 文件；超大型网页
    - 例如 `https://www.spec.org/cpu2017/results/cpu2017/` `https://github.com/kaisugi/gpt4_vocab_list/blob/main/o200k_base_vocab_list.txt`
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

</details>

### Personal SimpleQA


### Personal HardQA

LLM w/o RAG 几乎不可能答对；为评估 Deep Search 而生，但不是 Deep Research，详见 Jina AI 的 Blog。

#### 可简单验证问题

<details>
<summary>可简单验证问题</summary>


##### 英文语境普通问题

- The command recompiles all out-of-date files in a QuestaSim project? (not `vlog` or `vcom`)
  - 正确答案：`project compileoutofdate`    (典型错误：`vlog -work work +acc=r *.v`)
- "hiFormDone" 函数中的 hi 是什么意思？
  - 正确答案：[Human Interface](https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/50958/whats-the-difference-between-le-commands-and-hi-commands)
- The latest sub-version for Cadence Virtuoso 6.1.8 and Virtuoso 23.1?
  - [ISR34](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuoso-icadvm20-1-isr34-and-ic6-1-8-isr34-now-available), 当然如果你再细一点，可以发现有 [ISR36](https://bbs.eetop.cn/thread-991360-1-1.html), 不过这个要非常细，这些链接也是可以的 [1](https://www.nulledfrm.com/threads/cadence-virtuoso-ic06-18-360-linux.133645/#post-815659)[2](https://dl4all.org/software/graphics-design/866023-cadence-virtuoso-ic0618360-linux.html)[3](https://downloadly.ir/software/engineering-specialized/cadence-ic-design-virtuoso/)[4](https://www.iranhack.com/forum/forum/%D9%86%D8%B1%D9%85-%D8%A7%D9%81%D8%B2%D8%A7%D8%B1/188483-cadence-virtuoso-ic06-18-360-linux)[5](https://bbs.eetop.cn/thread-991360-1-1.html)[6](https://bbs.eetop.cn/thread-984059-1-1.html); [ISR14](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuoso-ic23-1-isr-14-now-available), 这个的话官方确实就是最新，"IC23.10.130" 尚可搜到，14 就搜不到了。
- Packages Explicitly NOT Included in Mathjax3 `AllPackages` by Default?
  - 正确答案：`physics`, `autoload`, `require`, `setoptions`, (`colorv2`)
  - 参考来源：[所有包](https://docs.mathjax.org/en/v3.2/input/tex/extensions/), [启用的包](https://github.com/mathjax/MathJax-src/blob/3.2.2/ts/input/tex/AllPackages.ts), [参考链接](https://github.com/jupyterlab/jupyter-renderers/issues/229)         
- What is the newer version of ICADVM20.1, and what is the older version of ICADVM18.1? (ISR is just a minor version number, no need to mention it, do not mention any versions related to ISR, I only want the major versions)
  - 正确答案：ICADV12.3, IC23.1
- Do TSMC Shanghai fab and Nanjing fab offer MPW shuttles? Answer within 50 words. Don't tell me you're not sure, I'm very sure the definite answer is online (it might not be a direct answer, but after synthesizing the information, it's enough for you to make a definite judgment), so your final answer will be something like Shanghai: No, Nanjing: Yes. Note that this is just an example of the answer format, and is not necessarily the correct answer.
  - 正确答案：Shanghai Fab10 yes; Nanjing Fab16 no. ref: [2025 TSMC CyberShuttle Service Plan](http://www.szicc.org.cn/attachment/0/80/80748/1230778.pdf)
- A comparative table summarizing the performance of Claude Sonnet 3.5 (aka the old Sonnet 3.5), Sonnet 3.6 (aka the Sonnet 3.5 new), Sonnet 3.7, Sonnet 4 on the SWE-bench Verified.
  - 正确答案：pass@1: 33%, 49%, 62.3%, 72.7%; thinking: N/A, N/A, 70.3%, 80.2%
- TSMC 28nm price @ europractice in 2025? Just tell me how much for only 1 square millimeter. And answer within 100 words. I’m absolutely sure you can get the answer without email or online price calculator.
  - 正确答案：[€10609](https://europractice-ic.com/schedules-prices-2025/)
- Quantus, Raphael, StarRC, RaptorX, RaptorH, Exalto, EMX, xRC and xACT. Which are Cadence's? Which are Synopsys's?
  - 正确答案：Cadence: Quantus, EMX (acquired); Synopsys: Raphael, StarRC, RaptorX (acquired), RaptorH (acquired), Exalto (acquired)
  - 半开放版本: Help me research the Quantus, Raphael, StarRC, RaptorX, RaptorH, Exalto, EMX, Calibre xRC, Calibre xACT, and then sort them into tables.
- Can the latest version of gemini-cli read audio, pdf and docx files (not talking about gemini api, but gemini-cli)? answer within 50 words.
  - 正确答案：yes, yes, no
- Claude Opus 4 SimpleQA result? answer within 20 words.      Please refer to more sources.
  - 正确答案：[32.3%](https://www.kaggle.com/benchmarks/openai/simpleqa)。这题其实网上有一个更容易搜到的错误[信息](https://huggingface.co/datasets/smolagents/results/viewer/2024-12-26/train?f[model_id][value]=%27anthropic%2Fclaude-opus-4-20250514%27)，容易误导这些 search model
- The best LLM on LMarena's search arena today?
  - 正确答案：o3-search
- Create a comparison table of FP16, FP8 and FP4 dense + sparse PFLOPS for A100, H200, RTX5090, B200
- USNO 的计时精度是世界上最高吗？世界上第二高的是谁呢？
  - 应该不是的，但是懒得研究了。

##### 中文语境普通问题

- 中国国内目前排名前20的医院里，前身是教会医院的有哪些？超级简单回答。例如 “是：仁济、浙一、华西、华山...；不是：北大三院、积水潭、中山、瑞金...”。注意，这只是一个回答格式示例，并不是/不一定是正确答案。
  - 正确答案：是教会医院：北京协和、中国医大一院、仁济、瑞金、浙二、武汉协和、湘雅、华西；不是教会医院：301、北大一院、北大三院、中山、华山、浙一、郑大一附院、武汉同济、湘雅二院、中山一院、南方医院、西京。参考[2023复旦版排名](https://rank.cn-healthcare.com/fudan/national-general) (2024年11月发布)
  - 正确情况：Gemini 2.5 Pro w Google 对
- iPad 播放器 app？简单回答，不满足要求的不用提及。中英文双语搜索，至少参考 20 个有效信息源。app 要求：1. 明确支持 >2.0 (不包括等于，一定要大于) 倍速; 2. 在最近一年内更新过; 3. 不是 safari 扩展，是播放器 app; 4. 除了 VLC 以外
  - 典型错误：Infuse
  - 参考答案：
- iPad 播放器 app？简单回答，不满足要求的不用提及。中英文双语搜索。app 要求：1. 是个可以实时自动生成并显示字幕的播放器，而不是在线字幕生成服务或者本地视频剪辑软件; 2. 要当前已经支持的，而不是 VLC 这种只是宣布即将支持但是还没支持的; 3. 要支持中文和英文，所以原生 Live Captions 目前还不能用; 4. 除了 YPlayer 以外
  - 参考答案：应该是没有了

##### "No" 问题

- How to draw a rounded rectangle in originpro?  version: 2025a
  - 正确答案：there is no simple way; 2025b 以后[可以了](https://www.originlab.com/doc/Origin-Help/Create-Draw-Objects)
- virtuoso schematic lock placement. not in layout view or locking the file. but locking instance positions in schematic view. answer within 50 words.
  - 正确答案：no you can't
- How to use iPhone as keyboard for iPad? (Not as mouse or for Mac) Answer within 100 words.
  - 正确答案：there is no simple way
- General method to insert newlines that works across all Mermaid chart types? (for the latest version of Mermaid)
  - 正确答案：no you can't. 比如 Gantt 图完全[不支持](https://github.com/mermaid-js/mermaid/issues/5140)
- Besides Blackwell GPUs, Instinct MI350 Series, and Microsoft Maia 100, what else has **native hardware** support for MXFP4?
  - 正确答案：No more (August 2025)   或者 [Synopsys ARC VPX DSP IP](https://www.synopsys.com/articles/narrow-precision-data-types-embedded-ai.html) 勉强可以算？
- How to stop airpods from automatically connecting to windows 11 without 1.manually unpairing 2.affecting other connected BT devices 3.coding in powershell
  - 正确答案：no you can't.     [1](https://learn.microsoft.com/en-us/answers/questions/4174413/dont-connect-to-bluetooth-automatically-which-are) 和 [2](https://learn.microsoft.com/en-us/answers/questions/4163051/airpods-pro-automatically-connecting-to-laptop-whe) 都是官方的错误信息。

</details>

#### 半开放问题

<details>
<summary>半开放问题</summary>

##### Alternative 类

- Alternatives to OpenAI's Deep Research / Deep Search apart from Grok, Gemini, Perplexity and open-source alternatives.
  - 参考答案: [Genspark](https://www.genspark.ai/agents?type=moa_deep_research), [h2oGPTe](https://h2ogpte.genai.h2o.ai/), [flowith](https://flowith.io/), [suna](https://www.suna.so/), [Minimax](https://agent.minimax.io/), [skywork](https://skywork.ai), [Jina AI](https://search.jina.ai/), [Komo](https://komo.ai/), [MiroThinker](https://dr.miromind.ai/)
- Alternatives to cursor app?
  - 参考答案：Windsurf, Zed, Trae, Kiro, VSCode + Copilot
- Alternatives to Manus AI?
  - 参考答案：convergence AI, runner H, Genspark    (典型错误：MS Copilot)
- Alternatives to perplexity sonar api? I'm asking for alternatives to the sonar api, not the toC product perplexity itself.
  - 参考答案：[Models](#Models)

##### 能不能搜到

这类问题 Google 会很占优势。比如在 Qwen-Image 发布半小时内搜索，Gemini 2.5 Pro 就显著比 o3, opus-4 好。perplexity 也很厉害，目前不知道他们为什么看上去比 Bing 还牛，和 CF 喷他们有关系吗...


- aad08s040g? answer within 100 words.


##### 普通问题

- Give me four Qwen-2.5VL-based ocr models (not Qwen2.5-VL itself or ocr models based on Qwen2-VL). Answer within 100 words.
  - 参考答案： 7B based: [reducto/RolmOCR](https://huggingface.co/reducto/RolmOCR), [DocTron-hub/DocTron-Formula](https://github.com/DocTron-hub/DocTron-Formula), 3B based: [chatdoc-com/OCRFlux](https://github.com/chatdoc-com/OCRFlux), [nanonets/Nanonets-OCR-s](https://huggingface.co/nanonets/Nanonets-OCR-s)
- I want to create something similar to Cadence Virtuoso ViVA. Which one should I use among ECharts with lttb, Plotly.js, or uPlot?
  - 答案：Grok 3 DeeperSearch, Plotly.js > ECharts > uPlot; OpenAI o4-mini DR, uPlot > ECharts > Plotly.js; Perplexity DR, uPlot > ECharts = Plotly.js; Gemini 2.5 flash DR, uPlot > Plotly.js > ECharts 
- 中英文搜索针对小众领域代码的 LLM benchmarks。一般的 code benchmark for LLM 都是大众的 C++, Python, Javascript 之类的。但是有很多小众代码领域，包括但不限于 SystemVerilog, LaTeX, CMake, AHK, PowerShell, Assembly, Lisp, tcl 等小众代码有什么 benchmark 吗？例如，针对 Verilog 有 VerilogEval, RTLLM, [scale-lab/MetRex](https://github.com/scale-lab/MetRex), [ProtocolLLM](https://arxiv.org/abs/2506.07945)（在最终报告中不要再提及这些了）; 针对 LaTeX 的 [TeXpert](https://arxiv.org/abs/2506.16990), [vTikZ](https://arxiv.org/abs/2505.04670); 针对全面的有 [McEval](https://mceval.github.io/)。不要背景、意义、挑战与解决方案之类的空话。
- auto save / real-time save in cadence virtuoso? `dbSetAutoSave` doesn't seem to work and `checkForUnsavedViewsUponRun` is off topic.

- 用 mermaid 梳理复旦复控、复芯凡高、复旦微电子、上海华岭、复控华龙、皓骏创投、复微芯讯、复旦科创投、上海复旦创投（和复旦科创投是两家公司）、复旦复华、复微迅捷、上海菩扬、蒋国兴之间的关系。中文搜索、中文回答，把两两间的持股比例尽可能写清楚。同时，如果有和这个关系网很密切的公司和人员也可以加进 mermaid 图中
- search with quotes “tsmchome”. Based on online information, infer the folder structure. Show me the results in an output format similar to the `tree` command.
 - 参考答案：

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

</details>

