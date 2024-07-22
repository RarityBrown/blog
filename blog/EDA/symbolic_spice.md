# Symbolic SPICE / Symbolic circuit analysis

为什么会突然想到写这个嘞，因为写 [Wilson 电流镜](../analog-subcircuits/Wilson_current_mirror.md) 的时候看 Gray 英文版 273 页看烦了，觉得交流小信号下都是 KCL + KVL + 元件特性 的线性方程组，如果可以自动提取出来，然后用 MATLAB 的 symbolic toolbox 自动解出解析解就方便了。比如在网络的某节点加一个理想 $V_{test}$ ，可以自动求出 $I_{in}$ ，这样（小信号）电阻就有了。

随后就搜了一下，发现基于 MATLAB 的有 SCAM，我看这个领域总体而言挺早就有了，70 年代 SPICE 发布，90 年代初我看就有讨论 symbolic SPICE 的文章了，简直难以想象，Win95 都没发布嘞😂。中文这个大概翻译成“符号化电路仿真”或者“符号电路分析”之类的（symbolic 这个词确实是不好翻译，后文直接用 symbolic），中文互联网相关的内容极少，有也是论文之类的。

然后搜索了一下目前还存在网站和下载途径的软件，整理了一个表格供参考，还有部分没填的栏，等我有空试一试。

| Application                                                  | Developer                                               | Platform               | First release | Latest release                 | License                | Comment                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------- | ---------------------- | ------------- | ------------------------------ | ---------------------- | ------------------------------------------------------------ |
| [SCAM](https://lpsa.swarthmore.edu/Systems/Electrical/mna/MNA6.html) | Erik Cheever, Swarthmore College                        | MATLAB                 | 2003          | 2019                           | MIT                    | link on MATLAB webpage is the older version which don't support controlled source |
| [ELABorate](https://github.com/NicklasVraa/ELABorate)        | Nicklas Vraa, Aarhus University (His bachelor's thesis) | MATLAB                 | 2023          | 2023                           | GPL-3.0                |                                                              |
| [SNAP](https://www.radio.feec.vutbr.cz/snap/)                |                                                         | Windows                |               | 3.2, September 2016            | free for noncommercial |                                                              |
| [SLiCAP](https://analog-electronics.tudelft.nl/slicap/slicap.html) | Anton J.M. Montagne, TU Delft                           | MATLAB / Python+Maxima |               | Jan. 2024                      | CC BY-NC-SA 4.0        | [Structured Electronics Design](https://analog-electronics.tudelft.nl/index.html) |
| [SapWin](http://www.prodid.it/Sapwin4/)                      | University of Florence                                  | Windows                |               | 4.0, Build 0.65, November 2019 | CC BY-NC-SA 4.0        |                                                              |
| [QSapecNG](https://qsapecng.sourceforge.net/)                |                                                         | Windows, Linux, Mac    | 2010?         | <2018                          | GPL-3.0                | It comes as continuation of SapWin for Windows, in order to give to the project a full compatibility on other platforms. |
| [Lcapy](https://github.com/mph-/lcapy)                       |                                                         | Python                 | 2014?         | 1.21, 2024                     | LGPL-2.1               |                                                              |
| [Symbolic Spice with Maxima](https://sourceforge.net/projects/symbolic-spice-with-maxima/) |                                                         | Maxima                 |               | 2022                           |                        |                                                              |
| Analog Insydes                                               |                                                         | Mathematica            |               |                                |                        | [sigma delta66 / 固推铁球](https://www.zhihu.com/question/643505598/answer/3391307974)老师的导师的作品 |
| [SystemModeler](https://blog.wolfram.com/2014/08/21/wolfram-systemmodeler-in-electrical-engineering-courses/) | Wolfram                                                 | Mathematica            |               |                                |                        |                                                              |
| [TINA - Symbolic Analysis](https://www.tina.com/symbolic-analysis/) |                                                         | TINA                   |               |                                | Proprietary            |                                                              |
| [AICE](https://aice.sjtu.edu.cn/)                            | SJTU                                                    | Web                    |               |                                |                        |                                                              |

too old/new to be listed: [Symbolic-Spice](https://github.com/eliot-des/Symbolic-Spice), [Symbolic SPICE](https://willowelectronics.com/symbolic-spice/symbolic-spice-application-notes/), CircuitNAV, XFUNC

1995 年的一篇综述 [Symbolic circuit analysis: an overview](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=510249) 其中的很多软件已经消失在历史长河中了，希望现代化的搜索引擎和代码托管平台可以在这方面和重复功能的代码方面做出贡献。





## 功能与使用体验

先放一个表：

| Application                                                  | Platform               | GUI  | Controlled Sources (VCVS...) | Driving-Point Function (input/output impedance) & Transfer Function | LC s-parameter |      | Comment |
| ------------------------------------------------------------ | ---------------------- | ---- | ---------------------------- | ------------------------------------------------------------ | -------------- | ---- | ------- |
| [SCAM](https://lpsa.swarthmore.edu/Systems/Electrical/mna/MNA6.html) | MATLAB                 | n    | y                            | yy                                                           | y              |      |         |
| [ELABorate](https://github.com/NicklasVraa/ELABorate)        | MATLAB                 |      |                              |                                                              |                |      |         |
| [SNAP](https://www.radio.feec.vutbr.cz/snap/)                | Windows                | y    |                              |                                                              |                |      |         |
| [SLiCAP](https://analog-electronics.tudelft.nl/slicap/slicap.html) | MATLAB / Python+Maxima |      |                              |                                                              |                |      |         |
| [SapWin](http://www.prodid.it/Sapwin4/)                      | Windows                | y    |                              |                                                              |                |      |         |
| [QSapecNG](https://qsapecng.sourceforge.net/)                | Windows, Linux, Mac    | y    |                              |                                                              |                |      |         |
| [Lcapy](https://github.com/mph-/lcapy)                       | Python                 | n    |                              |                                                              |                |      |         |
| [Symbolic Spice with Maxima](https://sourceforge.net/projects/symbolic-spice-with-maxima/) | Maxima                 |      |                              |                                                              |                |      |         |
| Analog Insydes                                               | Mathematica            |      |                              |                                                              |                |      |         |
| [SystemModeler](https://blog.wolfram.com/2014/08/21/wolfram-systemmodeler-in-electrical-engineering-courses/) | Mathematica            |      |                              |                                                              |                |      |         |
| [TINA - Symbolic Analysis](https://www.tina.com/symbolic-analysis/) | TINA                   |      |                              |                                                              |                |      |         |
| [AICE](https://aice.sjtu.edu.cn/)                            | Web                    |      |                              |                                                              |                |      |         |

测试例子：

|      |                        例1：输出阻抗                         |                        例2：传递函数                         |
| ---- | :----------------------------------------------------------: | :----------------------------------------------------------: |
|      | flipped source follower 的低频小信号输出电阻（对于人工计算而言存在电流成环的情况） | common source 的频响特性（对于人工计算而言存在 $C_{GD}$ 的前馈通路） |
|      | ![image](https://github.com/user-attachments/assets/7f3ede06-8267-4b6f-9d9b-c8108bd787d7) |                                                              |
| 答案 | $\dfrac{1}{r_{out}}=1/r_{o1}+g_{m1}(1+(g_{m2}+g_{mb2})r_{o2})\approx g_{m1}g_{m2}r_{o2}$ |                                                              |
|      |                                                              |                                                              |

