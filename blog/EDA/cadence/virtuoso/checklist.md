### 在跑大仿真前的 check-list

1. 电路准备
    1. 是否跑过短时间的 tran 验证？例如 1ps / 1ns？
    2. 在扫参、扫工艺角前，是否跑过一个扫描点的验证？
    3. 是否使用 [Run Preview](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuoso-video-diary-run-point-selection-wysiwyg) 检查仿真设置？
    4. 如果是其他人复制过来的，或者是复制备份的 tb，ADE 中的 Design 是否正确更新 cell 和 config？
2. ADE 信号
    1. 需要的信号是否保存，不需要的信号是否不保存？
        1. 如果是 `allpub` 评估是否放得下？
        2. 如果是 `lvlpub` 评估层次是否合理 - 特别是在前后仿切换的时候：有的后仿模块可能在第三层，有的在第四层，此时如果存第四层，第三层的所有数据都会被保存。
        3. 如果是 `select` 是否都存了？
    2. 是否进入 ADE Assembler 仿真，以自动保存仿真结果？
    3. 是否保存/重命名/锁定了上次仿真的结果？
3. 硬件资源与应急
    1. 仿真引擎是否设置正确？精度 cx ax 是否正确？multi-threading 是否按照 CPU 核心数和前后仿电路大小合理设置？
    2. CPU 是否足够？
        1. CPU 总体是否足够？是否有其他人在用这个 server？
        2. 是否有 Job Setup 并行度阻止仿真？如果是其他人复制的 maestro 也需要修改 Job Setup。
        3. ADE Assembler 中是否有老任务 suspended 阻止仿真？
    3. 是否保存了同 session 中其他 schematic/layout/maestro 的状态，以便于在 virtuoso 无响应时 xkill 而不丢失？
    4. 磁盘空间是否足够？`placeholder_file_reserved_for_deletion_in_case_of_emergency1.bin` 文件准备。


### debug checklist

- Simulation Engine:
  - APS conservative, Spectre X cx
- restart virtuoso
