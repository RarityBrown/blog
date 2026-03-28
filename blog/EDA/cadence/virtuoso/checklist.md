### 在跑大仿真前的 check-list

1. 电路准备
    1. 是否跑过短时间的 tran 验证？例如 1ps / 1ns？
    2. 在扫参、扫工艺角前，是否跑过一个扫描点的验证？
    3. 是否使用 [Run Preview](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuoso-video-diary-run-point-selection-wysiwyg) 检查仿真设置？
    4. **ADE** 中的 Design 正确指向相应的 cell 和 config？**config** 中的 Top Cell 是否指向正确的 schematic？通过 Open Design in Tab 检查
    5. testbench 的 schematic 和子电路层级的 schematic 是否保存了？避免 update and run 错误。
2. ADE 信号
    1. 需要的信号是否保存，不需要的信号是否不保存？
        1. 如果是 `allpub` 评估是否放得下？
        2. 如果是 `lvlpub` 评估层次是否合理 - 特别是在前后仿切换的时候：有的后仿模块可能在第三层，有的在第四层，此时如果存第四层，第三层的所有数据都会被保存。
        3. 如果是 `select` 是否都存了？注意，不仅是 details 表达式写了，save 的 checkbox 也要勾上
        4. 是否需要看功耗？是否存了电流？
    2. 是否进入 ADE Assembler 仿真，以自动保存仿真结果？
    3. 是否保存/重命名/锁定了上次仿真的结果？
3. config 设置
    1. 是否选择了正确的 schematic 和 calibre 组合？
4. 硬件资源与应急
    1. 仿真引擎是否设置正确？精度 cx ax 是否正确？multi-threading 是否按照 CPU 核心数和前后仿电路大小合理设置？
    2. 仿真时长是否足够？是否加了 bonding？
    3. CPU 是否足够？
        1. CPU 总体是否足够？是否有其他人 / 自己的其他任务在用这个 server？会有你一个任务需要 32 核，而你自己的其他任务已经吃满 cpu 的情况吗？
        2. 是否有 Job Setup 并行度阻止仿真？如果是其他人复制的 maestro 也需要修改 Job Setup。
        3. ADE Assembler 中是否有老任务 suspended 阻止仿真？
    4. 是否保存了同 session 中其他 schematic/layout/maestro 的状态，以便于在 virtuoso 无响应时 xkill 而不丢失？
    5. 磁盘空间是否足够？`placeholder_file_reserved_for_deletion_in_case_of_emergency1.bin` 文件准备。

对于超级大的后仿，可以考虑启用加快 netlisting 的过程：

```
envSetVal("adexl.test" "checkForNewCellviewVarsUponRun" 'cyclic "No")
envSetVal("adexl.test" "checkForUnsavedViewsUponRun" 'boolean nil)
envSetVal("adexl.gui" "disableConstraintsRead" 'boolean t)
```


### debug checklist

- Simulation Engine:
  - APS conservative, Spectre X cx
- restart virtuoso


### 文件管理

共享文件夹

maestro lib, testbench schematic lib, cell schematic lib 三个库分开？


自己创建的 symbol 中需要保留 `[partNmae]` 等，同时新增 `[@libName]` 这个域。


命名格式 `schematic_hqh_20260317_1678`，schematic 用户只读


每 1 分钟 10 分钟 100 分钟，1 天，2 天，3 天， 自动从公共 lib 里面拉去更新备份


layout 要和 schematic 每个都 binding 上
