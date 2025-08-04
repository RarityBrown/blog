## My Personal Agent Benchmark

### 实践问题（也许我们可以叫 AgentQA？）

**我大致知道的**

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


---

**我知道可行的，但是需要花时间，懒得写正确答案的**

Q: 世界 500 强中的行业分布，搜索后做成 pie chart，同时提供一份 csv 表格，包含公司英文名、中文名、行业、Revenues 和 Profits

Q: 用 mathjax 4 的版本构建一个在线数学编辑器，展示一些新支持的功能

Q: 以下这些总共 7 个股票，给我他们五个五年（即 2025-2020 ... 2005-2000）和五个三年的增长率以及减掉各自大盘的增长率。做成可视化。

| 公司 (Company)                      | 国家/地区 (Country) | 主要交易所 (Primary Exchange)     | 主要代码 (Primary Ticker) | 主要指数 (Major Indices) | 美股交易所 (US Exchange) | 美股代码 (US Ticker) |
| :---------------------------------- | :------------------ | :-------------------------------- | :------------------------ | :----------------------- | :----------------------- | :------------------- |
| **施耐德电气 (Schneider Electric)** | 法国 🇫🇷             | 泛欧交易所巴黎站 (Euronext Paris) | **SU.PA**                 | CAC 40, EURO STOXX 50    | OTC (场外交易)           | **SBGSY** (ADR)      |
| **西门子 (Siemens)**                | 德国 🇩🇪             | 法兰克福证交所 (Xetra)            | **SIE.DE**                | DAX, EURO STOXX 50       | OTC (场外交易)           | **SIEGY** (ADR)      |
| **ABB**                             | 瑞士 🇨🇭             | 瑞士证交所 (SIX Swiss Exchange)   | **ABBN.SW**               | SMI (Swiss Market Index) | **NYSE** (纽交所)        | **ABB** (普通股)     |
| **伊顿 (Eaton)**                    | 爱尔兰/美国 🇮🇪/🇺🇸   | **NYSE** (纽约证交所)             | **ETN**                   | S&P 500, S&P 100         | **NYSE** (纽交所)        | **ETN** (普通股)     |

哦对，另外再加一个科华数据
