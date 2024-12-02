# Tcl


## 语法注意点

---

行尾的反斜杠不能有多余的空白字符：

```tcl
# 错误示例：行尾有空格
set incorrect "This is a long command \ 
that will cause a syntax error."
```

发现的背景是在 QuestaSim 中

```tcl
add wave -position insertpoint -group MTP_Interface_Address \ 
    -radix binary   -label ADDR                 sim:/TOP_1_CLK_tb/dut/mtp_interface_inst/ADDR \
    -radix binary   -label rst_n_mtp            sim:/TOP_1_CLK_tb/dut/mtp_interface_inst/rst_n_mtp \
```

因为多加了空格会报错 `# ** UI-Msg (Warning): (vish-4014) No objects found matching ' '.`

---

在同一行中添加注释，需要使用命令分隔符 `;` 来分隔代码和注释

```tcl
set x 5 ; # comment
```

