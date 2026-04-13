background: Matlab Virtuoso Interface need `VM_integ_opt` license, which is not available on my server.

try: get around to use python/matlab inline in ADE Explorer Expression to evaluate the results

### PART 1: call python within ADE Explorer Expression field

register in CIW: 

```lisp
procedure(system_output_ipc(cmd)
  let((cid result)
    cid = ipcBeginProcess(cmd)
    ipcWait(cid 20)   ; 20s before time-out
    result = ipcReadProcess(cid)
    if(result && result != "" then
      car(parseString(result "\n"))
    else
      nil
    )
  )
)


procedure(py_eval_wrapper(scriptPath @rest args)
  let((cmd argStr cid result)
    argStr = ""
    foreach(arg args
      argStr = strcat(argStr " " sprintf(nil "%L" arg))
    )
    cmd = sprintf(nil "cdspy %s %s %s" scriptPath resultsDir() argStr)
    cid = ipcBeginProcess(cmd)
    ipcWait(cid 60)
    result = ipcReadProcess(cid)
    if(result && result != "" then
      atof(car(parseString(result "\n")))
    else
      nil
    )
  )
)
```

try

```lisp
system_output_ipc("matlab -batch 'disp(1+1)'")
system_output_ipc("matlab -batch \\\"disp(1+1)\\\"")
system_output_ipc("env -u PYTHONHOME -u PYTHONPATH -u LD_LIBRARY_PATH python -c 'print(\\\"hello\\\")'")
atof(system_output_ipc("env -u PYTHONHOME -u PYTHONPATH -u LD_LIBRARY_PATH python -c 'print(1+1)'"))
```

in ADE Explorer/Assembler Expression

now we can call python within Maestro. How can we auto export the waveform after simulation finished, let python auto read, let python to evaluate, and finally, let Maestro display the results?

## PART 2: python read pxlxf transient simulation waveform

IC23.1 ISR12 released with a python interface to read waveform called Cdspython-SRR by default. We will use [this](https://community.cadence.com/cadence_technology_forums/f/custom-ic-skill/65326/how-to-run-a-python-script-within-an-ocean-script-and-return-results-to-ade-assembler). 

IC23.1 also packes python3.9 and common libs under `tools.lnx86/python`. so to override RHEL/CentOS built-in python: 


```csh
#!/bin/csh -f
if ( $?CDSHOME ) then
    set CAD_BASE = "$CDSHOME"
else if ( $?cdsdir ) then
    set CAD_BASE = "$cdsdir"
else
    echo "Error: Neither CDSHOME nor cdsdir is defined."
    exit 1
endif

set CAD_ROOT = "${CAD_BASE}/tools.lnx86"
set PY_LIB   = "${CAD_ROOT}/python/64bit/lib"
set TOOL_LIB = "${CAD_ROOT}/lib/64bit"
set CPP_LIB  = "${CAD_ROOT}/TPtools/gcclib-9.3.0/lib64"
setenv LD_LIBRARY_PATH ${PY_LIB}:${TOOL_LIB}:${CPP_LIB}
if ( -e "${CAD_ROOT}/python/64bit/bin/python3" ) then
    exec ${CAD_ROOT}/python/64bit/bin/python3 $argv:q
else
    echo "Error: Python binary not found in $CAD_ROOT"
    exit 1
endif
```



now try `import cdspythonsrr.core.ocean as ocean` in python.

```python
from cdspythonsrr.core.ocean import *
import matplotlib.pyplot as plt
openResults("~/simulation/<lib_name>/<cell_name>/maestro/results/maestro/ExplorerRun.0/1/<lib_name>_<cell_name>/psf")
# openResults("~/simulation/<lib_name>/<cell_name>/maestro/results/maestro/Interactive.1/<corner_num>/<test_name>/psf")
selectResult("tran-tran")
wf = getData("net1")    # net name, or: wf = getData("I2_OUT")

plt.plot(wf["x"], wf["y"])
plt.xlabel(f"{wf['xname']} ({wf['xunit']})")
plt.ylabel(f"{wf['yname']} ({wf['yunit']})")
plt.show()
```

## PART 3: ADE simulation finished callback to python


### get the path where psf stored


resultsDir()
openResults()
maeReadResDB()
selectResult()

asiGetRunDir
maeGetSimulationMessages

```
asiGetPsfDir(asiGetCurrentSession())


axlGetPointPsfDir(axlGetHistoryEntry(axlGetMainSetupDB(axlGetWindowSession()) "ExplorerRun.0") "test_name")
axlGetPointPsfDir(axlGetHistoryEntry(axlGetMainSetupDB(axlGetWindowSession()) axlGetHistoryName(axlGetCurrentHistory(axlGetWindowSession()))) "TestName")
axlGetPointPsfDir(axlGetHistoryEntry(axlGetMainSetupDB(axlGetWindowSession()) axlGetHistoryName(axlGetCurrentHistory(axlGetWindowSession()))) axlGetCurrentTestName(axlGetWindowSession()))


axlGetPointPsfDir(axlGetHistoryEntry(axlGetMainSetupDB(axlGetWindowSession()) axlGetHistoryName(axlGetCurrentHistory(axlGetWindowSession()))) (car(axlGetEnabledTests(axlGetMainSetupDB(axlGetWindowSession())))) ?cornerName axlGetCornerNameForCurrentPointInRun() ?designPointId ocnxlGetPointId())
axlGetPointPsfDir(axlGetHistoryEntry(axlGetMainSetupDB(axlGetWindowSession()) axlGetHistoryName(axlGetCurrentHistory(axlGetWindowSession()))) nth(0 setof(testName cadr(axlGetTests(axlGetMainSetupDB(axlGetWindowSession())))) axlGetEnabled(axlGetTest(axlGetMainSetupDB(axlGetWindowSession()) testName)) )))
axlGetPointPsfDir(axlGetHistoryEntry(axlGetMainSetupDB(axlGetWindowSession()) axlGetHistoryName(axlGetCurrentHistory(axlGetWindowSession()))) car(setof(t cadr(axlGetTests(axlGetMainSetupDB(axlGetWindowSession()))) axlGetEnabled(axlGetTest(axlGetMainSetupDB(axlGetWindowSession()) t)) )) ?designPointId ocnxlGetPointId())

axlGetPointPsfDir(axlGetCurrentHistory(axlGetWindowSession()) asiGetTestName(asiGetCurrentSession()) ?cornerName axlGetCornerNameForCurrentPointInRun() ?designPointId ocnxlGetPointId())

axlGetCornerNameForCurrentPointInRun
```





How to set up and execute a Post Run Simulation OCEAN Script for ADE XL, Explorer, and Assembler simulations https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1Od0000000nXS2EAM&pageName=ArticleContent

### run python


sprintf(nil "test %s test" VARIABLE_A)

atof(system_output_ipc("env -u PYTHONHOME -u PYTHONPATH -u LD_LIBRARY_PATH python -c 'print(1+1)'"))

axlSessionRegisterCreationCallback
asiRegCallBackOnSimComp
runFinishedConclusion
pointSimulationCompleted
