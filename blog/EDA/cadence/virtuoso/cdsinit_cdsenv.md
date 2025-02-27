## Virtuoso 中的 `.cdsinit` 和 `.cdsenv`

### 基本介绍

Virtuoso 的配置体系采用分层管理策略，`.cdsinit`与`.cdsenv`作为用户级配置文件，在系统默认配置基础上实现个性化定制。

`.cdsinit` 文件以 lisp 语言为基础，吸收了 Common Lisp 和 Scheme 两种 Lisp 方言的特性，主要负责工具扩展模块的动态加载、快捷键绑定以及用户自定义函数的初始化[1](https://blog.csdn.net/weixin_44951108/article/details/133921228)[3](https://blog.csdn.net/LSTK_LAY/article/details/131250586)。典型的应用场景包括：

- 工艺设计套件(PDK)显示规则文件的自动加载
- 仿真器参数预配置
- 版图验证工具集成

`.cdsenv` 文件则采用 key-value pair 形式管理环境变量，控制工具的基础行为参数[1](https://blog.csdn.net/weixin_44951108/article/details/133921228)[6](https://www.dzsc.com/data/2007-4-30/29147.html)。其核心功能涵盖：

- 图形界面元素的默认参数设置
- 文件系统的路径映射规则
- 仿真结果存储目录定义

两文件的协同工作机制体现在：`.cdsenv` 在 Virtuoso 启动初期加载，建立基础运行环境；`.cdsinit` 随后执行，完成**高级**功能扩展与交互优化。

参考资料：

- Virtuoso 官方文档
  - *Virtuoso Software Licensing and Configuration User Guide*: `dfIIconfig.pdf`
  - 网页链接

本文由 Perplexity Deep Research 完成，笔者审核与补充。


### 文件路径与加载优先级

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
load("./.cdsinit")
```

### 利用 `.cdsinit` 和 `.cdsenv` 自定义 Virtuoso 设置

#### `.cdsenv`

##### 基本介绍

Cadence Virtuoso 的环境变量，简称 cds env，可以通过 Virtuoso CIW 菜单中 Options - Cdsenv Editor 可视化地查看与编辑；而通过 `.cdsenv` 则可以实现在每次启动时自动地设置：

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
```

##### 示例

一个大而全的 `.cdsenv` 配置示例（但有不少字段错误，需要人工核查）：

```scheme
graphic defaultNewViewName string "layout" ; 设置默认新建单元视图类型
graphic cursorStyle string "cross"         ; 十字光标样式


;;;;;;;;;;;;;;;;;; schematic 
schematic srcSolderOnCrossover cyclic "ignored")  ; ignore cross over of wires in schematic
schematic srcInstOverlapValue  int    30)         ; default = 10


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
cdsLibManager.main   showCategoriesOn boolean t        ; lib manager show categories
cdsLibManager.main   showFilesOn      boolean t        ; lib manager show files

;;;;;;;;;;;;;;;;;; spectre
spectre.turboOpts    uniMode          string  "APS"     ; to use spectre APS by default, "Spectre X"
; spectre              numThreads       int     16        ; memory and multithreading config, todo

;;;;;;;;;;;;;;;;;; VIVA ;;;;;;;;;;;;;
; viva.rectGraph       background       string  "white"   ; for older version
viva.graphFrame      background       string  "white"   ; for IC6.1.8 IC23.1 
viva.trace           lineThickness    string  "thick"
; viva.trace           lineStyle        string  "dashed"
viva.horizMarker     font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.horizMarker     interceptStyle   string  "on"
viva.vertMarker      font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.vertMarker      interceptStyle   string  "on"
viva.pointMarker     font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.axis            font             string  "Default,15,-1,5,75,0,0,0,0,0"
viva.traceLegend     font             string  "Default,15,-1,5,75,0,0,0,0,0"

;;;;;;;;;;;;;;;;;; layout ;;;;;;;;;;;;;
layout               xSnapSpacing     float   0.005        ; 0.005um typical for 40nm node
layout               ySnapSpacing     float   0.005        ; 0.005um typical for 40nm node
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
```

#### 常见问题

##### 配置冲突检测

当出现无法解释的工具行为异常时，可采用以下诊断流程：

1. 检查配置加载顺序：`echo $CDS_LOAD_ENV`
2. 验证环境变量继承：`envGetVal("layout" "snapMode")`

### 利用 `.cdsinit` 实现 Calibre 集成

todo

