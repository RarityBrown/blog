# Layout

## 值得注意的默认 bindkey

---

- bindkey 操作：鼠标选中后按 **<kbd>H</kbd>** 键，移动鼠标 <kbd>Enter</kbd> 确定间距位置，使用 <kbd>.</kbd> 键等距复制
- SKILL 函数接口： `leHiRepeatCopy()`

![Carnac_KELL412Uaj](https://github.com/user-attachments/assets/55762eab-8066-46b6-80cb-9067e8afb2ce)

---

- bindkey 操作：鼠标选中后按 **<kbd>Shift</kbd> + <kbd>c</kbd>** 键，左键框选区域删除
- SKILL 函数接口： `leHiChop()`

---

- bindkey 操作：在 <kbd>p</kbd> 的画线状态下，按住 **<kbd>Ctrl</kbd> + <kbd>Shift</kbd>** 键，**滚动**鼠标滚轮调整线宽
- SKILL 函数接口： `weScaleMagnifierOrIncreaseWidth()`, `weScaleMagnifierOrDecreaseWidth()`

可以通过 `envSetVal("layout" "_weMfgGridWidthIncrement" 'int 2)` 修改步长，更多讨论详见 [Change path width with bindkey](https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/33730/change-path-width-with-bindkey)

但是 Virtuoso 没有默认的 bindkey 去修改已经画完的 path width，我们可以自己定义：

```lisp
;;;;;;;;;; Use scroll wheel to change width of metals. ref: ;;;;;;;;;;;;
;;;;;;;;;; 
deltaWidth=0.01
procedure(changeWidth(delta)
  foreach(shape geGetSelSet()
    if (shape~>objType == "path" then
;                            && car(shape~>lpp) == "Metal1"
        shape~>width = shape~>width + delta
    )
  )
  print(car(geGetSelSet())~>width)
)
hiSetBindKey("Layout" "Ctrl Shift<Btn4Down>" "changeWidth(deltaWidth)")
hiSetBindKey("Layout" "Ctrl Shift<Btn5Down>" "changeWidth(-deltaWidth)")
; todo: minWidth = techGetSpacingRule(techFile layer "minWidth"), deltaWidth check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
```

https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/16029/cadence-5-change-path-width-with-bindkey



> ref:
> 
> - https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/33730/change-path-width-with-bindkey
> - https://www.youtube.com/watch?v=S1vAW0UmOzI
> - https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/16029/cadence-5-change-path-width-with-bindkey
> - https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/58733/skill-code-to-change-metal-width


---

## 值得添加的 bindkey

```lisp

; ref, https://sites.google.com/site/yeagerengineering/cadence/bindkeys
hidKey("Layout"     "<Key>F1"    "printf(\"Help disabled\")")
hiSetBindKey("Schematics" "<Key>F1"    "printf(\"Help disabled\")")
hiSetBindKey("Symbol"     "<Key>F1"    "printf(\"Help disabled\")")
hiSetBindKey("Schematics" "Space"      "if(hiGetCurrentWindow()->cellView->mode != \"r\" then geChangeEditMode(\"r\") else geChangeEditMode(\"a\"))")
hiSetBindKey("Layout"     "Space"      "if(hiGetCurrentWindow()->cellView->mode != \"r\" then geChangeEditMode(\"r\") else geChangeEditMode(\"a\"))")
hiSetBindKey("Symbol"     "Space"      "if(hiGetCurrentWindow()->cellView->mode != \"r\" then geChangeEditMode(\"r\") else geChangeEditMode(\"a\"))")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ref, https://sites.google.com/site/yeagerengineering/cadence/bindkeys
PO_layer=list("PO" "drawing")
M1_layer=list("M1" "drawing")
M2_layer=list("M2" "drawing")
M3_layer=list("M3" "drawing")
M4_layer=list("M4" "drawing")
M5_layer=list("M5" "drawing")
M6_layer=list("M6" "drawing")
M7_layer=list("M7" "drawing")
M8_layer=list("M8" "drawing")
M9_layer=list("M9" "drawing")
AP_layer=list("AP" "drawing")

;; Set entry layer
hiSetBindKey("Layout" "Shift<Key>`" "leSetEntryLayer(PO_layer)")
hiSetBindKey("Layout" "Shift<Key>1" "leSetEntryLayer(M1_layer)")
hiSetBindKey("Layout" "Shift<Key>2" "leSetEntryLayer(M2_layer)")
hiSetBindKey("Layout" "Shift<Key>3" "leSetEntryLayer(M3_layer)")
hiSetBindKey("Layout" "Shift<Key>4" "leSetEntryLayer(M4_layer)")
hiSetBindKey("Layout" "Shift<Key>5" "leSetEntryLayer(M5_layer)")
hiSetBindKey("Layout" "Shift<Key>6" "leSetEntryLayer(M6_layer)")
hiSetBindKey("Layout" "Shift<Key>7" "leSetEntryLayer(M7_layer)")
hiSetBindKey("Layout" "Shift<Key>8" "leSetEntryLayer(M8_layer)")
hiSetBindKey("Layout" "Shift<Key>9" "leSetEntryLayer(M9_layer)")
hiSetBindKey("Layout" "Shift<Key>0" "leSetEntryLayer(AP_layer)")

;; Toggle metal layer visibility
hiSetBindKey("Layout" "Ctrl<Key>`" "leSetLayerVisible(PO_layer not(leIsLayerVisible(PO_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>1" "leSetLayerVisible(M1_layer not(leIsLayerVisible(M1_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>2" "leSetLayerVisible(M2_layer not(leIsLayerVisible(M2_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>3" "leSetLayerVisible(M3_layer not(leIsLayerVisible(M3_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>4" "leSetLayerVisible(M4_layer not(leIsLayerVisible(M4_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>5" "leSetLayerVisible(M5_layer not(leIsLayerVisible(M5_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>6" "leSetLayerVisible(M6_layer not(leIsLayerVisible(M6_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>7" "leSetLayerVisible(M7_layer not(leIsLayerVisible(M7_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>8" "leSetLayerVisible(M8_layer not(leIsLayerVisible(M8_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>9" "leSetLayerVisible(M9_layer not(leIsLayerVisible(M9_layer))) hiRedraw()")
hiSetBindKey("Layout" "Ctrl<Key>0" "leSetLayerVisible(AP_layer not(leIsLayerVisible(AP_layer))) hiRedraw()")

;; Set only one metal layer visible
hiSetBindKey("Layout" "Ctrl Shift<Key>`" "leSetEntryLayer(PO_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>1" "leSetEntryLayer(M1_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>2" "leSetEntryLayer(M2_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>3" "leSetEntryLayer(M3_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>4" "leSetEntryLayer(M4_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>5" "leSetEntryLayer(M5_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>6" "leSetEntryLayer(M6_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>7" "leSetEntryLayer(M7_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>8" "leSetEntryLayer(M8_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>9" "leSetEntryLayer(M9_layer) leSetAllLayerVisible(nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>0" "leSetEntryLayer(AP_layer) leSetAllLayerVisible(nil) hiRedraw()")



M1_pin_layer=list("M1" "pin")
M2_pin_layer=list("M2" "pin")
M3_pin_layer=list("M3" "pin")
M4_pin_layer=list("M4" "pin")
M5_pin_layer=list("M5" "pin")
M6_pin_layer=list("M6" "pin")
M7_pin_layer=list("M7" "pin")
M8_pin_layer=list("M8" "pin")
M9_pin_layer=list("M9" "pin")

;; Make pin layers visible
hiSetBindKey("Layout" "Ctrl Shift<Key>p" "leSetEntryLayer(M1_pin_layer) leSetEntryLayer(M2_pin_layer) leSetEntryLayer(M3_pin_layer) leSetEntryLayer(M4_pin_layer) leSetEntryLayer(M5_pin_layer) leSetEntryLayer(M6_pin_layer) leSetEntryLayer(M7_pin_layer) leSetEntryLayer(M8_pin_layer) leSetEntryLayer(M9_pin_layer) hiRedraw()")

;; Toggle text layer visibility
hiSetBindKey("Layout" "Ctrl Shift<Key>T" "leSetLayerVisible(text_layer not(leIsLayerVisible(text_layer))) hiRedraw()")


;; Toggle all layers visibility
hiSetBindKey("Layout" "Ctrl<Key>q" "leSetAllLayerVisible(t) hiRedraw()")
; hiSetBindKey("Layout" "Ctrl<Key>q" "leSetAllLayerVisible(t) leSetLayerVisible(Mx_layer nil) hiRedraw()")
hiSetBindKey("Layout" "Ctrl Shift<Key>q" "leSetAllLayerVisible(nil) hiRedraw()")


;; Connectivity check
;;
;; Supported operations are:
;; Mark net
;; Unmark net
;;
hiSetBindKey("Layout" "Ctrl <Key>[" "leHiMarkNet(nil)")
hiSetBindKey("Layout" "Ctrl <Key>]" "leHiUnmarkNet(nil)")
hiSetBindKey("Layout" "Ctrl Shift<Key>]" "leHiUnmarkNetAll(nil)")
;;----------------
;; Misc Shortcuts
;;----------------
; XL Probe using `
hiSetBindKey("Layout" "<Key>`" "lxHiProbe()")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
```



