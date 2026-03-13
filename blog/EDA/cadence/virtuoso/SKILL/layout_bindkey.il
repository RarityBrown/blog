;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; layout bindkey ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; basic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hiSetBindKey("Layout"     "F1"              "if( geGetSelSet() then geHiSetSelProtectionEF() else geHiUnsetSelProtectionEF() )")
hiSetBindKey("Layout"     "Shift<Key>x"     "geSave()")

hiSetBindKey("Layout" "Ctrl<Key>R"    "_leRotateOrFlip(\"MX\")")
hiSetBindKey("Layout" "Shift<Key>R"   "_leRotateOrFlip(\"MY\")")

hiSetBindKey("Layout" "Ctrl<Key>H"   "mgc_calibre_realtime_send_highlight_cmd(\"CurrentError\")")
hiSetBindKey("Layout" "Shift<Key>H"  "mgc_calibre_realtime_send_highlight_cmd(\"ClearHighlights\")")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; move obj with arrow keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure(MyMoveSelected(deltax deltay)     ; ref: https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/36295/bindkey-to-move-selected-object
  let((xform)
    xform = list(deltax:deltay "R0" 1)
    foreach(obj geGetSelSet() dbMoveFig(obj nil xform))    ; Don't move the fig, if the selected obj is label pin. Bacause the label will move with the path, and this for loop will move pins twice. 
  )
)
procedure( movingUnit()
  let( ( ( windowId hiGetCurrentWindow() ) bBox width )
    bBox = hiGetViewBBox( windowId )
    width = xCoord( upperRight( bBox ) ) - xCoord( lowerLeft( bBox ) )

    (cond
      ((lessp width 16) 0.005)  ; todo, get the real grid width
      ((lessp width 80) 0.01)
      ((lessp width 160) 0.05)
      ((lessp width 320) 0.2)
      ((lessp width 640) 0.4)
      (t 1.0)
    )
  )
)
hiSetBindKey("Layout" "Left"           "MyMoveSelected(-10*movingUnit() 0)")
hiSetBindKey("Layout" "Right"          "MyMoveSelected(10*movingUnit() 0)")
hiSetBindKey("Layout" "Up"             "MyMoveSelected(0 10*movingUnit())")
hiSetBindKey("Layout" "Down"           "MyMoveSelected(0 -10*movingUnit())")
hiSetBindKey("Layout" "Ctrl<Key>Left"  "MyMoveSelected(-movingUnit() 0)")
hiSetBindKey("Layout" "Ctrl<Key>Right" "MyMoveSelected(movingUnit() 0)")
hiSetBindKey("Layout" "Ctrl<Key>Up"    "MyMoveSelected(0 movingUnit())")
hiSetBindKey("Layout" "Ctrl<Key>Down"  "MyMoveSelected(0 -movingUnit())")

; todo, if geGetSelSet() or geGetSelectedSet() return nil -> move the background as default bindkey



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; layer-cycle show/hide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/***************************************************************************
 * Virtuoso layout layer-cycle bindkeys
 * by gpt-5.4-high
 * 
 * ref: 
 * https://www.edaboard.com/threads/skill-code-sample-on-how-to-hide-and-show-specific-layers.112476/
 * https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/20213/bindkeys-in-ic1-6-5
 * https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/39930/how-to-set-a-bindkey-to-display-multiple-layers
 * https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/11922/how-to-select-and-deselect-a-layer-using-only-one-bind-key
 * https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/20365/viewed-layers
 * https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/25113/script-to-make-visible-dummy-layer-of-those-metal-layers-visible-in-lsw-selection
 * https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/51861/all-layer-visible
 * https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/65643/how-to-set-all-layers-of-a-specific-layer-name-visible-regardless-of-layer-purpose
 * https://transistorized.net/post/stdal/post32.htm
 * https://sites.google.com/site/yeagerengineering/cadence/bindkeys
 * https://bbs.eetop.cn/thread-1001426-1-1.html
 *
 * Notes
 * - Edit the layer-name variables below for your PDK.
 * - The current defaults match your latest description: M1/M2..., PO, NP,
 *   OD, VIA1/VIA2.... If your PDK uses NW instead of NP, change vlcLyrWell.
 * - By default, enabling a layer name enables all of its purposes
 *   (drawing, pin, label, dummy, ...). Set vlcUseAllPurposes=nil if you only
 *   want the "drawing" purpose.
 ***************************************************************************/

vlcUseAllPurposes = t

; Layer-name variables. Change these to match the active PDK.
vlcLyrWell = "NP"
vlcLyrOD   = "OD"
vlcLyrPO   = "PO"

vlcLyrM1 = "M1"
vlcLyrM2 = "M2"
vlcLyrM3 = "M3"
vlcLyrM4 = "M4"
vlcLyrM5 = "M5"
vlcLyrM6 = "M6"
vlcLyrM7 = "M7"

vlcLyrVia1 = "VIA1"
vlcLyrVia2 = "VIA2"
vlcLyrVia3 = "VIA3"
vlcLyrVia4 = "VIA4"
vlcLyrVia5 = "VIA5"
vlcLyrVia6 = "VIA6"

; Map each adjacent metal pair to the via layer that should be shown when both
; metals are visible. Edit this table if your PDK uses different via names.
vlcViaByMetalPair = list(
  list(vlcLyrM2 vlcLyrM1 vlcLyrVia1)
  list(vlcLyrM3 vlcLyrM2 vlcLyrVia2)
  list(vlcLyrM4 vlcLyrM3 vlcLyrVia3)
  list(vlcLyrM5 vlcLyrM4 vlcLyrVia4)
  list(vlcLyrM6 vlcLyrM5 vlcLyrVia5)
  list(vlcLyrM7 vlcLyrM6 vlcLyrVia6)
)

vlcCycleIndexTable = makeTable("vlcCycleIndexTable" 0)
vlcSavedStateTable = makeTable("vlcSavedStateTable" nil)

vlcCycleDefinitions = list(
  list("ctrl_grave"
    list(
      list('layers list(vlcLyrWell vlcLyrOD vlcLyrPO))
      list('all)
    )
  )
  list("ctrl_1"
    list(
      list('layers list(vlcLyrM1))
      list('layers list(vlcLyrM2 vlcLyrM1))
      list('layers list(vlcLyrM1 vlcLyrWell vlcLyrOD vlcLyrPO))
    )
  )
  list("ctrl_2"
    list(
      list('layers list(vlcLyrM2))
      list('layers list(vlcLyrM3 vlcLyrM2 vlcLyrM1))
      list('layers list(vlcLyrM4 vlcLyrM3 vlcLyrM2 vlcLyrM1))
    )
  )
  list("ctrl_3"
    list(
      list('layers list(vlcLyrM3))
      list('layers list(vlcLyrM4 vlcLyrM3 vlcLyrM2))
      list('layers list(vlcLyrM3 vlcLyrM2 vlcLyrM1))
    )
  )
  list("ctrl_4"
    list(
      list('layers list(vlcLyrM4))
      list('layers list(vlcLyrM5 vlcLyrM4 vlcLyrM3))
      list('layers list(vlcLyrM4 vlcLyrM3 vlcLyrM2))
      list('layers list(vlcLyrM4 vlcLyrM3 vlcLyrM2 vlcLyrM1))
    )
  )
  list("ctrl_5"
    list(
      list('layers list(vlcLyrM5))
      list('layers list(vlcLyrM6 vlcLyrM5 vlcLyrM4))
      list('layers list(vlcLyrM5 vlcLyrM4 vlcLyrM3 vlcLyrM2))
      list('layers list(vlcLyrM5 vlcLyrM4 vlcLyrM3 vlcLyrM2 vlcLyrM1))
    )
  )
  list("ctrl_6"
    list(
      list('layers list(vlcLyrM6))
      list('layers list(vlcLyrM7 vlcLyrM6 vlcLyrM5))
      list('layers list(vlcLyrM6 vlcLyrM5 vlcLyrM4 vlcLyrM3 vlcLyrM2))
      list('layers list(vlcLyrM6 vlcLyrM5 vlcLyrM4 vlcLyrM3 vlcLyrM2 vlcLyrM1))
    )
  )
  list("ctrl_7"
    list(
      list('layers list(vlcLyrM7))
      list('layers list(vlcLyrM7 vlcLyrM6))
      list('layers list(vlcLyrM7 vlcLyrM6 vlcLyrM5 vlcLyrM4 vlcLyrM3 vlcLyrM2))
      list('layers list(vlcLyrM7 vlcLyrM6 vlcLyrM5 vlcLyrM4 vlcLyrM3 vlcLyrM2 vlcLyrM1))
    )
  )
)

procedure(vlcGetCurrentCellView()
  let((cv)
    cv = geGetEditCellView()
    unless(cv
      error("vlcGetCurrentCellView: no editable layout window is active.\n")
    )
    cv
  )
)

procedure(vlcGetStateKey(bindName)
  let((win)
    win = hiGetCurrentWindow()
    if(win then
      sprintf(nil "%L::%s" win bindName)
    else
      sprintf(nil "global::%s" bindName)
    )
  )
)

procedure(vlcLookupCycle(bindName)
  let((entry)
    entry = assoc(bindName vlcCycleDefinitions)
    if(entry then
      cadr(entry)
    else
      nil
    )
  )
)

procedure(vlcActionAt(index actions)
  let((i found)
    i = 0
    found = nil
    foreach(action actions
      when(i == index
        found = action
      )
      i = i + 1
    )
    found
  )
)

procedure(vlcStringMember(value values)
  let((found)
    found = nil
    foreach(item values
      when(equal(item value)
        found = t
      )
    )
    found
  )
)

procedure(vlcLppMember(lpp lpps)
  let((found)
    found = nil
    foreach(item lpps
      when(equal(item lpp)
        found = t
      )
    )
    found
  )
)

procedure(vlcAddUniqueString(value values)
  if(vlcStringMember(value values) then
    values
  else
    cons(value values)
  )
)

procedure(vlcExpandLayerNames(layerNames)
  let((expanded viaDef)
    expanded = layerNames
    foreach(viaDef vlcViaByMetalPair
      when(vlcStringMember(car(viaDef) layerNames)
        when(vlcStringMember(cadr(viaDef) layerNames)
          expanded = vlcAddUniqueString(car(cddr(viaDef)) expanded)
        )
      )
    )
    expanded
  )
)

procedure(vlcFirstValidEntryLpp(layerNames @optional (cv geGetEditCellView()))
  let((tf entryLpp candidate)
    tf = techGetTechFile(cv)
    entryLpp = nil
    foreach(layerName layerNames
      unless(entryLpp
        candidate = list(layerName "drawing")
        when(leIsLayerValid(candidate tf)
          entryLpp = candidate
        )
      )
    )
    entryLpp
  )
)

procedure(vlcMakeEntryLayerSwitchable(entryLpp @optional (cv geGetEditCellView()))
  let((tf)
    tf = techGetTechFile(cv)
    when(entryLpp
      when(leIsLayerValid(entryLpp tf)
        leSetLayerVisible(entryLpp t)
        hiRedraw()
        leSetEntryLayer(entryLpp)
      )
    )
  )
)

procedure(vlcCaptureState(@optional (cv geGetEditCellView()))
  let((tf entry visibleLpps)
    tf = techGetTechFile(cv)
    entry = leGetEntryLayer()
    visibleLpps = setof(lpp leGetValidLayerList(tf) leIsLayerVisible(lpp tf))
    list(entry visibleLpps)
  )
)

procedure(vlcRestoreState(state @optional (cv geGetEditCellView()))
  let((tf entry visibleLpps)
    tf = techGetTechFile(cv)
    entry = car(state)
    visibleLpps = cadr(state)

    vlcMakeEntryLayerSwitchable(entry cv)

    foreach(lpp leGetValidLayerList(tf)
      leSetLayerVisible(lpp vlcLppMember(lpp visibleLpps))
    )

    when(entry
      when(leIsLayerValid(entry tf)
        leSetLayerVisible(entry t)
        leSetEntryLayer(entry)
      )
    )

    hiRedraw()
  )
)

procedure(vlcApplyLayerNames(layerNames @optional (cv geGetEditCellView()))
  let((tf expandedLayerNames entryLpp layerName purpose visibleP)
    tf = techGetTechFile(cv)
    expandedLayerNames = vlcExpandLayerNames(layerNames)
    entryLpp = vlcFirstValidEntryLpp(layerNames cv)

    vlcMakeEntryLayerSwitchable(entryLpp cv)

    foreach(lpp leGetValidLayerList(tf)
      layerName = car(lpp)
      purpose = cadr(lpp)
      visibleP = nil

      when(vlcStringMember(layerName expandedLayerNames)
        if(vlcUseAllPurposes then
          visibleP = t
        else
          when(equal(purpose "drawing")
            visibleP = t
          )
        )
      )

      leSetLayerVisible(lpp visibleP)
    )

    when(entryLpp
      when(leIsLayerValid(entryLpp tf)
        leSetLayerVisible(entryLpp t)
        leSetEntryLayer(entryLpp)
      )
    )

    hiRedraw()
  )
)

procedure(vlcShowAll(@optional (cv geGetEditCellView()))
  let((tf)
    tf = techGetTechFile(cv)
    foreach(lpp leGetValidLayerList(tf)
      leSetLayerVisible(lpp t)
    )
    hiRedraw()
  )
)

procedure(vlcApplyAction(action @optional (cv geGetEditCellView()))
  cond(
    (equal(car(action) 'layers)
      vlcApplyLayerNames(cadr(action) cv)
    )
    (equal(car(action) 'all)
      vlcShowAll(cv)
    )
    (t
      error("vlcApplyAction: unknown action type %L\n" car(action))
    )
  )
)

procedure(vlcRunCycle(bindName)
  let((cv actions stateKey stepCount currentStep savedState action)
    cv = vlcGetCurrentCellView()
    actions = vlcLookupCycle(bindName)
    unless(actions
      error("vlcRunCycle: no cycle definition for %s\n" bindName)
    )

    stateKey = vlcGetStateKey(bindName)
    currentStep = vlcCycleIndexTable[stateKey]
    unless(numberp(currentStep)
      currentStep = 0
    )

    stepCount = length(actions)

    when(currentStep == 0
      vlcSavedStateTable[stateKey] = vlcCaptureState(cv)
    )

    cond(
      (currentStep < stepCount
        action = vlcActionAt(currentStep actions)
        vlcApplyAction(action cv)
        vlcCycleIndexTable[stateKey] = currentStep + 1
      )
      (t
        savedState = vlcSavedStateTable[stateKey]
        when(savedState
          vlcRestoreState(savedState cv)
        )
        vlcSavedStateTable[stateKey] = nil
        vlcCycleIndexTable[stateKey] = 0
      )
    )

    t
  )
)

procedure(vlcInstallBindKeys()
  hiSetBindKey("Layout" "Ctrl<Key>`" "vlcRunCycle(\"ctrl_grave\")")
  hiSetBindKey("Layout" "Ctrl<Key>1" "vlcRunCycle(\"ctrl_1\")")
  hiSetBindKey("Layout" "Ctrl<Key>2" "vlcRunCycle(\"ctrl_2\")")
  hiSetBindKey("Layout" "Ctrl<Key>3" "vlcRunCycle(\"ctrl_3\")")
  hiSetBindKey("Layout" "Ctrl<Key>4" "vlcRunCycle(\"ctrl_4\")")
  hiSetBindKey("Layout" "Ctrl<Key>5" "vlcRunCycle(\"ctrl_5\")")
  hiSetBindKey("Layout" "Ctrl<Key>6" "vlcRunCycle(\"ctrl_6\")")
  hiSetBindKey("Layout" "Ctrl<Key>7" "vlcRunCycle(\"ctrl_7\")")
)

vlcInstallBindKeys()
printf("Virtuoso layer-cycle bindkeys loaded.\n")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Define fixed copy spacing (Unit: um), (source drain metal 70nm + space 15nm + gate length 30nm + space 15nm) * 2
defvar( MyCopySpacing 0.26 )
procedure( MyDirectionalCopy( direction )
    let( (cv selSet dx dy newFig newSelSet)
        cv = geGetEditCellView()
        selSet = geGetSelSet()
        if( selSet then
            cond(
                (direction == "right"
                    dx = MyCopySpacing
                    dy = 0.0
                )
                (direction == "left"
                    dx = -MyCopySpacing
                    dy = 0.0
                )
                (direction == "up"
                    dx = 0.0
                    dy = MyCopySpacing
                )
                (direction == "down"
                    dx = 0.0
                    dy = -MyCopySpacing
                )
                (t
                    dx = 0.0
                    dy = 0.0
                )
            )

            newSelSet = nil
            foreach( fig selSet
                newFig = dbCopyFig( fig cv list(dx:dy "R0" 1.0) )
                if( newFig then
                    newSelSet = cons(newFig newSelSet)
                )
            )
            geDeselectAll()
            foreach( fig newSelSet
                geSelectFig(fig)
            )
        else
            printf("Warning: No objects selected!\n")
        )
    )
)

;; =========================================================================
;; Bindkeys Setup
;; =========================================================================
hiSetBindKey("Layout" "Shift Ctrl <Key>Left"  "MyDirectionalCopy(\"left\")")
hiSetBindKey("Layout" "Shift Ctrl <Key>Right" "MyDirectionalCopy(\"right\")")

