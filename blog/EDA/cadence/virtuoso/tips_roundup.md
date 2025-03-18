# Cadence Virtuoso Tips & Tricks Roundup

## Library & File & PDK

- [文件书签 / 文件收藏](https://www.xiaohongshu.com/user/profile/60bce751000000000101e227)
- [用 `.scs` 文件实现批量引用同一工艺角下的 mos, res, cap](https://zhuanlan.zhihu.com/p/588659964)
- [用 `.scs` 文件保存 model 批量引用](https://blog.csdn.net/qq_33599939/article/details/122505894#11scsmodel_19)

### analogLib & rfLib



### SKILL &  `.cshrc`, `.cdsinit`, `.cdsenv`

[SKILL for the Skilled: What is SKILL++? Cadence Blogs](https://community.cadence.com/cadence_blogs_8/b/cic/posts/skill-for-the-skilled-what-is-skill)

- [SKILL 脚本的基本编写与运行](https://www.zhihu.com/question/55715745/answer/3395432392)
- [手动与自动运行 SKILL 脚本的方式](https://www.xiaohongshu.com/user/profile/6345788e000000001802b944)
- [`.cdsinit`, `.cdsenv` 和寻找操作对应的 SKILL 语句](https://zhuanlan.zhihu.com/p/37215838)
- [`.cdsinit` 和 `.cdsenv` 文件的妙用](https://zhuanlan.zhihu.com/p/334782042)
- [防 virtuoso 意外退出而中断仿真（附 `.cdsinit` 和 `.cdsenv` 文件说明）](https://zhuanlan.zhihu.com/p/557858923)
- [ `.cshrc`, `.cdsinit`, `.cdsenv`文件配置，修改工艺文件通过 SKILL 实现 overstress 仿真](https://zhuanlan.zhihu.com/p/703004089)

## Schematic & Layout & GDS

- [通过 Spice In 功能批量将数字标准单元库网表转换成 schematic](https://zhuanlan.zhihu.com/p/678951019)
- [快速建立尺寸不同的反相器等单元](https://blog.csdn.net/qq_40007892/article/details/119246219)
- [版图检查快速定位 Layout - Connectivity - Net Tracer](https://zhuanlan.zhihu.com/p/13366999517)
- [通过 SKILL 为 schematic 自动加 PIN](https://mp.weixin.qq.com/s/qxZB4m2CG69nmannkSiT5w)
- [通过 SKILL 切换 schematic 与 layout 的只读与编辑](https://www.xiaohongshu.com/user/profile/6345788e000000001802b944)
- [通过 SKILL 实现无 GUI 的命令操作，以及自动化 streamout 的 GDS 导出](https://zhuanlan.zhihu.com/p/6010155066)
- [Net trace manager 版图快速定位](https://zhuanlan.zhihu.com/p/13366999517)
- [Layout 常见快捷键](https://zhuanlan.zhihu.com/p/28770741048)

## ADE

### General

- [加快 Spectre 仿真速度](https://zhuanlan.zhihu.com/p/677379106)
- [同一个 testbench 仿真结果不同](https://zhuanlan.zhihu.com/p/14460437849)
- [后仿不通过 pin 连接 symbol 内部节点: deepprobe](https://www.xiaohongshu.com/user/profile/60bce751000000000101e227)
- [查找替换网表名称、工艺库、器件等](https://blog.csdn.net/qq_33599939/article/details/122505894#16_171)
- [ADE Explorer 和 Assembler 的一些小技巧](https://zhuanlan.zhihu.com/p/372495688)
- [后仿真总结 (包含Calibre、DSPF、Spectre 提寄生)](https://zhuanlan.zhihu.com/p/6580714389)

### `tran`

- [`tran` 仿真保存第一次仿真最后时间结点的状态，并让它成为下一次仿真的初始态](https://zhuanlan.zhihu.com/p/24416542)
- [`tran` 仿真结束后延长仿真时间，不重新从头开始仿真——“断点续仿”](https://zhuanlan.zhihu.com/p/142714596)
- [`tran` 仿真时的 Dynamic Parameter](https://zhuanlan.zhihu.com/p/392505085)
  - [`tran` 仿真在需要的时间点开启 noise](https://zhuanlan.zhihu.com/p/9915953761)
- [`tran` 仿真的过程中进行小信号相关的仿真](https://zhuanlan.zhihu.com/p/344932538)

### `pss`

- [pss 仿真](https://zhuanlan.zhihu.com/p/16816066025)

#### `pnoise`


#### `pstb`

- [pstb 仿真斩波运放增益及相位特性](https://zhuanlan.zhihu.com/p/683249779)

### AMS & Verilog-A & Verilog-AMS

- [用 Verilog-A 配置电路修调控制](https://zhuanlan.zhihu.com/p/460423786)
- [AMS 数模混仿步骤](https://zhuanlan.zhihu.com/p/683070031)
- [AMS 数模混仿流程](https://zhuanlan.zhihu.com/p/8280687951)

### ADE Others

- [Mismatch 仿真: `dcmatch`, `acmatch`](https://www.xiaohongshu.com/user/profile/60bce751000000000101e227)
- [参数敏感性仿真: `sens`](https://www.xiaohongshu.com/user/profile/60bce751000000000101e227)

### config

- [config 简介：修改结构参数，在不改动PIN的情况下更换电路元件；模拟后仿寄生电容以及设计其他参数](https://zhuanlan.zhihu.com/p/614286236)
- [Spectre 后仿中端口 (bus) 数目过多导致网表生成失败问题的 .cdf 保存及 Python 脚本辅助解决](https://zhuanlan.zhihu.com/p/9576555642)

## Others



## VIVA & Calculator

- [保存仿真曲线结果](https://zhuanlan.zhihu.com/p/662309243)
- [曲线斜率, dx, dy 标记](https://blog.csdn.net/qq_33599939/article/details/122505894#4_38)
- [通过 `value` 和 `cross` 函数，给定横/纵坐标的值，得到纵/横坐标的值，y(x), x(y)](https://zhuanlan.zhihu.com/p/10093779489)
- [IC23.1 仿真结果 VIVA 曲线图背景调整成白色](https://zhuanlan.zhihu.com/p/8242343475)
- [Calculator 基本操作](https://zhuanlan.zhihu.com/p/461911657)

# Ref

https://zhuanlan.zhihu.com/p/672788607
