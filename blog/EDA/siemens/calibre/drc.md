## DRC

- [Calibre 检查特定规则 DRC 或 Density DRC](https://zhuanlan.zhihu.com/p/1925245051493151687)
- Calibre `DRC Options - Include - Include Rule Statements` 填入 `EXCLUDE CELL cell_name` 忽略部分 instance 后执行 DRC


### Speed-up DRC

todo

- Enable Multi-Threading (MT/MTflex)
  - In batch, add ``-turbo <N>`` to match physical CPU cores (not hyperthreads). In Interactive, enable Turbo/MT and set core count. If you want Calibre to always run multi-threaded and with hyperscale, you can change your default settings
  - Calibre run modes include Hierarchical, MTFlex, Remotedata, and Hyper Remote. Use a cluster/LSF/Grid for full-chip signoff. Launch distributed runs from Interactive (LSF/Grid tables) or batch (job scripts). Ensure enough Calibre licenses for the parallel slots, or it will serialize.
  - Make sure I/O isn’t your bottleneck: place MGC_TMPDIR scratch/temp on fast local/NVMe, not a busy NFS.
- Calibre DRC Recon: subset deck for early iterations
- Reusable Hierarchical Database (RHDB)



### Calibre RealTime DRC

#### Enable

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

当然，对于最基础的启用 Calibre Realtime DRC 功能，只要以下三行：

```csh
setenv MGC_CALIBRE_REALTIME_VIRTUOSO_ENABLED   1
setenv OA_PLUGIN_PATH                          $MGC_HOME/shared/pkgs/icv/tools/queryskl
setenv LD_LIBRARY_PATH                         $MGC_HOME/shared/pkgs/icv/tools/calibre_client/lib/64:${LD_LIBRARY_PATH}
```


#### bindkeys in Virtuoso


```lisp
mgc_calibre_realtime_send_highlight_cmd("ClearHighlights")
mgc_calibre_realtime_send_highlight_cmd("HighlightAll")
mgc_calibre_realtime_send_highlight_cmd("CurrentError")
mgc_calibre_realtime_send_highlight_cmd("PrevError")
mgc_calibre_realtime_send_highlight_cmd("NextError")


mgc_calibre_realtime_Rve_Connection()
```

所以可以用类似于 

```lisp
hiSetBindKey("Layout" "Ctrl<Key>H"   "mgc_calibre_realtime_send_highlight_cmd(\"CurrentError\")")
hiSetBindKey("Layout" "Shift<Key>H"  "mgc_calibre_realtime_send_highlight_cmd(\"ClearHighlights\")")
```

 的 Virtuoso 快捷键来快速高亮和取消高亮 DRC 错误
