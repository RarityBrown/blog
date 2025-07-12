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

## LVS

- [Calibre LVS `BOX`: 忽略某些 cell 的内部结构，仅检查其外部 pin 连接关系](https://zhuanlan.zhihu.com/p/44234616)
  - 关于 regular/gray/black boxes 的[更多介绍](https://www.youtube.com/watch?v=gVkLmYFO5Q0)
- [Calibre LVS `EXCLUDE`, `HCELL` 和 `XCELL`](https://zhuanlan.zhihu.com/p/1927047373147837620)
