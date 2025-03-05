# SKILL & OCEAN

TLDR: 

## SKILL 和 Lisp 的基本介绍 

Cadence 家的工具几乎所有 API 都基于 SKILL 语言开发，SKILL 是以 Lisp 语言为基础，吸收了 Common Lisp 和 Scheme 两种 Lisp 方言特性的脚本语言。部分 SKILL 脚本以 `.il` 为 file extension name，`.il` 扩展名的起源可以追溯到该语言的前身 **IL (Interface Language)**。最初，开发 IL 语言是创建 silicon compilers 脚本接口的一部分，其早期名称 SCIL (Silicon Compiler Interface Language) 即由此缩写而来。这个名字发音为“SKIL”，逐渐演变为 **SKILL**。Cadence 官方澄清说，“SKILL”不是首字母缩略词，而是一个注册商标名称，尽管它的血统仍然与 SCIL 和 IL 相关，同时 IL 的历史可能早于 Cadence 成立的时间。从 IL 到 SKILL 的转变标志着该语言角色的转变——从低级接口到全面的 API 和脚本框架。尽管进行了品牌重塑，但 `.il` 扩展名仍然作为 SKILL 源文件的传统约定而存在，反映了它在接口语言时代的根源。

`.il` 扩展名专门表示遵循 **Lisp-2 semantics** 的 SKILL 代码，这是一种命名空间范例，其中函数和变量占据不同的范围。这与使用 **Lisp-1 语义**（函数和变量的单个命名空间）的 `.ils` 文件形成对比。这种区别对开发人员至关重要：Lisp-2 允许函数和变量名称共存而不会发生冲突，而 Lisp-1 需要仔细命名以避免重叠。例如，在 Lisp-2 上下文中，变量 `list` 和函数 `list()` 可以共存，而在 Lisp-1 中，重新定义 `list` 将覆盖该函数。
SKILL++ 是一种增强型方言，具有词法作用域和一等函数等特性，进一步说明了 .il 扩展名的上下文。SKILL++ 代码通常使用 `.ils` 扩展名来表示 Lisp-1 语义，而传统的 SKILL 则保留 `.il`。这种分叉允许开发人员选择适合其任务的范例——词法作用域用于模块化代码（SKILL++），动态作用域用于快速原型设计（传统SKILL）。

选用 lisp 的原因除了历史原因，可能也包括 lisp 的数值计算能力，例如 [LdBeth](https://www.zhihu.com/question/622919986/answer/3222931638) 提到的 $\operatorname{atanh}(1.2 + 20000000i)=\frac{\pi}{2}j$ 这一计算精度问题。

## CIW (Command Interpreter Window)

- CIW (Command Interpreter Window) 是一个 console (见下表)
- 在 Virtuoso 中执行的所有操作都有对应的 SKILL API 函数进行实现


| Characteristic              | Terminal                         | Shell                           | Console                           | Cadence Virtuoso CIW                |
| --------------------------- | -------------------------------- | ------------------------------- | --------------------------------- | ----------------------------------- |
| **Primary Function**        | Text interface to OS             | Interprets/executes OS commands | Text interface for program/system | Text interface for Cadence Virtuoso |
| **Operating System Access** | Direct                           | Indirect (via terminal)         | Varies, often direct for system   | Indirect, application-specific      |
| **Example**                 | GNOME Terminal, Windows Terminal | Bash, PowerShell                | System console, app command line  | CIW window in Virtuoso              |

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
_axlOutputsSetupDeleteSelected(axlOutputsForm4->axlOutputsWidget4)
_axlShowHideOutputSetupNamedFilterItems(axlOutputsForm4->axlOutputsWidget4 t)
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
```



又或者使用 <kbd>Ctrl</kbd> + <kbd>D</kbd> 直接在 schematic 中添加 vdc 源 （参考 [eetop](https://blog.eetop.cn/blog-1722314-6946097.html), [zhihu](https://zhuanlan.zhihu.com/p/703004089)）

```lisp
procedure(add_vdc( )
   schHicreateInst( ?libraryName "AnalogLib" ?cellName "vdc" ?viewName "symbol" )
)
hisetBindKey("schematics" "Ctrl<Key>d" "add_vdc( ) ")
```


## `.cdsinit` and `.cdsenv`

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
schematic srcSolderOnCrossover cyclic "ignored")  ; ignore cross over of wires in schematic
schematic srcInstOverlapValue  int    30)         ; default = 10
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
adexl.icrpStartup    defaultJobPolicy string "My_jobpolicy"  ; My jobs parallelization policy

;;;;;;;;;;;;;;;;;; VIVA
; viva.rectGraph       background       string  "white"        ; for older version
viva.graphFrame      background       string  "white"        ; for IC6.1.8 IC23.1 
viva.trace           lineThickness    string  "thick"
; viva.trace           lineStyle        string  "dashed"
viva.horizMarker     font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.horizMarker     interceptStyle   string  "on"
viva.vertMarker      font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.vertMarker      interceptStyle   string  "on"
viva.pointMarker     font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.axis            font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.traceLegend     font             string  "Default,15,-1,5,75,0,0,0,0,0"

;;;;;;;;;;;;;;;;;; 
; ui defaultEditorBackgroundColor string "white"   ; todo


;;;;;;;;;;;;;;;;;; layout ;;;;;;;;;;;;;
layout               xSnapSpacing     float   0.005           ; 0.005um typical for 40nm node
layout               ySnapSpacing     float   0.005           ; 0.005um typical for 40nm node
; todo, layoutXL?

; backup and autosave setting, todo
```

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

hiSetFont("ciw"   ?size 16)                      ; CIW font size, greater than 16 is not recommended
hiSetFont("text"  ?size 16)                      ; Toolbar and Menu font size, greater than 16 is not recommended
hiSetFont("label" ?size 16)                      ; simulation font size, greater than 16 is not recommended

hiSetBindKey("explorer"  "Ctrl<Key>N" "_axlAddOutputByTypeCB(_axlGetCurrentSessionDontFail() \"expr\")")
hiSetBindKey("assembler" "Ctrl<Key>N" "_axlAddOutputByTypeCB(_axlGetCurrentSessionDontFail() \"expr\")")
```

#### 常见问题

##### 配置冲突检测

当出现无法解释的工具行为异常时，可采用以下诊断流程：

1. 检查配置加载顺序：`echo $CDS_LOAD_ENV`
2. 验证环境变量继承：`envGetVal("layout" "snapMode")`

### 利用 `.cdsinit` 实现 Calibre 集成

todo

