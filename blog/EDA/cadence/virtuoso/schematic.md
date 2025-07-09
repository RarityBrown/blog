# Schematic

> ref: https://sites.google.com/site/yeagerengineering/cadence/schematic

Put simply - `<0:n*m>` repeats each bit m times, whereas `<(0:n)*m>` repeats the whole `0:n` range `m` times one after the other. Then you can concatenate them too, and further group them with parentheses, and so on. 

```
x<0:31*4>        -> 0,0,0,0,1,1,1,1,2,2,2,2....,31,31,31,31 
x<(0:31)*4>      -> 0,1,2,3,4,5,6,...31,0,1,2,3,4,5,6,...31,... 
x<(0:31*2)*2>    -> 0,0,1,1,2,2,3,3,...,31,31,0,0,1,1,2,2,3,3,...,31,31 
x<0:31*2,31:0*2> -> 0,0,1,1,2,2,3,3,...,31,31,31,31,30,30,29,29,...,2,2,1,1,0,0 
x<(0:31,31:0)*2> -> 0,1,2,3,4,...,31,31,30,29,...,2,1,0,0,1,2,3,4,...,31,31,30,29,...,2,1,0 
x<8:0:2>         -> 8,6,4,2,0
```

**Parameterized Cells**

- There are two options, `iPar` and `pPar`, to retrieve variable information. `iPar` retrieves information for the instance. `pPar` retrieves information from the parent schematic. You use these as function calls to get a variable (variables are called CDF parameters if they are defined for the instance).
  - Use `iPar("CDF_parameter_name")` in the properties form for the parameter
  - parameterize the gate width with `W=iPar("wp")`

You will also need to update the CDF information for the cell: 

In the ICFB window, Select `Tools - CDF - Edit...`; Browse to your cell; Click "Add" and specify each variable name. String for units is fine, it allows units to be used like "n", "u", etc.

**Defining AD, AS, PD, PS**

dependent parameterized components: use `iPar("CDF_parameter_name")` to inherit parameters from the instance itself. For example, to make the AD of a MOSFET a function of the channel width, defineAD=iPar("w")*5u
