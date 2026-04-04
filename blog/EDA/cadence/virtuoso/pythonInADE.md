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
setenv PYTHON_HOME /apps/EDAs/cadence/IC23.10.150/tools.lnx86/python
setenv PATH ${PYTHON_HOME}/bin:${PATH}
setenv LD_LIBRARY_PATH ${PYTHON_HOME}/lib:${LD_LIBRARY_PATH}
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


axlGetPointPsfDir(...)
pointSimulationCompleted

### run python


sprintf(nil "test %s test" VARIABLE_A)

atof(system_output_ipc("env -u PYTHONHOME -u PYTHONPATH -u LD_LIBRARY_PATH python -c 'print(1+1)'"))
