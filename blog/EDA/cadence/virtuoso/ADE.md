# ADE & Spectre

## ADE (Analog Design Environment)

建议使用 ADE Explorer & ADE Assembler，而不要再使用 ADE L 和 ADE XL 了：

|                                                              |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![image](https://github.com/user-attachments/assets/ca0107d6-16dc-47d2-8a3c-3aa187b011f4) | ![image](https://github.com/user-attachments/assets/70da136f-bc0c-4ab7-8ff2-86257982e43d) |

类比软件开发，ADE 是 IDE，而 Spectre 是 compiler

### 仿真数据

#### 默认设置

- 默认保存
  - 节点电压
- 默认不保存 
  - 支路电流
    - `IS("/PM0/S")`
    - 需要 Add Outputs 中选择添加 `Signal`，不然公式报错
  - 器件 DC operating point
    - `OS("/PM0" "vth")`
    - 需要 Add Outputs 中选择添加 `OP Parameters`，不然公式报错

#### 仿真数据导出与导入


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

### 万物的开山: `dc` simulation

modified nodal analysis

### `dc` 的衣钵: `tran` simulation

- 步长 (time step parameter)
  - Spectre 一般情况下会自动动态的设置 `tran` 仿真的步长：例如在信号变化幅度较大时缩小 step；当电路进入类似于稳态，没什么信号波动时增大 step
  - `step`:
  - `maxstep`: 本次 `tran` 所允许的最大步长。当我们不希望 spectre 在电路进入稳态后 step 越来越大，而一直小于一个最大 step 值
  - `minstep`: 

### 小信号的王者: `ac` simulation

### `ac` 的亲戚: `stb` simulation

Striving for small-signal stability - Loop-Based and Device-Based Algorithms for Stability Analysis of Linear Analog Circuits in the Frequency Domain

### sp

### Spectre 在模拟仿真领域超越 Hspice 的开端: `pss` simulation






## 加快仿真速度 (ADE 和 Spectre 中间的桥梁)

### 通过并行，加快仿真速度

![image](https://github.com/user-attachments/assets/ff5b9ea0-56b7-4378-9cf8-2e94e66c9052)

- Max. Jobs 和 CPU units 建议设置为一样
  - 这个设置的上限不应多于 logical CPU cores (更为保守的做法是不多于 physical CPU cores)
  - 可使用 `lscpu | awk '/Core\(s\) per socket/{cores=$4} /Socket\(s\):/{sockets=$2} END{print cores * sockets}'` 来获取 physical CPU cores 数量
  - 关于 logical or physical CPU cores 和 hyperthreading 的内容，可参见 [1](https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/40006/aps-better-hyperthreading-on-or-off-on-the-machine) [2](https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/16464/hardware-for-best-simulation-performance) [3](https://community.cadence.com/cadence_blogs_8/b/cic/posts/spectre-optimizing-spectre-aps-performance) 
- 可以将自己的 Job Policy 保存，例如保存为 `My_jobpolicy`，可以通过 [cdsenv](SKILL.md#cdsinit-and-cdsenv) 来实现每次启动 Virtuoso 时的自动设置。
- 其他一些选项，比如 IC6.1.8 引入的 LSCS (Large Scale Compute Server) 只有大公司里面才能用得到。[3](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuosity-part-1-let-s-have-fun-with-ade-debugging)

### 直接加快串行仿真速度

