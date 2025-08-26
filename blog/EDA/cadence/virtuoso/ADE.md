# ADE & Spectre

## ADE (Analog Design Environment)

建议使用 ADE Explorer & ADE Assembler，而不要再使用 ADE L 和 ADE XL 了：

|                                                              |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![image](https://github.com/user-attachments/assets/ca0107d6-16dc-47d2-8a3c-3aa187b011f4) | ![image](https://github.com/user-attachments/assets/70da136f-bc0c-4ab7-8ff2-86257982e43d) |

类比软件开发，ADE 是 IDE，而 Spectre 是 compiler

非常建议您阅读[干饭睡觉真君](https://www.analog-life.com/2025/02/improve-simulation-efficiency-with-cadence-maestro/)对于 ADE Explorer & ADE Assembler 的详细介绍。对于一些技巧性的内容可以参考[电波一号](https://zhuanlan.zhihu.com/p/372495688)的介绍。

### 仿真数据

在 Virtuoso 中讨论“保存仿真”时，有三层含义：

1. 保存 **Spectre** 的仿真数据，是针对于电路的
2. 保存 **ADE** 的仿真结果，是针对于每次仿真的
3. 保存或另存为 **Maestro** 的 Cellview：[ADE Explorer Setup - Save Now and Reuse Later!](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuoso-video-diary-reusing-ade-explorer-test-setup-through-save-and-export)


#### ① Spectre 仿真数据对于电路而言

- 默认保存
  - 节点电压
- 默认不保存 
  - Terminal 上的电流
    - `IS("/PM0/S")`
    - 需要 Add Outputs 中选择添加 `Signal`，不然公式报错
  - 器件 DC operating point
    - `OS("/PM0" "vth")`
    - 需要 Add Outputs 中选择添加 `OP Parameters`，不然公式报错

#### ② ADE 仿真结果对于每次仿真而言

- ADE Explore
  - 默认覆盖每次仿真结果
  - 使用 [Results->Save](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuosity-exploring-histories) 来手动保存某次 ADE 仿真结果；使用 [Results->Select](https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/36638/saving-importing-exporting-the-ade-results) 查看之前保存的仿真结果
  - 无法保存仿真设置，需要保存仿真设置应使用 ADE Assembler
- ADE Assembler
  - 默认保存最新的 10 组数据 [ref](https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/36638/saving-importing-exporting-the-ade-results)
  - 使用 "鼠标右键->lock" 实现某组数据不覆盖



#### 仿真数据默认设置、保存、导出与导入


在跑大仿真前的 check-list

1. 需要的信号是否保存，不需要的信号是否不保存？
  1. 如果是 `allpub` 评估是否放得下？
  2. 如果是 `lvlpub` 评估层次是否合理 - 特别是在前后仿切换的时候
  3. 如果是 `select` 是否都存了？
2. 是否进入 ADE Assembler 仿真，以自动保存仿真结果？
3. 磁盘空间是否足够？`placeholder_file_reserved_for_deletion_in_case_of_emergency1.bin` 文件准备。
4. CPU 是否足够？
   1. CPU 总体是否足够？
   2. 是否有 Job Setup 并行度阻止仿真
   3. ADE Assembler 中是否有老任务 suspended 阻止仿真？
5. 是否保存了 ADE 的状态和原理图的状态，以便于在 virtuoso 无响应时 xkill 而不丢失？
6. 是否保存上次仿真的结果？
7. 是否跑过短时间的 tran 验证？例如 1ns？
8. 是否跑过一个扫描点的验证？
9. 是否使用 [Run Preview](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuoso-video-diary-run-point-selection-wysiwyg) 检查仿真设置？


Virtuoso 中仿真数据默认存储位置由 asimenv.startup projectDir 这一环境变量设置，默认位置是 `~/simulation`。对于如何修改这一环境变量，以及如何把波形图背景设为白色，可以参考 [cdsenv](SKILL.md#cdsinit-and-cdsenv) 这篇文章。

在仿真结束后，Virtuoso Visualization & Analysis XL 会自动弹出结果，当我们把图中的每一条线都删除后，留下空白的 Visualization & Analysis XL 窗口：


|                     Open Results                             |              tran - 选择 nodes                               |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![image](https://github.com/user-attachments/assets/fa230287-0063-463e-890d-e0f3f3e5a34a) | ![image](https://github.com/user-attachments/assets/6a9271e9-1e8c-42ac-b5c7-3d19eb4f9792) |


通过 File - Open Results - psf 可以打开上一次仿真的所有保存了的数据。在 load psf 文件后，在 tran 文件夹找到相应的信号节点，双击即可查看波形。



<!-- 例如 Virtuoso tran 仿真默认保存节点电压，不默认保存支路电流，所以如果在 tran 仿真前不添加任何信号，psf database 仍可以中找到每个节点的电压，但是没有电流。 -->


todo: 如何自动保存多个 psf 文件？


to ref:

- [Cadence Waveform Import and Export - Applied Optics Wiki](https://optics.eee.nottingham.ac.uk/wiki/Cadence_Waveform_Import_and_Export)
- [你们如何在不崩溃的情况下读取长反仿真的结果 virtuoso ： r/chipdesign](https://www.reddit.com/r/chipdesign/comments/1goul9p/how_do_you_guys_read_result_from_long_trans/)
- [virtuoso中保存仿真数据_virtuoso仿真数据怎么保存-CSDN博客](https://blog.csdn.net/Cixil/article/details/117400442)
- [Virtuoso 波形不更新及 VIVA XL 字体问题-张长瑞-FastEDA](https://www.fasteda.cn/post/7.html)
- [保存所有仿真点的数据_virtuoso怎么保存仿真的波形图-CSDN博客](https://blog.csdn.net/CarrieVAE/article/details/115729273)
- [在 Cadence 中保存仿真波形 |电子论坛](https://www.edaboard.com/threads/saving-simulation-waveform-in-cadence.44856/)
- [使用 Tcl 在 AMS 仿真中更有效地保存信号](https://semiengineering.com/use-tcl-to-save-signals-more-efficiently-in-ams-simulations/)
- [cadence virtuoso如何将波形转为vec文件？ - 知乎](https://www.zhihu.com/question/607405184)
- [芯片设计小技巧（3）——仿真中的设置的小tips - 知乎](https://zhuanlan.zhihu.com/p/669822724)
- [Virtuoso在仿真过程中查看波形（瞬态仿真 tran仿真） - 哔哩哔哩](https://www.bilibili.com/opus/872227327212257282)
- [Cadence Virtuoso 将时域波形保存为波形文件并在仿真中使用 – Analog-Life](https://www.analog-life.com/2023/05/save-time-domain-waveforms-as-waveform-files-and-use-them-in-simulations/)
- [6200b77d5e03f.pdf](https://www.boardchain.cn/Uploads/2022-02-07/6200b77d5e03f.pdf)
- [Spectre Tech Tips: Spectre APS Save Overview - Part 2 - Analog/Custom Design - Cadence Blogs - Cadence Community](https://community.cadence.com/cadence_blogs_8/b/cic/posts/spectre-tech-tips-spectre-aps-save-overview---part-2)
- [将图形波形保存到 ADE-XL 视图中，就像频谱状态视图一样 - 定制 IC 设计 - Cadence Technology 论坛 - Cadence 社区](https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/48458/save-graphical-waveforms-into-ade-xl-views-just-like-a-spectre-state-view)
- [Virtuosity：在Virtuoso可视化和分析中阅读矢量文件 - 定制IC芯片设计 - Cadence Blogs - Cadence Community](https://community.cadence.com/cadence_blogs_8/b/ic-cn/posts/virtuosity-virtuoso)

### 常见 bug

所有 "Save" checkbox 都 check 了，但是只有 `signal` 类型的曲线可以绘出，`expr` 的曲线无法绘制。同时有概率报错：

```
ERROR (WIA-1175): Cannot plot waveform signals because no waveform data is available for plotting.
One of the possible reasons can be that 'Save' check box for these signals are not selected in the Outputs Setup pane. Ensure that these check boxes are selected before you run the simulation.
```

![image](https://github.com/user-attachments/assets/68c3d8ab-794f-4f55-9af0-5470cba67a77)

解决方案：这是将 `IT("/PM2/S")` 函数的变量名设置成 `/PM2/S` 后产生的 bug，将 Name 字段中的 `/PM2/S` 删去或改成其他任意字符。如果对于电压信号的情形，可以 uncheck "Save" checkbox 来看似绕过这个 bug，但是这不解决根本问题。


## Spectre 仿真类型

### 背景

https://community.cadence.com/cadence_blogs_8/b/cic/posts/spectre-tech-tips-accuracy-101

### 万物的开山: `dc` simulation

modified nodal analysis

### `dc` 的衣钵: `tran` simulation

- 步长 (time step parameter)
  - Spectre 一般情况下会自动动态的设置 `tran` 仿真的步长：例如在信号变化幅度较大时缩小 step；当电路进入类似于稳态，没什么信号波动时增大 step
  - `step`:
  - `maxstep`: 本次 `tran` 所允许的最大步长。当我们不希望 spectre 在电路进入稳态后 step 越来越大，而一直小于一个最大 step 值
  - `minstep`: 
- param
  - tran noise
    - isnoisy


### 小信号的王者: `ac` simulation

### `ac` 的亲戚: `stb` simulation

Striving for small-signal stability - Loop-Based and Device-Based Algorithms for Stability Analysis of Linear Analog Circuits in the Frequency Domain

### `sp`

### Spectre 在模拟仿真领域超越 Hspice 的开端: `pss` simulation

### Spectre Fast SPICE, RF SPICE

- *Getting The Most Out Of Spectre*
  - Getting The Most Out Of Spectre APS
  - Getting the Most Out of Spectre X
  - [Getting the Most out of Spectre X-RF and APS-RF - YouTube](https://www.youtube.com/watch?v=MwgguyM_kP8)

## Real-time Tuning, Local and Global Optimization

基本概念：A PCell, short for parameterized cell, is a feature in EDA tools that lets designers create components whose structure depends on specific parameters. For example, you could have a transistor PCell where you can adjust its length and width, and the tool automatically generates the layout based on those settings. This makes it easier to reuse and customize designs without starting from scratch. A PCell is a specific kind of device where there is a schematic view (or symbol view) where the connectivity changes based on a parameter?

https://youtu.be/RG5CjoPcHvs?t=1058


### Verilog(AMS) & Verilog-A



## 加快 ViVA 画图速度

- `ViVA -> Options -> Fast Viewing Support`
- PSF XL (Real-Time Signal Format, RTSF)
- https://blog.eetop.cn/blog-6503-27767.html

## 加快仿真速度 (ADE 和 Spectre 中间的桥梁)

### 通过并行，加快仿真速度

#### Job Policy

![image](https://github.com/user-attachments/assets/c5a9fc80-0a1e-4097-b4a3-469090ad1411)

- Job Policy Name: 可以将自己的 Job Policy 保存，例如保存为 `My_jobpolicy`，可以通过 [cdsenv](SKILL.md#cdsinit-and-cdsenv) 来实现每次启动 Virtuoso 时的自动设置。
  - 如果使用 Maestro 下的 LSCS 则需要设置两个 rule，见绿框
- **Setup**
  - Job Control Mode
    - LSCS (绿框部分): Large-Scale Compute Server, IC6.1.8 引入。一般是多机组服务器使用，常见于公司。[3](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuosity-part-1-let-s-have-fun-with-ade-debugging)
    - ICRP (蓝框部分)
  - Max. Jobs
    - 和 CPU units 建议设置为一样。这个设置的上限不应多于 logical CPU cores (更为保守的做法是不多于 physical CPU cores)
    - 可使用 `lscpu | awk '/Core\(s\) per socket/{cores=$4} /Socket\(s\):/{sockets=$2} END{print cores * sockets}'` 来获取 physical CPU cores 数量
    - 关于 logical or physical CPU cores 和 hyperthreading 的内容，可参见 [1](https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/40006/aps-better-hyperthreading-on-or-off-on-the-machine) [2](https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/16464/hardware-for-best-simulation-performance) [3](https://community.cadence.com/cadence_blogs_8/b/cic/posts/spectre-optimizing-spectre-aps-performance) 
- **Timeouts (in Secs.)**
  - 保持默认

#### 同时前后仿 (同时仿真多个 config)

ADE Assembler -> Global variable 右键 -> add config sweep 

参考 [1](https://zhuanlan.zhihu.com/p/6580714389)

### 直接加快串行仿真速度

- High Performance Simulation
- 关闭保存所有电压节点的数据，手动选择需要保存的电压节点
  - 待研究（目前看下来好像在大于某特定值的情况下，画图速度会严重降低，不知道是和什么硬件设置相关）

### 其他方式

#### 为不同的仿真组设置不同的 tran 仿真时间

背景介绍：

- 例如，对一指数 VCO 进行 tran 仿真，在 Vctrl=0V 时 VCO 频率约为 1kHz、在 Vctrl=0.5V 时频率约为 1MHz、在 Vctrl=1V 时频率约为 1GHz
- 又例如，对某 osc 的温度敏感度进行 tran 仿真，在 Temperature=-40℃ 时 osc 频率约为 1kHz、在 Temperature=125℃ 时频率约为 1MHz

此时如果我们为所有情况设置相同的 tran 仿真时长，为确保 1kHz osc 有 10 个周期时，tran 仿真时长应设为 10ms，此时 1MHz 和 1GHz osc 因为信号频率高，tran 仿真中的每一步 step 小，仿真 10ms 所需的时间会远大于 1kHz 的 osc（从 SPICE 原理来说大约是等比例大于，例如 1kHz osc 仿真 10ms 需要 1 分钟，则 1MHz osc 仿真 10ms 需要 1000 分钟）。此时，仿真 10ms 对于高频信号不仅不会获得更多电路信息，反而会严重拖慢 tran 仿真速度。

所以希望为不同的仿真设置合适的 tran 时长，例如，对于上文温度的例子，希望使用 tran 仿真时长 $\text{Time}=0.01\cdot\exp(-0.03\cdot\text{Temperature})$ 由这一函数来大致确定。

介绍完背景后，以前文温度的例子为例，介绍在 Virtuoso ADE Explorer 中的具体实现方法：

![image](https://github.com/user-attachments/assets/200b53f0-b6b1-4fd0-936c-6c3489102719)

1. 在 Design Variables 中创建一个变量，例如上图中命名为 `Tran_Time`
2. 在 Corners 中设置温度范围，例如 `-40:5:125` 表示从 -40℃ 扫到 125℃，步长为 5℃
3. 在 Corners 中设置前文提到的 tran 仿真时长关于温度的函数 `0.01*exp(-0.03*temp)`。在 Virtuoso 中 `temp` 是温度的默认变量名 [ref](https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/52850/when-setting-temperature-as-a-design-global-variable-it-is-called-an-unknown-parameter-and-a-simulation-error-occurs)
4. 在 tran Analysis 的设置界面，将仿真时间设为 `VAR("Tran_Time")`，`VAR` 在此处表示将 variable 转换为 ADE 可以接受的数字
5. 查看仿真结果：

![image](https://github.com/user-attachments/assets/cd7c18aa-c645-45f3-abc8-171aecaaac1e)


#### 

- 启动时粗略仿真，正常工作时精细仿真
  - APS: https://m0nkey.cn/2020/03/experience-sharing-with-spectre-x-spectre-191-simulator/
  - Spectre X: https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/47915/dynamic-tolerance-with-spectre-x
- isnoisy
