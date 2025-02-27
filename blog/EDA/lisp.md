# Lisp

Cadence 家的工具大多基于 lisp 语言开发。



`.il` 扩展名的起源可以追溯到该语言的前身 **IL (Interface Language)**。最初，开发 IL 语言是创建 silicon compilers 脚本接口的一部分，其早期名称 SCIL (Silicon Compiler Interface Language) 即由此缩写而来。这个名字发音为“SKIL”，逐渐演变为 **SKILL**。Cadence 官方澄清说，“SKILL”不是首字母缩略词，而是一个注册商标名称，尽管它的血统仍然与 SCIL 和 IL 相关，同时 IL 的历史可能早于 Cadence 成立的时间。从 IL 到 SKILL 的转变标志着该语言角色的转变——从低级接口到全面的 API 和脚本框架。尽管进行了品牌重塑，但 `.il` 扩展名仍然作为 SKILL 源文件的传统约定而存在，反映了它在接口语言时代的根源。

`.il` 扩展名专门表示遵循 **Lisp-2 semantics** 的 SKILL 代码，这是一种命名空间范例，其中函数和变量占据不同的范围。这与使用 **Lisp-1 语义**（函数和变量的单个命名空间）的 `.ils` 文件形成对比。这种区别对开发人员至关重要：Lisp-2 允许函数和变量名称共存而不会发生冲突，而 Lisp-1 需要仔细命名以避免重叠。例如，在 Lisp-2 上下文中，变量 `list` 和函数 `list()` 可以共存，而在 Lisp-1 中，重新定义 `list` 将覆盖该函数。
SKILL++ 是一种增强型方言，具有词法作用域和一等函数等特性，进一步说明了 .il 扩展名的上下文。SKILL++ 代码通常使用.ils扩展名来表示Lisp-1语义，而传统的SKILL则保留.il。这种分叉允许开发人员选择适合其任务的范例——词法作用域用于模块化代码（SKILL++），动态作用域用于快速原型设计（传统SKILL）。

选用 lisp 的可能原因也包括 lisp 的数值计算能力，例如 [LdBeth](https://www.zhihu.com/question/622919986/answer/3222931638) 提到的 $\operatorname{atanh}(1.2 + 20000000i)=\frac{\pi}{2}j$ 这一计算精度问题。
