# Note tools for IC

> 对于 IC 行业，应该如何记笔记？CS 行业而言，简单，直接使用 markdown 或者 jupyter notebook。但是如果我想要插入电路图呢？LaTeX 的 tikz 显然太重，也没有人会使用 tikz 进行简单的记录。Visio 似乎是一个经典的选择。但是如果直接图片复制到 markdown 中不仅 markdown 得带上一大堆相对路径的图片（或者 base64 inline，但是也有别的问题），而且丧失了二次编辑的能力：当笔记分享想要修改电路图时，还得要 visio 原文件。
>
> 对于 IC 行业，如何把 MATLAB 的可执行能力插入到笔记中？对于 CS 行业而言，还是简单，因为都用 python 直接 jupyter notebook 或者 obsidian + CodeSuite。但是 IC 行业显然喜欢 MATLAB 一些。也尝试过 matlab 的 `.m` live script 功能。但是总体而言，当代码多于 note 时才会有优势，如果还是文字特别是重公式的文字为主时，笔记体验不佳。 

对于第一个问题，准备发布一个类似于 wavedrom 的基于 json 的 schematic 绘制库。这样用户可以在 obsidian 中通过 WYSIWYG 的方式编辑、渲染，而且是直接通过纯文本存储。

对于第二个问题，似乎只能 fork 一份 CodeSuite 来修改了？
