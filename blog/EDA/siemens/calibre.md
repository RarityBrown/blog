# Calibre

## General

> https://www.kaixinspace.com/calibre-tips/

```shell
setenv MGC_CALIBRE_DRC_RUNSET_FILE ./.calibre.drc
setenv MGC_CALIBRE_LVS_RUNSET_FILE ./.calibre.lvs
setenv MGC_CALIBRE_PEX_RUNSET_FILE ./.calibre.rcx
# https://sites.google.com/site/yeagerengineering/cadence/calibre
```

in Virtuoso CIW: `setShellEnvVar()`


## DRC

- [Calibre 检查特定规则 DRC 或 Density DRC](https://zhuanlan.zhihu.com/p/1925245051493151687)
- Calibre `DRC Options - Include - Include Rule Statements` 填入 `EXCLUDE CELL cell_name` 忽略部分 instance 后执行 DRC

### Real-time DRC

- https://zhuanlan.zhihu.com/p/161412215
- https://www.kaixinspace.com/calibre-tips/#5

`.bashrc`

```bash
export MGC_CALIBRE_REALTIME_VIRTUOSO_ENABLED=1  # Enables real-time integration
export OA_PLUGIN_PATH=$CALIBRE_HOME/shared/pkgs/icv/tools/queryskl  # Path for OpenAccess plugins
export LD_LIBRARY_PATH=$CALIBRE_HOME/shared/pkgs/icv/tools/calibre_client/lib/64:${LD_LIBRARY_PATH}  # Library paths for 64-bit support
export MGC_CALIBRE_REALTIME_VIRTUOSO_SAVE_MESSENGER_CELL=1  # Saves messenger cells for error handling
export MGC_CALIBRE_SAVE_ALL_RUNSET_VALUES=1  # Optional: Saves all runset configurations
```

### Speed-up DRC

todo

- Enable Multi-Threading (MT/MTflex)
  - In batch, add ``-turbo <N>`` to match physical CPU cores (not hyperthreads). In Interactive, enable Turbo/MT and set core count. If you want Calibre to always run multi-threaded and with hyperscale, you can change your default settings
  - Calibre run modes include Hierarchical, MTFlex, Remotedata, and Hyper Remote. Use a cluster/LSF/Grid for full-chip signoff. Launch distributed runs from Interactive (LSF/Grid tables) or batch (job scripts). Ensure enough Calibre licenses for the parallel slots, or it will serialize.
  - Make sure I/O isn’t your bottleneck: place MGC_TMPDIR scratch/temp on fast local/NVMe, not a busy NFS.
- Calibre DRC Recon: subset deck for early iterations
- Reusable Hierarchical Database (RHDB)

## LVS

- [Calibre LVS `BOX`: 忽略某些 cell 的内部结构，仅检查其外部 pin 连接关系](https://zhuanlan.zhihu.com/p/44234616)
  - 关于 regular/gray/black boxes 的[更多介绍](https://www.youtube.com/watch?v=gVkLmYFO5Q0)
- [Calibre LVS `EXCLUDE`, `HCELL` 和 `XCELL`](https://zhuanlan.zhihu.com/p/1927047373147837620)


## PEX

这个对话框用于把 Calibre xRC（PEX）的结果 back‑annotate 进 Virtuoso 库，生成可在 ADE 中仿真的 calibre 视图（含器件与寄生）。默认会弹出，让你确认映射文件、视图类型、端口策略、放置方式等。


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


