## analogLib

### Switches in analogLib

### `switch`

DC 情况下 analoglib 中 switch 的行为已经被[曹峰源](https://zhuanlan.zhihu.com/p/1932489880165941345)和[暗夜疾行](https://zhuanlan.zhihu.com/p/699269770)两人进行了详细的描述，暗夜疾行文章中最后一幅图详细描述了这个 `switch` 的 dc 特性。

所以笔者这里主要是补充一下开关在 tran 仿真中可能会遇到的各种问题，因此假设读者已经了解了 `switch` 的 dc 特性。

#### 问题一

当 `vopen` 和 `vclose` 设置很相近时，开关的沿并没有想象中的陡峭。

仿真电路图如下：

![image](https://github.com/user-attachments/assets/4b550cad-fa70-4bb3-a8b9-3b070db95cd5)

预期 `test` 节点的波形如左图所示，但是如果采用默认仿真设置会得到右图所示的波形：

![image](https://github.com/user-attachments/assets/470c4960-8aa3-4c4f-bd85-3d9a1bf02ab3)

这是仿真器最小步长导致的问题，左图是通过将 tran 仿真中的 `strobeperiod` 设置成 1f 来达到的预期行为。如果我们将曲线样式设置成 point 就会更加明显：

![image](https://github.com/user-attachments/assets/677a68e5-fbae-4a5f-a9e8-420aeb6f192b)



#### spxtswitch (sp*tswitch)


> Ideal switch is a single-pole multiple-throw switch with **infinite** ‘off’ resistance and **zero** ‘on’ resistance. The switch is provided to allow you to reconfigure your circuit between analyses. You can only change the switch state **between analyses** (using the alter statement), **not** during an analysis.
>
> - sp1tswitch - Ideal Switch With 1 Position
> - sp2tswitch - Ideal Switch With 2 Positions
> - sp3tswitch - Ideal Switch With 3 Positions
> - sp4tswitch - Ideal Switch With 4 Positions
>
> When the switch is set to position 0, it is open. In other words, no terminal is connected to any other. When the switch is set to position 1, terminal 1 is connected to terminal 0, and all others are unconnected. When the switch is set to position 2, terminal 2 is connected to terminal 0, and so on.
>
> An offset voltage is supported. It is placed in series with the common terminal. The negative side of the source is connected to the common terminal.
>
> The switch can change its position based on which type of analysis is being performed using the `xxx_position` parameters. This feature should be used carefully. Careless use can generate discontinuities that result in convergence problems. Once an analysis specific position has been specified using `xxx_position`, it will always dominate over a position given with the `position` parameter. To disable an analysis specific position, set it to its default value of unspecified.
>
> 
>
> Syntax/Synopsis/Example:
>
> ```
> Name ( t0 t1 ... ) switch <parameter=value> ...
> sw1  (t1 t2 t3)    switch dc_position=0 ac_position=1 tran_position=2
> ```
>
> Parameters:
>
> |      | Instance Parameters |                                                              |
> | :--- | :------------------ | :----------------------------------------------------------- |
> | 1    | `position=0`        | Initial switch position (0, 1, 2, ...).                      |
> | 2    | `dc_position`       | Position to which the switch is set at the start of DC analysis. |
> | 3    | `ac_position`       | Position to which the switch is set at the start of AC analysis. |
> | 4    | `tran_position`     | Position to which the switch is set at the start of transient analysis. |
> | 5    | `ic_position`       | Position to which the switch is set at the start of IC analysis (precedes transient analysis). |
> | 6    | `offset=0`          | Offset voltage in series with the common terminal.           |
> | 7    | `m=1.0`             | Multiplicity factor.                                         |



## Others

- vpulse / ipulse: https://optics.eee.nottingham.ac.uk/wiki/Vlsi:Cadence_Tips
- cccs: https://zhuanlan.zhihu.com/p/673455481
- https://zhuanlan.zhihu.com/p/1951970338117251467
- ideal low-pass filter: https://zhuanlan.zhihu.com/p/1951974455933928357
