## analogLib

### Switches in analogLib

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
