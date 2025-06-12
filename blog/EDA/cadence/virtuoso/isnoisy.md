# isnoisy

### 正文

本文是一篇小文章，记录如何在 Virtuoso ADE Explorer 中同时一次性仿真 tran with tran noise 和 tran without tran noise 的两种情况。如果您对 ADE Explorer 尚不熟悉，欢迎阅读[介绍](#ADE.md)。

- 首先，参考 [`tran` 仿真在需要的时间点开启 noise, by 小试牛刀](https://zhuanlan.zhihu.com/p/9915953761) 可知，在 tran 仿真中，有一个 isnoisy 的参数 (`param`)，可以动态的设置 tran noise 的开关。
- 其次，参考 [Maestro 快速仿真实用教程 - 3.3 选择仿真器, by 干饭睡觉真君](https://www.analog-life.com/2025/02/improve-simulation-efficiency-with-cadence-maestro/#header-id-9) 可知，在 tran 仿真中，可以通过 `VAR("")` 的方式来进行动态调整 tran 仿真设置

因此，我们不妨猜测：

![image](https://github.com/user-attachments/assets/81c5971f-5a96-45f7-a7d6-3dbfca5d6164)

将自定义变量 isnoisy 设置为 `0 1` 两个值

果然成功：

![image](https://github.com/user-attachments/assets/c4488bf4-0faa-4fc3-ad54-176e917c8012)

### 后记

其实一开始笔者尝试设置 isnoisy 这个 variable 为 `yes no` 以及 `"yes" "no"`，但是都不成功。于是将对话框中的 isnoisy 先设置成非变量的形式，即在 select box 中设置为 yes，然后去看生成的 input.scs netlist：

```
tran tran stop=tran_time noisefmax=10G noiseseed=1 param=isnoisy \
    param_vec=[0 0 tran_time*0.01 1] write="spectre.ic" \
    writefinal="spectre.fc" annotate=status
```

可以发现 `tran_time*0.01` 后面的那个参数 `1` 其实才是设置 tran noise 开启与否的变量。所以就有了前文看似一次就猜测对应该设置成 `0 1` 的表象。
