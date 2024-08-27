# Why is CPU operating at 1v? - draft version

## 为什么不能是

### 电压为什么不能是 -1v

### 电压为什么不能是 0v（CPU 为啥要耗电/耗能）

CPU 为啥要耗电，如果是超导互连 CPU 还会耗电吗？

电脑的功率因数 0.75？

#### 信息论的角度

CPU 的部分工作可以视作是对信息进行处理。在混沌的系统中控制一个 bit，即把它设为 0 或 1，此时系统就不再像原来那样完全无序了，降低了信息的不确定性。这是一个熵减的过程。

在信息论中，[熵](https://zh.wikipedia.org/wiki/熵_(信息论))是接收的每条消息中包含的信息的平均量，是对不确定性的量度，越随机的信源的熵越大。文字文本的熵比较低，因为文字易于人类阅读，或者说很容易被预测、不够随机。即便我们不知道下一段英语文字是什么内容，但是我们能很容易地预测，比如，字母e总是比字母z多，或者qu字母组合的可能性总是超过q与任何其它字母的组合。

CPU 把一些无序的信息转化为有序的信息，CPU 能量消耗中的极小部分并没有转换成其他形式的能量，而是变成熵减了。不同于赫赫有名的 $E=mc^2$，质量即能量；其实信息论中，信息也是一种能量。甚至再激进一点的说法可以说成“信息、物质、能量是等价的”。

[Landauer's 极限](https://en.wikipedia.org/wiki/Landauer's_principle)认为擦除或？写入？measurement, decision about a yes/no question, erasure, display, etc. 1-bit 信息所需的最小能量是 $k_{\mathrm{B}}T\ln2$，在室温下约等于 $0.18\pu{eV}$ 或是 $0.003\pu{aJ}$，也就是说，？无论 1-bit 的存储器中原先存储的数据是 0 还是 1，Reset 这个存储器必定会产生能量消耗？。这个理论为计算机处理信息时所产生的热量给出了下限，但是从宏观的角度来看，即使是在电脑上删除 1TB 的文件也只会消耗 $3\pu{nJ}$ 的能量。这一能量相较于电路而导致的发热，显得无足轻重，但是可能会影响遥远未来的超导互连、光计算、量子计算等领域的超低功耗应用。不过在量子计算方面，[可逆计算](https://en.wikipedia.org/wiki/Reversible_computing)的概念可能可以突破这一极限。

> 知乎链接🔗：[1](https://www.zhihu.com/question/29137271) [2](https://www.zhihu.com/question/37386721) [3](https://www.zhihu.com/question/28727056) [4](https://www.zhihu.com/question/22346756) [5](https://www.zhihu.com/question/28727056) [6](https://www.zhihu.com/question/21168308) [7](https://www.zhihu.com/question/26937449) [8](https://www.zhihu.com/question/266776516) 8有一个500的问题
>
> Wikipedia [Entropy in thermodynamics and information theory - Wikipedia](https://en.wikipedia.org/wiki/Entropy_in_thermodynamics_and_information_theory)
>
> [The unavoidable cost of computation revealed](https://www.nature.com/articles/nature.2012.10186)

一般我们说生物的计算效率高：

[化学突触](https://en.wikipedia.org/wiki/Chemical_synapse)上传递 1 bit 需要 $10^{4}$ 个 ATP，差不多是 $5\times10^{4}\pu{aJ}$ 

https://en.wikipedia.org/wiki/Entropy_in_thermodynamics_and_information_theory#Negentropy



#### 电的角度

> 但和理论不同的是，**现实世界中，信息是要通过『介质』来呈递的**，而在我们现有的技术下，这个『介质』就是电，实现的方式就是用半导体集成电路。我们通过电位的高低来表示这是一个 1 还是一个 0。那么维持这个电位，改变这个电位，都需要克服半导体的物理属性； 想把这个电信号传递传递出去，就不能忽略电子在导体流动的过程中由于电阻产生的消耗；也正是因为有电阻，电流流过会发热，为了防止过热对半导体的属性造成不利影响，又需要引入散热机制。
>
> 其实综观整个计算机的发展史，从机械计算机，到电子管计算机，到现在的半导体计算机，人类一直在试图减小信息介质的能量消耗，从而造出更高效，更快速的计算机。至于说摩尔定律走到尽头，本质上也是一回事儿——在现有的半导体技术下对信息介质的性能已经快压榨到极限了。

##### 电磁场

> 电磁波在导电由于有σ，所以J=σE，当电磁波沿着Z向传播且只有一个分量Ex，则E=ex·Exm·exp(-αx)·exp(-jβz) 由此可见，电场的振幅在指数衰减，同时靠麦克斯韦方程组也可以求出磁场，衰减所损失的能量就是发出的热能or别的东西

##### 晶体管

到达了这个层次，就是工科或者说技术的范畴了。因此，实效性可能只有未来 50 年，硅基 VLSI。

[CPU是否可以视为纯电阻？ - 知乎 (zhihu.com)](https://www.zhihu.com/question/498045181)

有源器件

熵增，能量换信息



静态功耗

动态功耗

### 电压为什么不能是 0.05v

为啥 $V_{T}$ 

### 电压为什么不能是 0.2v

亚阈值，低速低带宽低功耗设计

如果在知乎上提问，这个问题一定会得到“先问是不是，再问为什么”的回复。



有噪声，那么为啥噪声的量级在 0.几v 左右



### 电压为什么不能是 0.8v





最后一代平面工艺 28nm / 22nm 工艺节点（取决于 G/LP/HP和具体厂商）的 Core IO 大约就在 0.85V 左右。为什么更先进的工艺反而不是

I/O MOSFET 大约在1.5V左右

频率低慢死

Core MOSFET and IO MOSFET

Intel 会特地不做最小 WL 的MOSFET，以提高频率

### 电压为什么不能是 1.6v

超频死机，冷的状态下为什么可以

### 2.0v? 

电迁移损坏？

### 电压为什么不能是 3.3v

[1.8V、3.3V、5V、12V等常用电压等级是如何确立的？ - 知乎 (zhihu.com)](https://www.zhihu.com/question/517783284)

### 电压为什么不能是 8v

### 电压为什么不能是 80v



### 后记

假设读者具有一定的理工科背景

笔者对于信息论和物理并不了解

学习过程，参考资料多，本质上更像是一篇笔记而不是文章。

广义上的 CPU，或者说是现代商用 CPU，包括了内部的 Cache 等。不是简单的手搓的 CPU

但是本文不会涉及超频等概念。
