# EDA

## The Industry and Open Source

EDA 行业和传统 to C 的软件行业是很不一样的。一句话概括就是“请交钱”，两句话总结则是 “UX 是无所谓的，sign-off 是要 golden 的”。

一些对比案例：

- 平台：CS 有开源的 Linux；EDA 用要签 NDA 的 PDK，请给 Fab 交钱
- 管理：CS 用开源的 Git；EDA 用 [Keysight SOS](https://www.keysight.com/us/en/products/software/pathwave-design-software/design-data-and-ip-management/design-data-management-sos.html) 或 [IC Manage GDP-XL](https://www.icmanage.com/design-ip-management-gdp-xl/)，请给 Keysight 交钱。国内（曾经的）交钱列表：[晏之 yangeis](http://www.yangeis.com.cn/news/38.html) 提供
- SDK：CS 用开源的 .NET SDK 和免费的 CUDA Toolkit；EDA 用 OpenAccess SDK，请给 Si2 交钱（这个 "Open Access" 的 SDK 比 OpenAI 还不 Open，另外小道消息称说[中科大](https://bbs.eetop.cn/thread-962015-1-1.html)有 SDK）
- 编辑：CS 用免费的 VSCode 编辑代码；EDA 用 Virtuoso Layout XL 画电路，请给 Cadence 交钱
- Lint: CS 用开源的 ESLint 和 Clang-Tidy；EDA 用 SpyGlass，请给 Synopsys 交钱
- 构建：CS 用开源的 GCC 和免费的 MSVC 编译代码；EDA 用 Spectre, VCS 仿真和 Fusion Compiler 综合，请给 Cadence 和 Synopsys 交钱
- 测试：CS 用开源的 JUnit 和 Selenium 等做测试；EDA 用 Calibre 做验证，请给 Siemens 交钱
- IDE：CS 总算有个付费的 Jetbrains 了；EDA 用 Virtuoso ADE，请给 Cadence 交钱 
- 文档：CS 不用多说了，哪怕 MATLAB 的 examples 都是全公开的；EDA 的 Workshop 和 Lab，请给 Synopsys 和 Cadence 交钱


当然，EDA 界也是有一些开源或免费替代品的：比如 [olofk](https://github.com/olofk/edalize) 提供的一些 "API"，[dalance](https://github.com/dalance) 或 [chipsalliance](https://github.com/chipsalliance) 开发的 systemverilog lint，[iverilog](https://github.com/steveicarus/iverilog) 和 [verilator](https://github.com/verilator/verilator) 可以用来仿真，[Yosys](https://github.com/YosysHQ/yosys) 可以用来综合，[xschem](https://github.com/StefanSchippers/xschem) 和 [KLayout](https://www.klayout.de/) 可以用来编辑 schematic 和 layout。但是没有一项开源工具是 "SOTA" 的（用 EDA 的术语说就是 "golden" 的），也没有一项工具会被用于商业项目。

从曾经 UC Berkeley SPICE 的开源，到今日 EDA 完全闭源。为什么 SPICE 和 Chromium 会开源，而 Synopsys 和 Jetbrains 会闭源，这些软件开源和闭源的原因都相同吗？

或者说，行业软件开源和免费才是一个小众而稀有的名词？Adobe, Intuit, Autodesk 这些行业软件本就是高度闭源并收费的。似乎除了 CS 行业，to B 天然意味着闭源和收费，所以为什么 GCC 或是 Linux 一直能维持开源才是值得探究的。

另一个和传统软件行业不同的是，EDA 的用户侧对新版的追求非常不强烈。2016 年版的 EDA 软件有大把人还在用，而十年前 to C 的软件到现在是基本上不可用的状态。比如说三个点：

1. EDA 默认的 Version Control 是一个完全的灾难，软件行业嘲笑使用 xxx_v2 或 xxx_20250902 的命名法在 EDA 领域无处不在
2. 几乎所有 EDA 的所有操作都是 Synchronous + Thread Blocking。Virtuoso 的 ViVA 在 IC23.1 才修复这个问题，而生成 Calibre view 的这个问题还一直没修复。好听点叫做 Windows File Explorer 同级别。
3. EDA 软件只做加法而不做减法，这点其实和同样为了保持向后兼容性的 Windows 很像。EDA 还在用 csh, tcl 这种早已被现代主流软件开发所抛弃的语言，连 Microsoft 都放弃 VB 了。不过这一点还是可以理解的，和 LLM 讨论出三点我比较认可的原因：一是验证方式，重新跑一遍 python 的 EDA 流程是需要 tape-out 来说话的；二是失败成本，简单易懂；第三点我没想到的是生态系统控制权的差异，Synposys+Cadence 之和在 EDA 领域行业的影响力是不及 Microsoft 在软件行业影响力的，Foundry 和 Fabless 是有很大的话语权的。

在 EDA 开发者看来，软件实现功能以支持 tapeout 比可维护性更重要，最近看到一个 ADI 开源的 [Verilog-A Model Rule Enforcer](https://github.com/analogdevicesinc/vampyre)，整个一个 8000 行的 python 来解决。不过虽说是 ADI，其实也只有一个 Geoffrey Coram 老工程师在单打独斗。



一些观点和视角：

- 业余 EDA 开发者视角：当一个持有 Open Source 精神和关注 UX 的开发者进入 EDA 圈子，最终却是离去：详见 [Digital-IDE](https://github.com/Digital-EDA/Digital-IDE) 开发者的[感悟](https://www.zhihu.com/question/1890410020828575085/answer/1917651711587230283)
- 专业 EDA 开发者视角：Verilog-AMS 的语法 by [豆芽](https://www.zhihu.com/pin/1928327506064315913); SystemVerilog 的语法 by [轻思科技](https://www.zhihu.com/pin/1898367860604108866) [2](https://zhuanlan.zhihu.com/p/1896521512976090461)
- 学术界视角：Are open source digital design flows ready for mainstream? by Frank K. Gürkaynak, ETH Zürich. [slide](https://mos-ak.org/bruges_2024/publication/8_Gurkaynak_ESSERC_2024_ETHZ_pulp.pdf)
- IC infra 从业人员分享：https://icinfra.cn/

惊闻浙大 55nm 线 pdk 要[准备](https://www.zhihu.com/question/497652898/answer/1951322675583628264)开源了，这对国内的数字设计和数字 EDA 无疑是重大利好。SMIC 没动力做的，ICSprout 做确实是合适的。三年后，待 pdk 磨合完毕，这将成为中国 IC 教育界的 golden standard。

## Domestic EDAs



## Niche EDAs

笔者已知有 tape out 支持的：

- [RFIC-GPT](https://zhuanlan.zhihu.com/p/719728477) for RF passive devices.
- [SkillCAD](https://skillcad.com) crack: [https://bbs.eetop.cn/thread-935538-1-1.html](eetop)

笔者未知：

- [Scientific Analog](https://www.scianalog.com/) Verify Analog Circuits in SystemVerilog: Event-Driven Analog Models without Writing Codes
- [StarVision](https://www.concept.de/StarVision.html)

## Cracking

导读：[《这几年的EDA行业的破解和反破解的战争》](https://bbs.eetop.cn/thread-675771-1-115.html)

加密原理 FlexLM → FlexNet


- TerraWilly, 业内俗称"T神": [Github](https://github.com/TerraWilly), [EETOP](https://blog.eetop.cn/space-uid-1764513.html), [看雪](https://bbs.kanxue.com/homepage-post-830221-1.htm); [TEAM_EFA](https://github.com/BinaryHackerLab)@YAHOO.COM 的重要成员，逆向专家，对 FlexNet 有着非常深的研究。~~从商业的角度建议 Flexera 年薪五百万给他聘过去~~
  - [SynopsysLicenseMakerMod](https://bbs.eetop.cn/thread-985077-1-1.html)
  - [SynopsysMonoSlayer](https://bbs.eetop.cn/thread-962956-1-1.html) [2](https://bbs.eetop.cn/thread-978013-9-1.html): 用于 Linux 平台下的 Synopsys
- xbwpc: Github [repo](https://github.com/xbwpc/EDA_FeatureColle), [EETOP](https://blog.eetop.cn/856100)
  - scl_keygen 过时了，不再需要工具算号了；直接 patch，license 文件批量替换文本即可 [ref](https://bbs.eetop.cn/forum.php?mod=redirect&goto=findpost&ptid=983358&pid=11397884)
- [open-CAD](https://bbs.eetop.cn/thread-863823-1-1.html)
  - 1patch, aka [OCAD](https://bbs.eetop.cn/thread-863823-1-1.html)
    - cdslicgen.py
    - mgclicgen.py
    - ? 
    - pubkey_verify
      - Generic ECC pubkey replacer by tanker. from https://bbs.kanxue.com/thread-186041.htm
    - pubkey_checksum
      - synopsys_checksum
    - pubkey_java
- https://alllicenseparser.com/engineering-db/flexlm/


https://github.com/xpww

```bash
cd /eda/synopsys/scl/2024.09
./pubkey_verify -y
./synopsys_checksum -y
./SynopsysMonoSlayer -a
```


破解的攻与防：

拧巴和别扭的分享精神：请原谅我在这里用两个口语词汇，我实在是找不到更恰当的词语去形容这种分享精神了。EETOP 上分享者往往喜欢用 "$ynop$y$" "C家" "T$MC" 这种反 SEO 方式让自己不被搜索引擎索引。猜测可能是有两个目的，一是让 EETOP 可以活得久一点，不至于被告，这样大家可以


https://bbs.eetop.cn/thread-675329-1-2.html
https://bbs.eetop.cn/thread-889064-1-60.html
https://bbs.eetop.cn/thread-971651-1-8.html
https://bbs.eetop.cn/thread-981512-1-18.html
https://bbs.eetop.cn/thread-988224-1-35.html
https://bbs.eetop.cn/thread-992392-1-1.html
原来这里应该有个好东西：http://bbs.eetop.cn/thread-879031-1-1.html

## Installing

至少使用 RHEL8.4 以上的 RHEL8 版本，安装 2025 版 EDA，正如 [Synopsys](https://www.synopsys.com/support/licensing-installation-computeplatforms/compute-platforms/compute-platforms-roadmap.html), [Cadence](https://www.cadence.com/en_US/home/support/computing-platform-support/support-road-map-2023x-2026x.html) 以及 [Calibre](https://calibre.mentorcloudservices.com/docs/Calibre_OS_Roadmap.htm) 要求的那样

- Synopsys
  - Synopsys Corporate Licensing (SCL), License Manager, https://bbs.eetop.cn/thread-985857-1-1.html
  - VCS vW-2024.09-SP1: https://www.0daydown.com/06/2938634.html
  - Verdi vW-2024.09-SP1: https://www.0daydown.com/06/2937248.html
- Cadence
  - Virtuoso IC25.1 base: https://bbs.eetop.cn/thread-992365-1-1.html
  - Virtuoso IC23.1 base: https://bbs.eetop.cn/thread-951724-1-3.html; https://bbs.eetop.cn/thread-960760-1-2.html
  - Virtuoso IC23.1 ISR13: https://bbs.eetop.cn/thread-987799-1-3.html (ISR11: [1](https://bbs.eetop.cn/thread-985337-1-13.html))
  - Virtuoso IC6.1.8 ISR36: https://www.0daydown.com/03/2833851.html (ISR36: [0](https://bbs.eetop.cn/thread-991316-1-1.html) ISR34: [1](https://bbs.eetop.cn/thread-986436-1-27.html) [2](https://bbs.eetop.cn/thread-981601-1-21.html))
  - EMX
  - Xcelium 24.03.001: https://www.0daydown.com/08/2542782.html
- Siemens
  - Calibre 2025_1_16: https://bbs.eetop.cn/thread-985333-1-1.html


https://blog.csdn.net/weixin_43444334/article/details/147316674

https://wiki.to.infn.it/vlsi/workbook/computing
