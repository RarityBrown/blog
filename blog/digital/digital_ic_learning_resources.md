# Digital IC Learning Resouces

- 虽然大概率以后就是做 analog 的了，但是和 digital 因电源时钟离不开 analog 类似，analog 因接口离不开 digital，所以也得学习啊
- 国内高校普遍使用 *Digital Integrated Circuit: A Design Perspective* 这本又老又底层的书，对于 Verilog 和 Architecture 的内容介绍几乎为零，从现代的角度看与其说是 design perspective 的，不妨说是 EDA perspective 的
- 建议的 prerequisite 和 EECS 151 一致：数电、计组，也非常建议考虑用 AI 辅助学一学 Verilog 基础的语法
- 本文主要介绍的是数字前端。如果有空可能会放一些数字后端的东西，不过这个似乎也是 EDA perspective 的东西，没有什么“知识”

## Courses

- EECS 151/251A by John Wawrzynek, UC Berkeley（BiliBili 上有转载）
- ELEC 4200 by Ujjwal Guin, Auburn University (顺带一提，Google 联想 Tim Cook 是校友，这学校感觉很不出名啊，也是因为 Google 到 slides 后一看内容感觉很好才发现的)

## Books

EECS 151/251A 第一节课就提到，没有特别适用的书，*Digital Design and Computer Architecture* 太浅而 *A Design Perspective* 太底层。另一个国内比较主流的选择是 *Advanced Digital Design with the Verilog HDL*，我总体读下来感觉代码有得挺好，但也有部分 HDL 代码存在不可综合等问题。不过总体而言还是比前两本书适合不少了。

总体而言建议的教科书是：

|                                                           | HDL              | 英/中文版 PDF          | 英文版出版年份 |
| --------------------------------------------------------- | ---------------- | ---------------------- | -------------- |
| Digital Design and Computer Architecture, RISC-V edition  | Verilog and VHDL | 原版；非 RISC-V 版     | 2021           |
| Digital Design: A Systems Approach                        | Verilog or VHDL  | 扫描版 or 原版；扫描版 | 2012           |
| Advanced Digital Design with the Verilog HDL, 2nd edition | Verilog          | 扫描版；扫描版         | 2010           |
| Digital Logic Circuit Analysis and Design, 2nd edition    | VHDL             | 找不到；无翻译         | 2020           |


这些教科书（几乎）不涉及晶体管级而且不仅仅介绍 HDL 语法。

可参考的资料是一些比较新的书（2010 年以后出版）：

- [Digital VLSI Design with Verilog: A Textbook from Silicon Valley Polytechnic Institute](https://link.springer.com/book/10.1007/978-3-319-04789-8) by John Michael Williams
- [FPGA-Based Prototyping Methodology Manual](https://www.synopsys.com/company/resources/synopsys-press/fpga-based-prototyping-methodology-manual.html) by Synopsys
- [FPGA Prototyping by SystemVerilog Examples: Xilinx MicroBlaze MCS SoC Edition](https://www.wiley.com/en-us/FPGA+Prototyping+by+SystemVerilog+Examples%3A+Xilinx+MicroBlaze+MCS+SoC+Edition-p-9781119282662) by Pong P. Chu

以及一些国内的书：

- 数字 IC 设计入门
- 数字系统设计与 Verilog HDL

还有一本比较有特色的书：

Designing Video Game Hardware in Verilog


## 一些其他资源

一些刷题网站：

- https://verilogoj.ustc.edu.cn/oj/
- HDLBits
- 牛客


一些 GitHub 大学资源：

- https://github.com/hustrlee/HUST-Verilog-Course


一些知乎资源：

- https://www.zhihu.com/question/21892919
- https://www.zhihu.com/question/54815861
- https://www.zhihu.com/question/403640698


一些工具资源

- [StarVision PRO (concept.de)](https://www.concept.de/StarVision.html)
- https://www.sigasi.com/
- https://github.com/Digital-EDA/Digital-IDE

