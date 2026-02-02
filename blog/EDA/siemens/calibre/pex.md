



## PEX

### calibre view setup



这个对话框用于把 Calibre xRC（PEX）的结果 back‑annotate 进 Virtuoso 库，生成可在 ADE 中仿真的 calibre 视图（含器件与寄生）。默认会弹出，让你确认映射文件、视图类型、端口策略、放置方式等。

如果意外关闭了这个窗口，有两个方式可以调出：

- 回到 Virtuoso Layout Editor 窗口的菜单栏中 `Calibre ⇒ Setup ⇒ Calibre View…` 。这一步会重新弹出 Calibre View Setup 窗口。   ref: [1](https://miscircuitos.com/why-back-annotating-is-so-important-in-circuit-design/) [2](https://wiki.to.infn.it/vlsi/workbook/verification/calibre/files)
- 在 Virtuoso CIW 中输入 `mgc_rve_create_cellview()` 函数


#### 选项介绍


| 选项                          | 设置                                                        | 解释 |
| :---------------------------- | :---------------------------------------------------------- | ----------------------------- |
| CalibreView Setup File   |                                                             |  |
|  | |  |
| CalibreView Netlist File |                                                             | 指定 CalibreView 使用的网表来源（一般来说即 PEX 抽取完成后的 `cellname.pex.netlist` 文件） |
| Output Library           |                                                             |  |
| Schematic Library        |                                                             |  |
|  | |  |
| Cellmap File             |                                                             | 将 Calibre 识别到的器件/寄生映射为 PDK 的符号与版图单元名。即把提参出来的电阻、电容、二极管映射到库里的符号 cell |
| Log File                 |                                                             | 遇到端口/器件缺失时先看这份日志与 CIW transcript |
|  | |  |
| Calibre View Name        |                                                             |  |
| Calibre View Type        | maskLayout; schematic                                       | 以版图层对象为主的视图（更贴近几何/掩膜布局），在某些流程或调试用到；<br />生成可在 Virtuoso 打开的含寄生器件的 schematic view，便于 Spectre/ADE 直接仿真。这是做后仿真的主流选择 |
| Create Terminals         | If matching terminal exists on symbol; Create all terminals |  |
| Preserve Device Case      |                                                             |  |
| Execute Callbacks         |                                                             |  |
| Suppress Notes            |                                                             |  |
| Reset Properties         | m=1                                                         |  |
|  |  |  |
| Magnify Instances By     | 1                                                           | 仅影响生成视图中的图形尺度，便于观察密集器件，不改变电气参数本身 |
|  |  |  |
| Device Placement         | Layout Location; Arrayed                                    |  |
| Parasitic Placement      | Layout Location; Arrayed                                    |  |
| Show Parasitic Polygons   |                                                             |  |
|  | |  |
| Open Calibre CellView    | Read-mode; Edit-mode; Don't Open                            |  |
| Generate SPECTRE Netlist  |                                                             |  |
|  | |  |
| Always Show Dialog        |                                                             |  |
