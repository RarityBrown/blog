# SKILL & SKILL++ & OCEAN

TLDR: 

## Lisp, SKILL 和 OCEAN 的基本介绍 

Cadence 家的工具几乎所有 API 都基于 SKILL 语言开发，SKILL 是以 Lisp 语言为基础，吸收了 Common Lisp 和 Scheme 两种 Lisp 方言特性的脚本语言。部分 SKILL 脚本以 `.il` 为 file extension name，`.il` 扩展名的起源可以追溯到该语言的前身 **IL (Interface Language)**。最初，开发 IL 语言是创建 silicon compilers 脚本接口的一部分，其早期名称 SCIL (Silicon Compiler Interface Language) 即由此缩写而来。这个名字发音为“SKIL”，逐渐演变为 **SKILL**。Cadence 官方澄清说，“SKILL”不是首字母缩略词，而是一个注册商标名称，尽管它的血统仍然与 SCIL 和 IL 相关，同时 IL 的历史可能早于 Cadence 成立的时间。从 IL 到 SKILL 的转变标志着该语言角色的转变——从低级接口到全面的 API 和脚本框架。尽管进行了品牌重塑，但 `.il` 扩展名仍然作为 SKILL 源文件的传统约定而存在，反映了它在接口语言时代的根源。

`.il` 扩展名专门表示遵循 **Lisp-2 semantics** 的 SKILL 代码，这是一种命名空间范例，其中函数和变量占据不同的范围。这与使用 **Lisp-1 语义**（函数和变量的单个命名空间）的 `.ils` 文件形成对比。这种区别对开发人员至关重要：Lisp-2 允许函数和变量名称共存而不会发生冲突，而 Lisp-1 需要仔细命名以避免重叠。例如，在 Lisp-2 上下文中，变量 `list` 和函数 `list()` 可以共存，而在 Lisp-1 中，重新定义 `list` 将覆盖该函数。
SKILL++ 是一种增强型方言，具有词法作用域和一等函数等特性，进一步说明了 .il 扩展名的上下文。SKILL++ 代码通常使用 `.ils` 扩展名来表示 Lisp-1 语义，而传统的 SKILL 则保留 `.il`。这种分叉允许开发人员选择适合其任务的范例——词法作用域用于模块化代码（SKILL++），动态作用域用于快速原型设计（传统SKILL）。

选用 lisp 的原因除了历史原因，可能也包括 lisp 的数值计算能力，例如 [LdBeth](https://www.zhihu.com/question/622919986/answer/3222931638) 提到的 $\operatorname{atanh}(1.2 + 20000000i)=\frac{\pi}{2}j$ 这一计算精度问题。

> [!NOTE]
> YouTube 上有基于 IC6.1.8 的官方培训 SKILL [视频](https://www.youtube.com/playlist?list=PLjRIBQDeKyRqWp8Uyk6gIYmRSE2ltCX3s)，可以说是公开内容中最好的 SKILL 培训资料。

OCEAN 是专门用于 Virtuoso ADE 仿真和分析的 SKILL 子函数集。OCEAN 专注于仿真任务，如运行多工艺角仿真、预/后仿真处理、批处理仿真、管理输出结果。仿真后的数据分析可以使用 Calculator，也可以通过 OCEAN 自动化完成在 Calculator 中需要手动完成的任务。所以 Calculator 中的所有函数的帮助文档其实都在 `oceanref.pdf` 中。



## CIW (Command Interpreter Window)

- CIW (Command Interpreter Window) 是一个 console (见下表)
- 在 Virtuoso 中执行的所有操作都有对应的 SKILL API 函数进行实现


| Characteristic              | Terminal                         | Shell                           | Console                           | Cadence Virtuoso CIW                |
| --------------------------- | -------------------------------- | ------------------------------- | --------------------------------- | ----------------------------------- |
| **Primary Function**        | Text interface to OS             | Interprets/executes OS commands | Text interface for program/system | Text interface for Cadence Virtuoso |
| **Operating System Access** | Direct                           | Indirect (via terminal)         | Varies, often direct for system   | Indirect, application-specific      |
| **Example**                 | GNOME Terminal, Windows Terminal | Bash, PowerShell                | System console, app command line  | CIW window in Virtuoso              |

CIW 中并不像 Bash 或 PowerShell 一样，可以使用 `clear` 命令清屏。因为 CIW 还有起到日志的作用，可以在 Options → Log Filter 中设置。常见的清屏手段是 `printf("\n\n\n\n\n\n\n\n\n\n")`


## 快捷键 bindkey

在 Virtuoso 中，键盘快捷键被称作是 "bindkey"，这不同于一般软件开发中的 "shortcut" 或 "hotkey" 的称谓。我们以一个例子作为本段落的开场：

### 全流程例子

我们想在 [ADE Explorer](ADE.md) 中自定义 <kbd>Ctrl</kbd> + <kbd>N</kbd> 快捷键，来实现右侧工具栏中的 `Add Outputs` 添加一个空白的 expr 条目，这样我们就不需要每次移动鼠标点击才能添加仿真结果。我们主要需要干两件事：

- **第一步**：知道 ADE Explorer 的图形界面中 `Add Outputs` 按钮所对应的 Virtuoso SKILL API（因为上文提到，所有操作都有对应的 SKILL API）
- **第二步**：将快捷键 <kbd>Ctrl</kbd> + <kbd>N</kbd> 绑定到第一步中找到的 API 上

#### 第一步 (获得 Virtuoso SKILL API)：

1. 通过在 CIW 菜单栏中的 `Option` - `Log Filter...` 打开 "Set Log File Display Filter" 窗口，将默认没有选上的 `\a`, `\r`, `\p` 选项全部勾选（参考 [eetop](https://bbs.eetop.cn/thread-963864-1-1.html), [蓝色天空](https://www.kaixinspace.com/virtuoso-bindkey/)）
2. 用鼠标单击 ADE Explorer 右侧工具栏中的 `Add Outputs`，观察 Virtuoso CIW 窗口中显示的 SKILL 函数：

```lisp
_axlAddOutputByTypeCB(_axlGetCurrentSessionDontFail() "expr")
_axlOutputsSetupAddOutputByType(axlOutputsForm4->axlOutputsWidget4 "expr" "LIB_NAME:CELL_NAME:1")
_axlShowHideOutputSetupNamedFilterItems(axlOutputsForm4->axlOutputsWidget4 t)
```

如果我们此时再次使用鼠标点击 `Add Outputs`，会发现在 ADE Explorer 中并没有再新建一个空白的条目，因为 ADE Explorer 不允许多个空白条目。此时 SKILL API 也会在 CIW 中显示 `nil`，`nil` 在 lisp 中可以表示 `false`，即函数执行失败了：

```lisp
_axlAddOutputByTypeCB(_axlGetCurrentSessionDontFail() "expr")
nil
```

我们在 ADE Explorer 中手动删除刚刚新建的空白条目后，将 `_axlAddOutputByTypeCB(_axlGetCurrentSessionDontFail() "expr")` 复制到 CIW 窗口下方的输入框内，并 <kbd>Enter</kbd> 执行。可以惊喜地发现，在 ADE Explorer 中，一个新的空白条目被创建了。至此，我们已经成功地完成了第一步——获取了 `Add Outputs` 所对应的 SKILL API。聪明的读者在刚刚删除的过程中，可能会顺便获取了删除 ADE Explorer 输出结果条目的 SKILL API：

```lisp
_axlOutputsSetupDeleteSelected(axlOutputsForm1->axlOutputsWidget1)
```


#### 第二步（绑定快捷键）

直接在 CIW 中依次输入

```lisp
hiSetBindKey("explorer"  "Ctrl<Key>N" "_axlAddOutputByTypeCB(_axlGetCurrentSessionDontFail() \"expr\")")
hiSetBindKey("assembler" "Ctrl<Key>N" "_axlAddOutputByTypeCB(_axlGetCurrentSessionDontFail() \"expr\")")
```

CIW 中 <kbd>Enter</kbd> 执行，返回 `t` 即意味着设置成功。我们有两种方式确认：

1. 直接在 ADE Explorer 中 <kbd>Ctrl</kbd> + <kbd>N</kbd> 看看有不有新条目生成
2. 通过在 CIW 菜单栏中的 `Option` - `Bindkeys...` 打开图形化的 "Bindkeys Editor" 窗口检查。未来我们也可以直接在 "Bindkeys Editor" 中图形化地设置 bindkey，而不直接使用 `hiSetBindKey()` 函数

至此，我们已经完成了在 Virtuoso 中找到一个命令的 SKILL API 并将其设置为快捷键的全部流程。如果我们想要在 Virtuoso 每次启动时可以自动绑定 <kbd>Ctrl</kbd> + <kbd>N</kbd> 作为 `Add Outputs` 的快捷键则需要用到 `.cdsinit` 和 `.cdsenv`：

通过这个流程，我们就可以实现一系列我们想要的操作了，例如[网上](https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/23666/keyboard-shortcut-for-running-simulation-in-ade-gxl)提到的使用 <kbd>F5</kbd> 作为仿真启动快捷键：


```lisp
hiSetBindKey("adexl"      "<Key>F5" "axlRunSimulation()")
hiSetBindKey("adegxl"     "<Key>F5" "axlRunSimulation()")
hiSetBindKey("Schematics" "<Key>F5" "axlRunSimulation()")
hiSetBindKey("explorer"   "<Key>F5" "axlRunSimulation()")
hiSetBindKey("assembler"  "<Key>F5" "axlRunSimulation()")
; sevNetlistAndRun() in ADE L


sevNetlistAndRun(sevSession(hiGetCurrentWindow()))
hiSetBindKey("Schematics" "<Key>F5" "(sevRunEngine (_axlGetExplorerSevSession (_axlGetCurrentSessionDontFail)))")
```



又或者使用 <kbd>Ctrl</kbd> + <kbd>D</kbd> 直接在 schematic 中添加 vdc 源 （参考 [eetop](https://blog.eetop.cn/blog-1722314-6946097.html), [zhihu](https://zhuanlan.zhihu.com/p/703004089)）

```lisp
procedure(add_vdc( )
   schHicreateInst( ?libraryName "AnalogLib" ?cellName "vdc" ?viewName "symbol" )
)
hisetBindKey("schematics" "Ctrl<Key>d" "add_vdc( ) ")
```

### 更复杂的例子

`My_bindkey_functions.il`

```lisp


```

## `.cdsinit` and `.cdsenv`

> https://github.com/DavidZemon/CadenceProject


其实 SKILL 对于用户最常用的功能就是设置 `.cdsinit` 和 `.cdsenv`：

参考资料：

- Virtuoso 官方文档
  - *Virtuoso Software Licensing and Configuration User Guide*: `dfIIconfig.pdf`
  - 网页链接

本段落框架由 Perplexity Deep Research 完成，笔者审核与补充。

### 基本介绍

Cadence Virtuoso 有一些默认的设置不是很方便，例如 VIVA 绘图默认背景颜色、线宽等，可以通过在启动 Virtuoso 后通过 load  `.cdsinit` 和 `.cdsenv` 来自动自定义配置。

`.cdsinit` 文件是一个 SKILL 脚本，主要负责工具扩展模块的动态加载、快捷键绑定以及用户自定义函数的初始化[1](https://blog.csdn.net/weixin_44951108/article/details/133921228)[3](https://blog.csdn.net/LSTK_LAY/article/details/131250586)。典型的应用场景包括：

- PDK 显示规则文件自动加载
- 仿真器参数预配置
- Calibre 工具集成

`.cdsenv` 文件则采用 key-value pair 形式管理环境变量，控制工具的基础行为参数[1](https://blog.csdn.net/weixin_44951108/article/details/133921228)[6](https://www.dzsc.com/data/2007-4-30/29147.html)。其核心功能涵盖：

- 图形界面元素的默认参数设置
- 文件系统的路径映射规则
- 仿真结果存储目录定义

两文件的协同工作机制体现在：`.cdsenv` 在 Virtuoso 启动初期加载，建立基础运行环境；`.cdsinit` **随后**执行，完成**高级**功能扩展与交互优化。

todo 好像有问题↑

### 文件路径和加载优先级

Virtuoso 的配置体系采用分层管理策略，`.cdsinit`与`.cdsenv`作为用户级配置文件，在系统默认配置基础上实现个性化定制。

#### `.cdsinit`

Virtuoso 按以下优先级从高到低搜索 ` .cdsinit`，并**只加载第一个**找到的 ` .cdsinit` 文件：

1. 系统级配置：`<install_dir>/tools/dfII/local/.cdsinit` 目录存放
   1. 可以没有 `local` 目录和文件，软件安装完毕后不会自动配置
   2. 在 `<install_dir>/tools/dfII/samples/local/.cdsinit` 存放配置模板，这个文件一定存在
2. 项目工作目录：`./.cdsinit` 实现项目专属配置
3. 用户主目录：`~/.cdsinit` 提供全局个性化设置

> [!NOTE]
>
> 1. 网上有很多资料错误的将当前目录和用户主目录的优先级颠倒，此处提供的优先级是参考 Virtuoso 官方文档的，才是正确的
> 2. 上述三种 `.cdsinit` 的执行位置都是 Virtuoso 启动目录。例如位于 `~/.cdsinit` 的脚本，执行 pwd 命令，pwd 的输出不是 `~` home 目录（ `~/.cdsinit`  所在目录），而是是 Virtuoso 在 shell 中启动的目录。

#### `.cdsenv`

`.cdsenv` 如果 `CDS_LOAD_ENV` 环境变量没有被设定，则

-  `<install_dir>/tools/dfII/etc/tools/application/` 下，所有子文件夹中的默认环境变量值
- `<install_dir>/tools/dfII/local/.cdsenv` 
  - 和 `.cdsinit` 一样，可以没有 `local` 目录和文件用于全局配置
  - 在 `<install_dir>/tools/dfII/samples/.cdsenv` 存放配置模板，这个文件一定存在
- `~/.cdsenv`

会**依次全部加载**，并且如果三个 `.cdsenv` 文件对于某一变量有不同的定义，晚加载的 `.cdsenv` 会覆盖先前加载的环境变量值

示例：在 shell 中执行 `printenv CDS_LOAD_ENV`。如果返回 `CWD`，则意味着前面提到的三个都不加载了，只加载 `CWD/.cdsenv`。这种情况下：

```lisp
;;;;;;;;;;;;;; .cdsinit ;;;;;;;;;;;;
envLoadFile("~/.cdsenv")  ; 可以考虑在前文提到的 `.cdsinit` 文件中手动加载


;;;;;;;;;;;;;; CIW ;;;;;;;;;;;;;;;;;
envLoadFile("./.cdsenv")  ; 也可以在 CIW 窗口执行配置动态实时更新，无需重启 Virtuoso 即可生效，适用于长期运行的仿真任务环境
load("./.cdsinit")        ; 或是使用 lisp 文件名，保存成 init.il 后 load("/home/.../init.il") 也可以手动加载
```

### 利用 `.cdsinit` 和 `.cdsenv` 自定义 Virtuoso 设置

#### `.cdsenv`

##### 基本介绍

Cadence Virtuoso 的环境变量，简称 cds env，可以通过 Virtuoso Command Interpreter Window (CIW) 菜单中 Options - Cdsenv Editor 可视化地查看与编辑；而通过 `.cdsenv` 则可以实现在每次启动时自动地设置：

```scheme
; .cdsenv 文件采用
tool.env variable type value
; 的标准语法结构，每个配置项包含四个维度参数 https://www.dzsc.com/data/2007-4-30/29147.htm

; (tool)  ：指定配置作用域（如layout、graphic）
; (env)   ：参数标识符（如defaultNewViewName）
; (type)  ：定义数值类型（boolean/string/int）
; (value) ：具体参数值
```

`.cdsinit` **晚于** `.cdsenv` 执行，用于完成**高级**功能扩展与交互优化。所有 `.cdsen`v 设置都可以通过 `.cdsinit` 来实现，而 `.cdsinit` 中的部分功能无法通过 `.cdsenv` 设置。例如，在 `.cdsenv` 中设置仿真曲线结果窗口的背景为白色：

```lisp
;;;;;;;;;;;;;;;;;;;;; .cdsenv ;;;;;;;;;;;;;;;;;;;;;
viva.graphFrame background string "white"  ; 设置Viva波形背景为白色
;;;;;;;;;;;;;;;;;;;;; .cdsenv ;;;;;;;;;;;;;;;;;;;;;

; 这和上文提到的 tool.env variable type value 语法结构是一样的
```

 也可以通过 `.cdsinit`  中调用 `envSetVal` 函数来实现：

```lisp
;;;;;;;;;;;;;;;;;;;;; .cdsinit ;;;;;;;;;;;;;;;;;;;;;
envSetVal("viva.graphFrame" "background" 'string "white")
;;;;;;;;;;;;;;;;;;;;; .cdsinit ;;;;;;;;;;;;;;;;;;;;;

; 参数的顺序与种类和 .cdsenv 保持一致，只是语法略有不同：
envSetVal(tool.env variable 'type value)

; .cdsinit 中还有一个 envGetVal() 函数，语法和例子如下
envGetVal(toolName variableName)
labelHeight = envGetVal("layout" "labelHeight")
```

##### `.cdsenv` 示例

一个大而全的 `.cdsenv` 配置示例（但有不少字段错误，需要人工核查）：

```scheme
graphic defaultNewViewName string "layout" ; 设置默认新建单元视图类型
graphic cursorStyle string "cross"         ; 十字光标样式


;;;;;;;;;;;;;;;;;; schematic 
schematic srcSolderOnCrossover cyclic "ignored"   ; ignore cross over of wires in schematic
schematic srcInstOverlapValue  int    30          ; default = 10
schematic schDynamicNetHilightColorMemNet string "black"
schematic srcSolderOnCrossover cyclic "ignored"  ; ignore cross over of wires in schematic
schematic srcInstOverlapValue int 30  ; default = 10

maestro.gui textColorForSpecNearInResults string "purple"

layout snapMode string "diagonal"          ; 设置标尺捕捉模式为对角线模式 "orthogonal" 正交模式
layout gridSpacing double 0.005            ; 栅格间距5nm
layout textDisplayMode string "stick"      ; 文本显示为线框模式
layout displayPinNames boolean t           ; 启用版图设计中的引脚名称显示
layout numLevels int 20                    ; 调整版图编辑器默认显示层级

; 层次化规则
layout hierarchical boolean t
layout abstractViewName string "schematic"
layout cellNameMapFile string "$PDK/cell_map.txt"

; 字体渲染优化
graphic xfont string "-adobe-courier-medium-r-normal--14-*-*-*-*-*-iso8859-1"
graphic antiAlias boolean t
layout textRendering string "vector"

; HSPICE 集成配置
asimenv options hspiceCmd string "hspice -mt 8"
asimenv hspice include string "$PDK/hspice.include"
asimenv hspice modelFile string "tt_25c.lib"
; 仿真结果目录配置
asimenv.startup projectDir string "/simulation"
asimenv.startup simulator string "spectre"   ; 设置默认仿真器
; 配置蒙特卡洛分析参数
asimenv.mcSetup samples int 1000
asimenv.mcSetup saveAllData boolean nil

; LVS选项配置
lvsenv options command string "calibre -lvs -64"
lvsenv options reportFile string "lvs_summary.rpt"
lvsenv options tolerance string "1%"

; Pcell 自动更新
layout pcellAutoUpdate boolean t
layout pcellCacheDir string "/tmp/pcell_cache"
layout pcellDebugMode boolean nil

; Spectre 仿真预设
envSetVal("spectre.envOpts" "stopLevel"   'string "module")
envSetVal("spectre.envOpts" "rawfmt"      'string "psfbin")

; DRC/LVS 路径设置
envSetVal("drcenv.setup" "ruleSet" 'list drcRules)
envSetVal("drcenv.setup" "ruleFile" 'string "/pdk/drc/calibre.drc")
envSetVal("lvsenv.setup" "ruleFile" 'string "/pdk/lvs/calibre.lvs")
```

**自用模板**：

```lisp
;;;;;;;;;;;;;;;;;; lib manager
cdsLibManager.main   showCategoriesOn boolean t              ; lib manager shows categories
cdsLibManager.main   showFilesOn      boolean t              ; lib manager shows files

;;;;;;;;;;;;;;;;;; spectre
spectre.turboOpts    uniMode          string  "APS"          ; to use spectre APS by default. or "Spectre X"
; spectre              numThreads       int     16           ; memory and multithreading config, todo

;;;;;;;;;;;;;;;;;; ADE XL (ADE Explorer)
;;; Why ADEXL instead of ADE Explorer: https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/52576/how-to-set-default-corners-in-maestro
; adexl.icrpStartup    defaultJobPolicy           string "My_jobpolicy"        ; My jobs parallelization policy
; maestro.lscs         defaultNetlistingJobPolicy string "LSCS_NetJob_Policy"  ; or use the LSCS instead of the ICRP
; maestro.lscs         defaultSimulationJobPolicy string "LSCS_SimJob_Policy"  ; or use the LSCS instead of the ICRP
; adexl.gui            defaultCorners             string "./corners/corners_6.sdb" ; IC6.1.8-64b.500.19. see https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/49271/load-corners-csv-file-skill-function
; adexl.gui            defaultCorners             string "./corners/corners_6.csv" ; IC6.1.8-64b.500.20

;;;;;;;;;;;;;;;;;;
auCore.misc          annotationSetupFileList string "./.cadence/dfII/annotationSetups/My_annoSetup.as"
; https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuosity-sharing-and-automatically-loading-ade-annotation-settings

;;;;;;;;;;;;;;;;;; VIVA
; viva.rectGraph           background       string  "white"        ; for older version
viva.graphFrame           background       string  "white"        ; for IC6.1.8 IC23.1 
viva.trace                lineThickness    string  "thick"
; viva.trace                lineStyle        string  "solid"      ; Dot, dashed, etc.
asimenv.plotting          useDisplayDrf    boolean nil          ; for tsmc pdk only. SMIC and others don't need this line. see https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/41208/dotted-lines-by-default-in-viva https://www.edaboard.com/threads/how-to-change-the-default-in-ade-cadence.378231/ https://joeyaochou.wordpress.com/2015/04/08/cadence-virtuoso-learning-note/ https://gist.github.com/02015678/783ad36389fe3b7aa8cd https://bbs.eetop.cn/thread-959872-4-1.html https://bbs.eetop.cn/thread-917244-1-1.html https://bbs.eetop.cn/thread-664788-1-1.html
viva.horizMarker          font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.horizMarker          interceptStyle   string  "on"
viva.vertMarker           font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.vertMarker           interceptStyle   string  "on"
viva.pointMarker          font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.axis                 font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.traceLegend          font             string  "Default,15,-1,5,75,0,0,0,0,0"

;;;;;;;;;;;;;;;;;; 
ui    defaultEditorBackgroundColor    string  "#2F2F2F"       ; schematic / layout black background to vscode gray
ui    ciwCmdInputLines                int     4

;;;;;;;;;;;;;;;;;; schematic
schematic            srcSolderOnCrossover cyclic "ignored"   ; ignore solder dot cross over warning

;;;;;;;;;;;;;;;;;; graphic
graphic              balloonOn        boolean t               ; ?enable the info balloon by default

;;;;;;;;;;;;;;;;;; layout ;;;;;;;;;;;;;
layout               xSnapSpacing     float   0.005           ; 0.005um is typical for 28~55nm nodes
layout               ySnapSpacing     float   0.005           ; 0.005um is typical for 28~55nm nodes

; backup and autosave setting, todo
```


还有一些 virtuoso 用着不爽的点等待解决 todo：

> 1. How to open a schematic for a cell in Cadence Virtuoso by default (set the default behavior to always open a cell in schematic view)?  (not to create a new schematic file)        virtuoso 默认打开 schematic
> 2. function to open the current maestro view 
> 3. descend default open for auto, open in new tab cadence virtuoso
> 4. default annotation setup (virtuoso transient operating point?)
> 5. virtuoso 查看仿真实时波形 (How to output signals **during** virtuoso simulation? How to plot transient signals **before** simulation is complete? Virtuoso **real-time** tran waveform plotting?)
> 7. 显示剩余时间 virtuoso show simulation progress status and estimated remaining time (Search again for estimated remaining time specific for ADE Explorer and ADE Assembler)
> 8. virtuoso copy cellview maestro schematic linking issue
> 9. auto-save, auto-backup in Cadence Virtuoso
> 10. Cadence Virtuoso Schematic (sch.oa) to visio
>   1. https://blog.sina.com.cn/s/blog_5cf90fbc0101dll9.html
>   2. https://www.edaboard.com/threads/schematic-circuit-plot-from-cadence-virtuoso.390368/
> 11. license 连续调用问题 https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/49602/virtuoso-license-issue-status-code--5


自动建立工艺 gmoverid 查找表，自动扫出工艺转移特性曲线等


#### `.cdsinit`

一个大而全的 `.cdsinit` 配置示例（但有不少字段错误，需要人工核查）：

```scheme
load("<calibre_install_dir>/xxx/caliber.skl")         ; 加载 Calibre 接口
load("./scripts/my_script.il")                        ; 当前工作目录下的 scripts 文件夹
load("~/scripts/my_script.il")                        ; 用户 home 目录下的 scripts 文件夹


; 自动加载工艺设计套件
ddGetObj("TSMC65LP")
drLoadDrf("$PDK_HOME/display.drf")
; 注册自定义验证脚本
load("~/scripts/drc_custom.il")


ddRegPathtoCDS("/proj/pdk/tsmc65lp")
ddRegPathtoCDS("/proj/analog_lib")
ddRegPathtoCDS("/proj/digital_lib")

; 颜色方案配置
drDefineColor("Metal1"  'rgb "204/153/255")   ; 定义金属层颜色
drDefineColor("Poly"    'rgb "255/204/153")
drDefineStipple("DenseHatch" 0xAAAA)          ; 自定义填充图案

; 蒙特卡洛模板
asimenv.mcSetup(
    'samples      1000
    'saveAllData  nil
    'seed         "random"
    'analysis     "process"
)

; DRC 规则版本管理
drcRules = list(
    list("default" "/pdk/drc/default.drc")
    list("met5"    "/pdk/drc/met5_special.drc")
    list("rf"      "/pkg/rf_drc/rules.drc")
)

; schematic 和 layout 快捷键自定义
hiSetBindKey("Schematic" "Ctrl<Key>W" "schCheckSave()")
hiSetBindKey("Schematic" "<Key>F2"    "schAddInstance()")
hiSetBindKey("Schematic" "<Key>F5"    "schStartSim()")
hiSetBindKey("Layout"    "Ctrl<Key>G" "geCreatePath()")
hiSetBindKey("Layout"    "<Key>F3"    "geZoomIn()")
hiSetBindKey("Layout"    "<Key>F4"    "geZoomOut()")
hiSetBindKey("Layout"    "Alt<Key>M"  "mergeShapes()")
hiSetBindKey("Layout" "Ctrl<Key>s" "leHiSave()")      ; 绑定保存版图快捷键

; 绑定自定义版图密度检查函数
procedure(checkDensity()
    let((cellView)
        cellView = geGetEditCellView()
        densCalc = axlDensityCheck(cellView ?layer "M1" ?window 10)
        printf("Metal1 density: %.2f%%\n" densCalc*100)
    )
)
hiSetBindKey("Layout" "Ctrl<Key>D" "checkDensity()")

; 参数化单元配置
pcDefinePCell(
    list(ddGetObj("mylib") "nmos" "layout")
    list(
        (w 0.5)
        (l 0.06)
        (fingers 1)
    )
    let((cv)
        cv = pcCellView
        ; 生成几何结构代码
    )
)

; SKILL 调试模式
debugMode = t
setSkillPath('("/home/user/skill_scripts"))
load("debug_toolkit.il")
```

**自用模板**：

```lisp
envLoadFile("~/.cdsenv")                         ; 

hiRegTimer("ddsOpenLibManager()" 1)              ; Delayed automatic opening of lib manager
hiResizeWindow(window(1) list(100:150 1500:800)) ; Set the CIW window size, 400:150 and 1200:600 are the screen coordinates.

hiSetFont("ciw"   ?size 14)                      ; CIW font size, greater than 16 is not recommended
hiSetFont("text"  ?size 14)                      ; Toolbar and Menu font size, greater than 16 is not recommended
hiSetFont("label" ?size 14)                      ; simulation font size, greater than 16 is not recommended

hiSetBindKey("explorer"   "Ctrl<Key>N" "_axlAddOutputByTypeCB(_axlGetCurrentSessionDontFail() \"expr\")")
hiSetBindKey("assembler"  "Ctrl<Key>N" "_axlAddOutputByTypeCB(_axlGetCurrentSessionDontFail() \"expr\")")
hiSetBindKey("Layout"     "<Key>F1"    "printf(\"Help disabled\")")
hiSetBindKey("Schematics" "<Key>F1"    "printf(\"Help disabled\")")
hiSetBindKey("Symbol"     "<Key>F1"    "printf(\"Help disabled\")")


; hiSetBindKey("Schematics"  "Ctrl<Key>M" "new_explore_bindkey()")

; hiSetBindKey("Schematics" "Ctrl Shift <Key>J" "annLoadAnnotationData(hiGetCurrentWindow() \"/home/bachelor/huangheqing/Desktop/prj_20250224/.cadence/dfII/annotationSetups/My_annoSetup.as\")")
; hiSetBindKey("Schematics" "Ctrl Shift <Key>M" "annLoadAnnotationData(hiGetCurrentWindow() \"/home/arja/.cadence/TranannotationSetup.as\")")

; https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuosity-sharing-and-automatically-loading-ade-annotation-settings
```



#### 常见问题

##### 配置冲突检测

当出现无法解释的工具行为异常时，可采用以下诊断流程：

1. 检查配置加载顺序：`echo $CDS_LOAD_ENV`
2. 验证环境变量继承：`envGetVal("layout" "snapMode")`

### 利用 `.cdsinit` 实现 Calibre 集成

todo


## Calculator 中的 SKILL (OCEAN)

[Virtuosity: Sharing Custom SKILL Calculator Functions](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuosity-sharing-custom-skill-calculator-functions)

### 文档

Calculator 所有的函数，例如 `clip`, `value` 都是 OCEAN 函数，所以函数相关文档在 `oceanref.pdf` 中。我们摘录两个函数作为示例：


函数 1：

`freq`: **实时**频率

```lisp
freq(                         ; Computes the frequency of the input waveform(s) as a function of time or cycle.
   o_waveform                 ; Waveform, expression, or a family of waveforms.
   t_crossType                ; See below.
   [ ?threshold n_threshold ] ; See below.
   [ ?mode t_mode ]           ; See below.
   [ ?xName xName ]           ; The X-axis of the output waveform. The default value is time but cycle is also a valid value.
   [ ?histoDisplay g_histoDisplay ]      ; deprecated
   [ ?noOfHistoBins x_noOfHistoBins ]    ; deprecated
   )
   => o_outputWave / nil      ; Returns the frequency as a function of time or cycle.
```

- `t_crossType`: The points at which the curves of the waveform intersect with the threshold. While intersecting, the curve may be either rising or falling. For the `freq` function, you may specify the frequency to be calculated against either the rising points or the falling points by setting `crossType` to `rising` or `falling`, respectively. The default `crossType` is `rising`.
- `t_mode`: The mode for calculating the threshold. This is `auto`, by default, in which case `n_threshold` is calculated internally. It can alternatively be set to `user`, in which case, an `n_threshold` value needs to be provided.
- `n_threshold`: The threshold value against which the frequency is to be calculated. This needs to be specified only when the `mode` selected is `user`.

函数 2：

`frequency`: **平均**频率 Computes the reciprocal of the **average** time between two successive midpoint crossings of the **rising** waveform.

```lisp
frequency(
    o_waveform     
    )
    => o_waveform / n_value / nil
```

Example: `frequency( v( "/net12" ) ) => 12kHZ` Returns a number representing the frequency of the specified waveform. 

(Returns a waveform representing the frequency of a family of waveforms if the input argument is a family of waveforms.)

> 也可以参考网上的相关文章：https://zhuanlan.zhihu.com/p/27786161

### 示例：两点一线

> [参考](https://community.cadence.com/cadence_technology_forums/f/mixed-signal-design/38553/straight-line-best-fit-using-viva-calculator)

我们还是以一个简单的[例子](https://community.cadence.com/cadence_technology_forums/f/mixed-signal-design/38553/straight-line-best-fit-using-viva-calculator/1355129)作为开场，比如我们对反相器的转移特性曲线进行了扫描，想要在曲线图中加一条直线，连接这条转移特性曲线的开头和结尾。我们先着重关注有注释解释的代码，暂未注释的代码在后文会继续解释（以下均代码由 Virtuoso 的资深工程师 Andrew Beckett 撰写）：

```lisp
; Output a waveform which just contains the first and last points of the input waveform. 

; def a func called abFirstLastLine, takes one `waveform` object as input
(defun abFirstLastLine (wave)

; `cond` statement to check the type of the input
  (cond

; If `wave` is a `waveform` object
    ((drIsWaveform wave)
     (let (xVec yVec newXVec newYVec len newWave)
       (setq xVec (drGetWaveformXVec wave))
       (setq yVec (drGetWaveformYVec wave))
       (setq len (drVectorLength xVec))
       (setq newXVec (drCreateVec 'double 2))
       (setq newYVec (drCreateVec 'double 2))
       (drAddElem newXVec (drGetElem xVec 0))
       (drAddElem newXVec (drGetElem xVec (sub1 len)))
       (drAddElem newYVec (drGetElem yVec 0))
       (drAddElem newYVec (drGetElem yVec (sub1 len)))
       (putpropq newXVec (getq xVec units) units)
       (putpropq newXVec (getq xVec name) name)
       (putpropq newYVec (getq yVec units) units)
       (putpropq newYVec (getq yVec name) name)
       (setq newWave (drCreateWaveform newXVec newYVec))
       (famSetExpr newWave `(abFirstLastLine ,(famGetExpr wave)))
       newWave
       )
     )
      
; If `wave` is a family of waveforms
    ((famIsFamily wave)
     (famMap 'abFirstLastLine wave)
     )

; Otherwise (if `wave` is neither a waveform nor a family)
    (t
      (error "abFirstLastLine: cannot handle %L\n" wave)
      )
    )
  )
```

#### 基本语法：`defun`, `cond`

在这其中，我们主要学习两条最主要的语法：`defun` 用于定义函数；`cond` 用于 if 判断。我们可以写出一段使用 `defun` 和 `cond` 这两条 lisp 语法的 Hello World:

```lisp
(defun greet (name)
  (cond
    ((equal name "Alice") 
     (print "Hello, Alice!")
     )
    ((equal name "Bob") 
     (print "Hi, Bob!")
     )
    (t          ; 't' 代表 "true"，是默认情况
     (print "Hello, stranger!")
     )
  )
) 

(greet "Alice")  ; 输出: Hello, Alice!
(greet "Bob")    ; 输出: Hi, Bob!
(greet "Charlie"); 输出: Hello, stranger!
```

其在 python 中的等效是：

```python
def greet(name):
  if name == "Alice":
    print("Hello, Alice!")
  elif name == "Bob":
    print("Hi, Bob!")
  else:
    print("Hello, stranger!")

greet("Alice")
greet("Bob")
greet("Charlie")
```

把这一段 SKILL 代码命名成 `greet.il` 后，在 CIW 输入 `load("greet.il")` 执行，会输出：

```lisp
load("test.il")
function greet redefined
"Hello, Alice!""Hi, Bob!""Hello, stranger!"
t
```

我们可以改动 `defun` → `procedure`, `cond` → `case` 以及 `print` → `printf` 实现类似的效果：

```lisp
(procedure (greet name)
  (case name
    ("Alice" (printf "Hello, Alice!\n")    )
    ("Bob"   (printf "Hi, Bob!\n")         )
    (t       (printf "Hello, stranger!\n") )
  )
)
```

#### 变量设置：`set`, `let`


 `let` 和 `setq` 是用来给变量赋值的：

```lisp
(set 'a 5)  ; 将符号 a 赋值为 5, " ' " 用于防止 a 被求值
a           ; 返回 5

(setq b 10)           ; 将 b 赋值为 10 (set Quoted)
(setq c 20 d 30)      ; 同时给 c 和 d 赋值
b  ; 返回 10
c  ; 返回 20
d  ; 返回 30

(let ((x 10)
      (y 20))
  (+ x y))  ; 块内 x 和 y 分别取 10 和 20，结果返回 30
```

再回到之前的代码：

```lisp
;; Declare local variables to store vectors, their lengths, and the new waveform
(let (xVec yVec newXVec newYVec len newWave) 

  ;; Assign the x-vector, y-vector of the input waveform 'wave' to xVec, yVec
  (setq xVec (drGetWaveformXVec wave))
  (setq yVec (drGetWaveformYVec wave))
     
  ;; Get the length (number of elements) of xVec and assign it to len
  (setq len (drVectorLength xVec))

  ;; Create two empty double-precision vector with a length of 2, assign it to newXVec, newYVec
  (setq newXVec (drCreateVec 'double 2))
  (setq newYVec (drCreateVec 'double 2))
     
  ;; Add the first (index 0) and last (index len-1) elements of xVec/yVec to newXVec/newYVec
  (drAddElem newXVec (drGetElem xVec 0))
  (drAddElem newXVec (drGetElem xVec (sub1 len)))
  (drAddElem newYVec (drGetElem yVec 0))
  (drAddElem newYVec (drGetElem yVec (sub1 len)))

  ;; Copy the 'units' and 'name' from the original xVec/yVec to newXVec/newYVec
  (putpropq newXVec (getq xVec units) units)
  (putpropq newXVec (getq xVec name ) name )
  (putpropq newYVec (getq yVec units) units)
  (putpropq newYVec (getq yVec name ) name )

  ;; Create a new waveform 'newWave' object consisting of new X and Y vectors
  (setq newWave (drCreateWaveform newXVec newYVec))

  ;; See below
  (famSetExpr newWave `(abFirstLastLine ,(famGetExpr wave)))

  ;; Return the newly created waveform 'newWave' object
  newWave
)
```

其中有 `famSetExpr` 和 `famGetExpr` 两函数，`fam` 的前缀的意思是 family。在 Virtuoso 中，有四种 strip [分类方式](https://community.cadence.com/cadence_blogs_8/b/cic/posts/virtuosity-organizing-waveform-families)：trace, 特定的扫描变量, family, leaf。具体可以点击链接查看官方介绍。此处我们只需知道  `famSetExpr` 和 `famGetExpr` 两函数是对波形族 (family) 操作的。同时，因为这两个函数是 [private](https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/23155/plotting-within-foreach-loop/1313226) 的，在 SKILL API Finder 中不可见，所以我们只能通过 Andrew Beckett 在 Cadence Community 中发的帖子来推断这两个函数的 arguments 和 return：

- **famSetExpr(waveform1, `waveform2)**
  - Arguments:
    - `waveform1`: A waveform object to be set.
    - `waveform2`: A waveform string? object?
- **famGetExpr(waveform)**
  - Arguments:
    - `waveform`: A waveform object.
  - Return:
    - `waveform`: Returns a waveform string? object?

#### calculator 中的惯例写法

加上 GUI builder information，整段代码就成形了：

```lisp
/* abFirstLastLine.il

Author     A.D.Beckett
Group      Custom IC (UK), Cadence Design Systems Ltd.
Language   SKILL
Date       May 16, 2018 
Modified   
By         

Construct a line between first and last points in waveform.
Not a best fit - just a simple line consisting of just the first
and last points.

Includes function template so this can be added to the calculator
with the "fx" button in the calculator function panel.

***************************************************

SCCS Info: @(#) abFirstLastLine.il 05/16/18.22:55:10 1.1

*/

/*********************************************************************
*                                                                    *
*                       (abFirstLastLine wave)                       *
*                                                                    *
* Output a waveform which just contains the first and last points of *
*                        the input waveform.                         *
*                                                                    *
*********************************************************************/
(defun abFirstLastLine (wave)
  (cond
    ((drIsWaveform wave)
     (let (xVec yVec newXVec newYVec len newWave)
       (setq xVec (drGetWaveformXVec wave))
       (setq yVec (drGetWaveformYVec wave))
       (setq len (drVectorLength xVec))
       (setq newXVec (drCreateVec 'double 2))
       (setq newYVec (drCreateVec 'double 2))
       (drAddElem newXVec (drGetElem xVec 0))
       (drAddElem newXVec (drGetElem xVec (sub1 len)))
       (drAddElem newYVec (drGetElem yVec 0))
       (drAddElem newYVec (drGetElem yVec (sub1 len)))
       ;-----------------------------------------------------------------
       ; Sort out attributes for new waveform to match input
       ;-----------------------------------------------------------------
       (putpropq newXVec (getq xVec units) units)
       (putpropq newXVec (getq xVec name) name)
       (putpropq newYVec (getq yVec units) units)
       (putpropq newYVec (getq yVec name) name)
       (setq newWave (drCreateWaveform newXVec newYVec))
       (famSetExpr newWave `(abFirstLastLine ,(famGetExpr wave)))
       newWave
       )
     )
    ((famIsFamily wave)
     (famMap 'abFirstLastLine wave)
     )
    (t
      (error "abFirstLastLine: cannot handle %L\n" wave)
      )
    )
  )

;
;;;;;;;;;;;;;;;;;;;;;;;;;; GUI builder information ;;;;;;;;;;;;;;;;;;;;;;;;;;;
ocnmRegGUIBuilder(
 '(nil
  function abFirstLastLine
  name abFirstLastLine
  description "Create line between first and last points"
  category ("Custom Functions")
  analysis (nil
      general (nil
        args (wave )
          signals (nil
                wave (nil
                      prompt "Waveform"
                      tooltip "Waveform"
                      )
           )
          params(nil
          )
        inputrange t
      )
  )
  outputs(result)
 )
)
```

### SKILL 基本语法

> [SKILL 语言入门](https://www.cnblogs.com/yeungchie/p/skill_tutorial.html) by yeungchie
> `skdfref.pdf`: Virtuoso Design Environment SKILL Reference

获取函数帮助：`help(asiGetSession)`

todo: 


```text
> Search "asiGetSession", "asiGetCurrentSession", "asiGetOutputList", "asiGetTopCellView", "asiGetDesignVarList", "asiSaveState" "asiInitAnalysis" and "asiGetFormatter" with quotes separately. 
> Answer in Chinese.

在 Virtuoso 中，存在两个主要的会话层次 [ref](https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/56802/difference-between-asigetsession-sevsession-and-sevenvironment-sevsession/1388501)：

1. **asiSession** (**A**nalog **S**imulation **I**nterface Session)：用于底层的模拟器集成接口
   - `asiGetSession` 函数
     - 用于从 GUI 层获取底层的 ASI 会话
     - 传入 ASI 的 session 名称作为参数；不支持 SEV 的 session 作为参数，如 `sevSession` （返回当前会话，而不是预期的会话）
   - `asiGetCurrentSession` 函数
     - 获取当前活动的 ASI 会话，不需要任何参数
     - 如果没有活动的 asi session，返回 `nil`
   - asiGetTopCellView
   - asiGetOutputList
   - asiGetDesignVarList
   - asiSaveState
   - asiInitAnalysis
   - asiGetFormatter
2. **sevSession** (**S**imulation **E**n**v**ironment Session)：用于 GUI 的 ADE
   - 使用 `sevEnvironment` 函数来获取与 `sevSession` 相关联的 ASI 会话


Human Interface [ref](https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/50958/whats-the-difference-between-le-commands-and-hi-commands) [hi App Forms](https://community.cadence.com/cadence_blogs_8/b/cic/posts/skill-for-the-skilled-skill-and-hi-app-forms)

- Form 类
  - 创建表单:
    - hiCreateAppForm() - 创建应用程序表单
    - hiCreateSimpleForm() - 创建简单表单
    - hiCreateOptionsForm() - 创建选项表单
  - 显示表单:
    - hiDisplayForm() - 显示表单
    - hiDisplayFormType() - 显示特定类型的表单
  - 关闭表单:
    - hiFormClose() - 关闭表单
    - hiFormDone() - 完成并关闭表单
  - 获取表单信息:
    - hiGetCurrentForm() - 获取当前活动表单
    - `(hiGetCurrentForm()->hiFormSym)` will return the symbol of the current form
    - ?hiGetFormField() - 获取表单字段
    - ?hiGetFormFieldList() - 获取表单字段列表
  - 设置表单字段:
    - hiSetFormField() - 设置表单字段值
    - hiFormSetFieldEditable() - 设置字段是否可编辑
    - hiFormSetFieldVisible() - 设置字段是否可见
  - 表单回调:
    - hiFormSetCallback() - 设置表单回调函数
    - hiFormCallBack() - 调用表单回调函数
  - 其他常用函数:
    - hiFormGetField() - 获取表单字段值
    - hiFormBuildPopup() - 构建弹出菜单
    - hiFormSetFieldHighlight() - 高亮显示字段
    - hiFormSetFieldColor() - 设置字段颜色
    - hiAddFields() - 动态添加表单字段 `hiAddFields(hiGetCurrentForm(), list("新字段1", "新字段2"))`
    - hiDeleteFields() - 删除指定表单字段 `hiDeleteFields(formHandle, list("旧字段名"))`
```


### 示例：曲线拟合

