# Symbolic SPICE / Analytical Circuit Analysis / Symbolic Modified Nodal Analysis

为什么会突然想到写这个嘞，因为写 [Wilson 电流镜](../analog-subcircuits/Wilson_current_mirror.md) 的时候看 Gray 英文版 273 页看烦了，觉得交流小信号下都是“KCL + KVL + 元件特性”的线性方程组，如果可以自动提取出来，然后用 MATLAB 的 symbolic toolbox 自动解出解析解就方便了。比如在网络的某节点加一个理想 $V_{test}$ ，可以自动求出 $I_{in}$ ，这样（小信号）电阻就有了。当然也有手动列写 KCL KVL 后 [MATLAB 求解](https://zhuanlan.zhihu.com/p/558561329)的方式，不过如果可以电路图或 netlist 直接出结果那自然更佳。

搜索后发现排在搜索结果首位的是基于 MATLAB 的 SCAM，我看这个领域总体而言挺早就有了，70 年代 SPICE 发布，90 年代初我看就有讨论 symbolic SPICE 的文章了，简直难以想象，Win95 都没发布嘞😂。中文这个大概翻译成“符号化电路仿真”或者“符号电路分析”之类的（symbolic 这个词确实是不好翻译，后文直接用 symbolic），中文互联网相关的内容极少，有也是论文之类的。

整理了一个目前还存在网站和下载途径的软件表格，供参考，还有部分没填的栏，等我有空试一试。

| Application                                                  | Developer                                                    | Platform                                 | First release          | Latest release                 | License                | Comment                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------------------------------- | ---------------------- | ------------------------------ | ---------------------- | ------------------------------------------------------------ |
| [SCAM](https://lpsa.swarthmore.edu/Systems/Electrical/mna/MNA6.html) | Erik Cheever, Swarthmore College                             | MATLAB                                   | 2003                   | 2019                           | MIT                    | link on MATLAB webpage is the older version which don't support controlled source |
| [ELABorate](https://github.com/NicklasVraa/ELABorate)        | Nicklas Vraa, Aarhus University (His bachelor's thesis)      | MATLAB                                   | 2023                   | 2023                           | GPL-3.0                |                                                              |
| [SNAP](https://www.radio.feec.vutbr.cz/snap/)                |                                                              | Windows                                  |                        | 3.2, September 2016            | free for noncommercial |                                                              |
| [SLiCAP](https://analog-electronics.tudelft.nl/slicap/slicap.html) | Anton J.M. Montagne, TU Delft                                | Python+Maxima (MATLAB for older version) |                        | Jan. 2024                      | CC BY-NC-SA 4.0        | [Structured Electronics Design](https://analog-electronics.tudelft.nl/index.html) |
| [SapWin](http://www.prodid.it/Sapwin4/)                      | University of Florence                                       | Windows                                  |                        | 4.0, Build 0.65, November 2019 | CC BY-NC-SA 4.0        |                                                              |
| [QSapecNG](https://qsapecng.sourceforge.net/)                |                                                              | Windows, Linux, Mac                      | 2010?                  | <2018                          | GPL-3.0                | It comes as continuation of SapWin for Windows, in order to give to the project a full compatibility on other platforms. |
| [Lcapy](https://github.com/mph-/lcapy)                       |                                                              | Python                                   | 2014?                  | 1.21, 2024                     | LGPL-2.1               |                                                              |
| [Symbolic Spice with Maxima](https://sourceforge.net/projects/symbolic-spice-with-maxima/) |                                                              | Maxima                                   |                        | 2022                           |                        |                                                              |
| Analog Insydes                                               |                                                              | Mathematica                              |                        |                                |                        | [sigma delta66 / 固推铁球](https://www.zhihu.com/question/643505598/answer/3391307974)老师的导师的作品 |
| [SystemModeler](https://blog.wolfram.com/2014/08/21/wolfram-systemmodeler-in-electrical-engineering-courses/) | Wolfram                                                      | Mathematica                              |                        |                                |                        |                                                              |
| [TINA - Symbolic Analysis](https://www.tina.com/symbolic-analysis/) |                                                              | TINA                                     |                        |                                | Proprietary            |                                                              |
| [AICE](https://aice.sjtu.edu.cn/)                            | SJTU                                                         | Web                                      |                        |                                |                        |                                                              |
| [Symbolic-modified-nodal-analysis](https://github.com/Tiburonboy/Symbolic-modified-nodal-analysis) | Tony Cirineo                                                 | Python                                   | 1988(C version) / 2015 | 2024                           | CC BY-NC-SA 4.0        |                                                              |
| [SymPyCAP](https://github.com/mdodovic/SymPyCAP)             | Matija Dodović, University of Belgrade                       | Python                                   | 2023                   | 2023                           | GPL-3.0                |                                                              |
| [ahkab](https://ahkab.readthedocs.io/en/latest/examples/Symbolic-simulation.html) | Giuseppe Venturini, Polytechnic University of Milan (His undergrad program) | Python                                   | 2013?                  | 2015                           |                        |                                                              |

too old/new to be listed: [Symbolic-Spice](https://github.com/eliot-des/Symbolic-Spice), [Symbolic SPICE](https://willowelectronics.com/symbolic-spice/symbolic-spice-application-notes/), CircuitNAV, XFUNC

可以从中得出一些结论

- 软件多但代码保存和作者交流情况不佳，重复造轮子的情况普遍存在：
  - 1995 年的一篇综述 [Symbolic circuit analysis: an overview](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=510249) 其中的很多软件已经消失在历史长河中了
  - 希望现代化的搜索引擎和代码托管平台可以在这方面和重复功能的代码方面做出贡献。但是如果不摆脱论文导向的话恐怕难，因为学生发文章不太可能说是基于开源项目略微改进，只能说是重造了一个好轮子，有工作量，是 repository 的 owner，好发文章。CS 的 Open Source 则往往不是论文导向的
- 大部分项目都是学生或老师在大学中用于课程教学的代码：对于大型电路 symbolic 解复杂度极高，无法为设计提供有效指导，EDA 公司在这方面兴趣往往不大。如果是学生开发的往往因为学生毕业而废弃，老师开发的项目维护周期会相对长一些
- 大部分基于 MATLAB (Symbolic Math Toolbox), Mathematica, Maxima, Python (SymPy) 等开发，直接使用最优的 symbolic 矩阵算法，无需重复造轮子

搜到三篇比较新的原理和进展方面的文章：[1](https://tiburonboy.github.io/Symbolic-Modified-Nodal-Analysis-using-Python/), [2](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9044395/), [3](https://lpsa.swarthmore.edu/Systems/Electrical/mna/MNA2.html) 分别是介绍 [Symbolic-modified-nodal-analysis](https://github.com/Tiburonboy/Symbolic-modified-nodal-analysis), [Lcapy](https://github.com/mph-/lcapy) 和 [SCAM](https://lpsa.swarthmore.edu/Systems/Electrical/mna/MNA6.html) 工作的。有空的话感觉可以学一学，总算用得到线性代数知识了，做模拟是感觉一点线代都用不到。

## 功能与使用体验

先放一个表：

| Application                                                  | Platform               | GUI  | Controlled Sources (VCVS...) & OPAMP(VCVS with infinite gain) | Driving-Point Function (input/output impedance) & Transfer Function | LC s-parameter | SPICE Netlist Compatible (LTspice etc.) | Comment |
| ------------------------------------------------------------ | ---------------------- | ---- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------------- | --------------------------------------- | ------- |
| [SCAM](https://lpsa.swarthmore.edu/Systems/Electrical/mna/MNA6.html) | MATLAB                 | n    | y?                                                           | yy                                                           | y              | y                                       |         |
| [ELABorate](https://github.com/NicklasVraa/ELABorate)        | MATLAB                 |      |                                                              |                                                              |                |                                         |         |
| [SNAP](https://www.radio.feec.vutbr.cz/snap/)                | Windows                | y    |                                                              |                                                              |                |                                         |         |
| [SLiCAP](https://analog-electronics.tudelft.nl/slicap/slicap.html) | MATLAB / Python+Maxima |      |                                                              |                                                              |                |                                         |         |
| [SapWin](http://www.prodid.it/Sapwin4/)                      | Windows                | y    |                                                              |                                                              |                |                                         |         |
| [QSapecNG](https://qsapecng.sourceforge.net/)                | Windows, Linux, Mac    | y    |                                                              |                                                              |                |                                         |         |
| [Lcapy](https://github.com/mph-/lcapy)                       | Python                 | n    |                                                              |                                                              |                |                                         |         |
| [Symbolic Spice with Maxima](https://sourceforge.net/projects/symbolic-spice-with-maxima/) | Maxima                 |      |                                                              |                                                              |                |                                         |         |
| Analog Insydes                                               | Mathematica            |      |                                                              |                                                              |                |                                         |         |
| [SystemModeler](https://blog.wolfram.com/2014/08/21/wolfram-systemmodeler-in-electrical-engineering-courses/) | Mathematica            |      |                                                              |                                                              |                |                                         |         |
| [TINA - Symbolic Analysis](https://www.tina.com/symbolic-analysis/) | TINA                   |      |                                                              |                                                              |                |                                         |         |
| [AICE](https://aice.sjtu.edu.cn/)                            | Web                    |      |                                                              |                                                              |                |                                         |         |
| [Symbolic-modified-nodal-analysis](https://github.com/Tiburonboy/Symbolic-modified-nodal-analysis) | Python                 |      |                                                              |                                                              |                |                                         |         |
| [SymPyCAP](https://github.com/mdodovic/SymPyCAP)             | Python                 |      |                                                              |                                                              |                |                                         |         |
| [ahkab](https://ahkab.readthedocs.io/en/latest/examples/Symbolic-simulation.html) | Python                 |      |                                                              |                                                              |                |                                         |         |

测试例子：

|      |                        例1：输出阻抗                         |                        例2：传递函数                         |
| ---- | :----------------------------------------------------------: | :----------------------------------------------------------: |
|      | flipped source follower 的低频小信号输出电阻（对于人工计算而言存在电流成环的情况） | common source 的频响特性（对于人工计算而言存在 $C_{GD}$ 的前馈通路） |
|      | ![image](https://github.com/user-attachments/assets/7f3ede06-8267-4b6f-9d9b-c8108bd787d7) |                                                              |
| 答案 | $\dfrac{1}{r_{out}}=1/r_{o1}+g_{m1}(1+(g_{m2}+g_{mb2})r_{o2})\approx g_{m1}g_{m2}r_{o2}$ |                                                              |
|      |                                                              |                                                              |

总体而言，软件无法具有 $g_m>g_{mb}\gg 1/r_o$ 的思路来化简，所以结果往往冗杂而且无法体现数量级。不过这个对于做符号计算的人来说应该挺简单的，只不过需求太少，没有牛人大一统。

### SCAM

Netlist file: `FVF.cir`

```scss
Vt 1 0 v_t
Ro1 1 0 r_o1
Ro2 2 1 r_o2
Gm1 1 0 2 0 g_m1
Gm2 2 1 0 1 g_m2
Gmb2 2 1 0 1 g_mb2
```

MATLAB code:

```matlab
clear
fname='FVF.cir';
scam;
1/expand(simplify(-I_Vt/Vt))
```

Result:

![image](https://github.com/user-attachments/assets/baa7c72e-fd6c-481a-bf49-6efb5b504107)


