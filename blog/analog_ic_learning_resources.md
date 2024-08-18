# Analog IC Learning Resouces

## General EE

[kennethkuhn.com/students/](https://www.kennethkuhn.com/students/)

## IC

### Behzad Razavi

- book/slide/solution
  - 中文版翻译质量极高（甚至纠正了一些原版的错误），适合初学者（模电基础还是需要的） ⭐⭐⭐⭐⭐
  - 课题组[网站](https://www.seas.ucla.edu/brweb/teaching/)上提供了 slide、配套作业和考试的题目和解析
  - 网上的作业答案有三个版本：手写版、电子版、icdesign.com 版，其中从试看的视频质量来看 icdesign 版是不推荐购买的，手写版和电子版都有不少错误（特别是噪声那一章） ⭐⭐
- video
  - 广为流传的视频是 Razavi 的模电授课，而不是模集，内容偏基础
  - 本书的中文译者之一张鸿老师网课可参考 ⭐⭐⭐
- RF/PLL 的课和书还没研究

### Phillip E. Allen

- book/slide/solution
  - 他的书不适合初学者使用，目前最新的中文第三版翻译仍有一些机翻痕迹，但也不至于像网上说的有很多错误（意思就是还是有一些错误的）。不过书里面把 $V_{TH}$ 记作 $V_T$ 真的是不爽
  - 提供了一些免费的 slides：
  - 他个人网站上的，新一点：[2016 Short Course Notes – AICDESIGN.ORG](https://aicdesign.org/2016-short-course-notes-2/)
  - 他大学网站上的，多一点：[Phillip Allen--Professor (gatech.edu)](https://pallen.ece.gatech.edu/00courses.html)
- video：
  - 个人网站上有[售](https://aicdesign.org/product-category/academic-courses/)他亲自讲解的书每章的 course，$45 一章，不便宜，网上找不到相关资源。也有更面向[产业界](https://aicdesign.org/product/design-procedures-for-analog-integrated-circuits/)一点的课，更贵
  - Bilibili 上东南大学吴金老师的网课（有两个版本，老版本更深更全）可以参考，网课不像书本往往直接给出一个电路图，来进行“逆向”分析，网课会讲述电路的“正向”设计思路，即这个电路是怎么思考产生的。在 eetop 上有配套 slide 可以下载。所以说看书和上课都很重要，不可能看完四本书就无师自通的 ⭐⭐⭐⭐

### Ali Hajimiri

线性时变相噪模型提出者捏，强的很捏，不过这里不放 RF 的东西捏。

- book/slide/solution
  - 网站上有 [Resources - CHIC (caltech.edu)](https://chic.caltech.edu/links/)，不过模拟 IC 的书 Hajimiri 还没写完，是草稿
- video
  - Bilibili 上有转载，Hajimiri 的视频算是高质量视频中比较新的了，推荐观看 ⭐⭐⭐⭐⭐

### Boris Murmann

Murmann 在 2023 年从 Stanford 跳槽到夏威夷大学去了，不知道为什么。在夏威夷大学没开高等模集的课，开了一个开源 EDA 模集设计课。其他的可以看看 [Boris Murmann: GitHub](https://github.com/bmurmann)，因为这个老师相对年轻，GitHub 用得很多。

- book
  - *Systematic Design of Analog CMOS Circuits Using Pre-Computed Lookup Tables* ⭐⭐⭐
- slide
  - Stanford EE214B, *Advanced Analog Integrated Circuit Design*. 我目前网上搜到的最新版本是 Winter 2017-18 ⭐⭐⭐⭐ 网课视频找不着

### R. Jacob Baker

- book
  - Baker 总体的研究领域以及一本比较新的书 *CMOS Circuit: Design, Layout, and Simulation* 都算是全定制 CMOS 设计，有数字/混合信号的部分，不过 ADPLL 之类的章节倒是在“初等”模拟设计中比较少见的，可以在看完 Razavi CMOS 中关于传统 PLL 介绍后，作为一个入门性质的补充。其 ADDA 相关章节也可供入门参考。
- slide/video
  - [R. Jacob Baker's courses](https://cmosedu.com/jbaker/courses/courses.htm) 可参考，目前公开的最新资源是 [2020 模集](https://www.cmosedu.com/jbaker/courses/ee420_ecg620/s20/lec_ee420_ecg620.htm) 和 [2016 高等模集](https://www.cmosedu.com/jbaker/courses/ecg720/s16/lec_ecg720.htm)

### Gray & Sansen & Kenneth Martin

todo

### MIT / UC Berkeley

[MIT OpenCourseWare](https://ocw.mit.edu/search/?q=Analog+Integrated+Circuits) 的问题是内容非常老，虽然 PPT 啥的质量都是极高的，耐不住 2000 左右的内容。

UCB 的 EE140/240 相对好一些，大概 2010 年左右的视频。（不过画质看上去像是 2000 年的）

### FDU

两级运放、唐长文差分运放

### THU

《现代模拟集成电路设计》孙楠

### (Ultra) Low-Voltage Design

一些（超）低压和亚阈值的书，改天再整理。主要是想看一下 sub-1V / 0.7V 左右的模拟电路设计（不是射频电路）

- Sub-threshold Design for Ultra Low-Power Systems
- Analog Building Blocks for Low Voltage Applications
- Extreme Low-Power Mixed Signal IC Design: Subthreshold Source-Coupled Circuits
- Design of CMOS Analog Integrated Circuits and Systems
- Low-Power Analog Techniques, Sensors for Mobile Devices, and Energy Efficient Amplifiers
- Low-Power CMOS VLSI Circuit Design
- CMOS Analog Design Using All-Region MOSFET Modeling
- Low-Voltage CMOS Log Companding Analog Design
- Low-Voltage CMOS Operational Amplifiers: Theory, Design and Implementation
- Ultra-Low Power Application-Specific Integrated Circuits for Sensing
- Ultra-Low Power Integrated Circuit Design
- https://www.scribd.com/document/43005861/10-1-1-112
- https://www.scribd.com/document/40733019/Low-Voltage-LowPower-AnalogComs-Course

### Others

[Home | Solid State Circuits Society(SSCS) (ieee.org)](https://resourcecenter.sscs.ieee.org/)

[带隙基准已经仿出了基准电压，测出了温度系数，psrr，还要做什么？ - 知乎](https://www.zhihu.com/question/59563077)

[射频方向的修课建议 v1.2 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/459066672)



