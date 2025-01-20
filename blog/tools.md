# Tools

## Insert LaTeX equations into PowerPoint

Motivation: PowerPoint 中的 LaTeX 语法支持不完整（Word 比 PowerPoint 略完整一点）：`\sum`, `\cos` 是可以支持的，但 `\frac{1}{2}` 却要打成 `1/2` 才能识别并自动转换。不方便和 Markdown 中的 inline LaTeX 共享公式。

1. 付费的：[MathType](https://www.wiris.com/en/mathtype/), [HoLaTeX](https://holatex.app/), [AxMath](https://www.axsoft.co/) 
2. 基于 PowerPoint 内置的、未公开的 LaTeX 转换接口的：
    - [A LaTeX add-in for PowerPoint by Jeremy Howard](https://www.fast.ai/posts/2019-06-17-latex-ppt.html) 注意光标要在文本框中再点击 `Input LaTeX`，不然会报错
    - [my_ppt_plugin by Achuan-2](https://github.com/Achuan-2/my_ppt_plugin) 基于上面那个开发，功能更多一些
3. 基于本地 LaTeX 编译的
    - [IguanaTex](https://www.jonathanleroux.org/software/iguanatex/): 和传统的 LaTeX 一样，可能会遇到编译问题

一些其他工具：

- WordTEX: 用 Word 创建像 LaTeX 编写的文档
- Beamer


## LaTeX OCR

todo
