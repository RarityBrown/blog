# set cdsenv

Cadence Virtuoso 有一些默认的设置不是很方便，例如 VIVA 绘图默认背景颜色、线宽等，可以通过在启动 Virtuoso 后 load 一个基于 Lisp 的 SKILL 脚本来自动设置。



简单给出一个设置的语法：

```lisp
envSetVal(toolName       variableName                     'dataType  value)  ; syntax, for instance:
envSetVal("maestro.gui"  "textColorForSpecNearInResults"  'string    "purple")
envGetVal(toolName variableName)  ; syntax, for instance:
labelHeight = envGetVal("layout" "labelHeight")
```

惯用设置 `init.il`:

```lisp
; envSetVal("ui"        "defaultEditorBackgroundColor"     'string "white")
; envSetVal("schematic" "schDynamicNetHilightColorMemNet"  'string "black")

envSetVal("cdsLibManager.main" "showCategoriesOn" 'boolean t)  ; lib manager show categories
ddsOpenLibManager()  ; auto open lib manager
envSetVal("schematic" "srcSolderOnCrossover" 'cyclic "ignored")  ; ignore cross over of wires in schematic
envSetVal("schematic" "srcInstOverlapValue"  'int    30)         ; default = 10
envSetVal("spectre.turboOpts" "uniMode" 'string "APS")           ; to use spectre APS by default, "Spectre X"
envSetVal("viva.rectGraph" "background" 'string "white")
envSetVal("viva.graphFrame" "background" 'string "white")  ; for 6.1.8
envSetVal("viva.trace" "lineThickness" 'string "thick")
envSetVal("viva.horizMarker" "font" 'string "Default,15,-1,5,75,0,0,0,0,0")
envSetVal("viva.horizMarker" "interceptStyle" 'string "on")
envSetVal("viva.vertMarker" "font" 'string "Default,15,-1,5,75,0,0,0,0,0")
envSetVal("viva.vertMarker" "interceptStyle" 'string "on")
envSetVal("viva.pointMarker" "font" 'string "Default,15,-1,5,75,0,0,0,0,0")
envSetVal("viva.axis" "font" 'string "Default,15,-1,5,75,0,0,0,0,0")
envSetVal("viva.traceLegend" "font" 'string "Default,15,-1,5,75,0,0,0,0,0")
```


然后在 Command Interpreter Window (CIW) 直接使用 Lisp 的语法 load 即可:

`load("/home/.../init.il")`
