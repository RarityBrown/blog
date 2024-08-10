# Self-Biased High-Swing Cascode Current Mirror

> Allen: *CMOS Analog Circuit Design*  (吴金网课)
> 
> Gray: *Analysis and Design of Analog Integrated Circuits*
> 
> 张鸿网课

动机：Combining the input branches eliminates the possibility of mismatch between the two branch currents and may reduce the power dissipation.

![image](https://github.com/user-attachments/assets/49236da7-c9dd-4a68-bed9-cf96d95ec0ba)

$$
V_{OV3} < I_{REF}R < V_{TH}
$$

电阻自偏置的 cascode CM 相较于普通的 high-swing cascode CM，主要有如下缺点：

1. 如果电流小，电阻 R 会很大
2. 引进另一个节点，产生一个寄生极点
3. 工艺问题：电阻做不准且无法跟踪 MOS 的工艺变化，需要留出一定余量使得所有角都可以满足，此时 $V_{OUT\min}$ 较大了；普通 high-swing cascode CM 使用 MOS 来偏置，跟踪工艺变化

## Sooch Cascode Current Mirror

todo
