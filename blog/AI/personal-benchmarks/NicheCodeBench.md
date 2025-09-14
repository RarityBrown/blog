## My Personal Niche Programming Language Benchmark

Including:

1. Niche (programming) languages in the general sense, e.g., AHK (v2), LaTeX (tikz, etc.), PowerShell, MATLAB, Mermaid etc.
2. Niche (programming) languages used in IC, e.g., Assembly, SystemVerilog, Verilog-AMS (Verilog-A), Cadence SKILL, tcl, Wavedrom, SPICE etc.
3. Niche code within widely-used languages, such as WebGPU code in front-end development and some niche libraries in Python

### Niche languages in the general sense

##### MATLAB

<details>
<summary>MATLAB</summary>

> Q: Make `15/9*1e-12` symbolic without any error in matlab within one line. Your answer should be simple.
>
> 典型错误：`expr = sym(15/9 * 1e-12);` 结果有浮点误差
> 
> 正确答案：`expr = 15/9*str2sym('10^(-12)');` 或 `sym(15)/sym(9)*sym(1e-12)` 之类把 1e-12 单独拿出来

</details>

##### Mermaid

<details>
<summary>Mermaid</summary>

> Q: How to print quotes within a node in a Mermaid flowchart? Answer within 1 line in a code block.
>
> 正确答案：`A["Node with #quot;quotes&quot;"]` 或者 `A["This is a #34;quote#34;"]` ref: [link](https://mermaid.js.org/syntax/flowchart.html#entity-codes-to-escape-characters)
>
> 正确情况：o1p 错错错; 4oL 错错错错; secret-chatbot 对对对错错; Sonnet 3.5 错错错错; Gemini 2 Pro 错错错错错错错; r1 错; Gemini 2.5 Pro 错; Kingfall 对
>
> 正确情况 RAG：gpt-4o-search-preview-high 对对; sonar 对
>
> 思考：泛化和对齐未必是好事，也可能增加幻觉（gemini-exp-1114 小概率答对）；说“不会”的能力，目前主流方向是让模型强到没有不会的问题；模型应知道何时调用搜索，如何参考信源


> Q: 第几行代码不符合 Mermaid 语法要求，会导致报错？直接简单回答行号，例如，"2, 30, 31"
> 
> ```
> graph TD
>     subgraph Attempt 4: \genfrac and Prime Symbol
>         V[Use \genfrac or similar construct] --> W(Build vertical arrow with text)
>         W --> X[Consider using prime symbol (') for arrowhead]
>         X --> Y[Probably won't look like an up arrow]
>         AC[Use \left\uparrow and \vphantom to control height] --> AD(Test this approach)
>         AD --> AE[\left and \right are for delimiters, \uparrow has fixed sizes]
>         AE --> AF[Doesn't stretch infinitely, chooses from available sizes]
>     end
> 
>     subgraph Attempt 7: \stackrel, \underset, \overset
>         AG[Consider \stackrel] --> AH(For stacking symbols *over* each other)
>         AH --> AI[User wants text *beside* the arrow]
>         AI --> AJ[\underset and \overset place text above/below]
>         AU[Use \vcenter to center arrow and text] --> AV(Create box with arrow and text side-by-side)
>         AV --> AW[\vcenter centers them vertically, but arrow doesn't lengthen]
>         AW --> AX[Arrow height should match text height]
>         BA --> BB[How to implement without graphicx/TikZ?]
>         BB --> BC[Use \vphantom{#1} to get text height]
>         BC --> BD[But how to stretch arrow vertically?]
>         BE[Arrowhead (\uparrow)] --> BF(Vertical shaft (rule) matching text height)
>         BG --> BH[Standard \uparrow is a compound character]
>         BH --> BI[Break into parts or extend shaft?]
>         BI --> BJ["Draw" arrow: vertical rule + arrowhead]
>         BO --> BP[Use \setbox, \ht, \dp, \dimen, \mkern, \llap]
>         BP --> BQ[Final Code: \newcommand{\xuparrow}[1]{% \setbox0=\hbox{$\scriptstyle#1$}% \dimen0=\ht0 \advance\dimen0 by \dp0 \mathrel{\uparrow\mkern-5mu\rule[-.7ex]{0.4pt}{\dimen0}\llap{$\scriptstyle#1$}}% }]
>         BQ --> BR[Explanation of the code and its limitations]
>         BR --> BS[Acknowledge approximation and need for fine-tuning]
>     end
> 
>     BS --> Final[Final Answer: \boxed{\xuparrow}]
> ```
>
> 正确答案：4, 7, 11, 14, 16, 19, 21, 26, 31

</details>

##### AHK

<details>
<summary>AHK</summary>

> Q: How to send the string "{`\`" (one left brace + one backtick + one backslash + one backtick) in ahkv2 using the `Send` function? Answer within 1 line in a code block.
>
> 正确答案：`Send('{{}``\``')` or `Send "{Raw}{\"` or `Send("{{}" Chr(92))`
>
> 正确情况：Gemini 2 Pro 错错, o3-mini-high 错对错错, o3-mini 错错对, o1 错错, 4oL 对, Haiku 3.5 对对, Sonnet 3.5 对错, r1 对错, Gemini 2.5 Pro 对错, Kingfall 对
>
> 正确情况 RAG：sonar-pro-high 错错


> Q: two ways to simplify this
> 
> ```ahk
> #Requires AutoHotkey >=2.0
>    :?*:1/:: {
>        Send '\frac{{}1{}}{{}{}}{Left 1}'
>    }
>    :?*:2/:: {
>        Send '\frac{{}2{}}{{}{}}{Left 1}'
>    }
>    :?*:3/:: {
>        Send '\frac{{}3{}}{{}{}}{Left 1}'
>    }
>    ; ...
>    :?*:9/:: {
>        Send '\frac{{}9{}}{{}{}}{Left 1}'
>    }
> ```
>
> 参考答案：
>
> ```ahk
> #Requires AutoHotkey >=2.0
> 
> loop 9 {
>     num := A_Index
>     Hotstring(":?*:" . num . "/", "\frac{{}" . num . "{}}}{{}{}}{Left 1}")
> }
>
> #Include RegExHotstring.ahk ; https://github.com/8LWXpg/RegExHotstring/blob/master/RegExHotstring.ahk
> RegExHotstring("(\d+)/", "\frac{{}$1{}}{{}{}}{Left 1}", "?*")
> ```

</details>

##### PowerShell

<details>
<summary>PowerShell</summary>

> Q: How to create a clipboard entry and specify the data type as `text/html` (implemented in PowerShell)? For example, the string "<html><body><sub>x</sub></body></html>", if I copy it directly in the Notepad, I get a `text/plain` clipboard entry.
>
> 正确答案：[CF_HTML](https://learn.microsoft.com/en-us/windows/win32/dataxchg/html-clipboard-format) header info + [System.Windows.Forms.Clipboard Class](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.clipboard) 实现。
>
> 参考答案（最简实现）：
>
> ```powershell
> Add-Type -AssemblyName System.Windows.Forms
> 
> # Note: The HTML/mime specification requires <!--StartFragment--> and <!--EndFragment-->
> $html = "<html><body><!--StartFragment--><sub>x</sub><!--EndFragment--></body></html>"
> 
> # Place the string on the clipboard using the "HTML Format" identifier:
> [System.Windows.Forms.Clipboard]::SetData("HTML Format", $html)
> ```

</details>

##### LaTeX (General LaTeX, MathJax/KaTeX, tikz)

<details>
<summary>LaTeX</summary>

> Q: `A{\scriptstyle{\boxed{A}}}A` box 中的 A 会变小吗？   In the LaTeX expression `A{\scriptstyle{\boxed{A}}}A`, is the boxed "A" rendered smaller? Yes/No without any further explanation.
>
> 正确答案：No
>
> 正确情况：Gemini 2 Pro 错, 4oL 错, Gemini 2.5 Pro 错, Kingfall 错

> Q: Is the LaTeX syntax for the formula `a \xrightarrow[ \begin{subarray}{c}E[x]=0 \\ a\end{subarray} ]{x} b` completely correct, and will it compile without any errors, given that I have `amsmath` properly installed?
>
> 正确答案：No，应当使用 `a \xrightarrow[ {\begin{subarray}{c}E[x]=0 \\ a\end{subarray}} ]{x} b`
>
> 正确情况：Gemini 2.5 Pro 错; o3 错 (但是提到正确写法); o4-mini-high 错

> Q: `\xrightarrow[p+q = a+b+c]{x+y+z = m+n}` How to align at the `=`?
>
> 参考答案：
>
> ```latex
> \xrightarrow[
>   \hspace{-2em}\phantom{x+y+z} p+q = a+b+c \hspace{-2em}\phantom{m+n}
> ]{
>   \hspace{-2em}\phantom{p+q} x+y+z = m+n \hspace{-2em}\phantom{a+b+c}
> } \\
> \xrightarrow[
>   \mathrel{\rlap{p+q}\phantom{x+y+z}}=\mathrel{\phantom{a+b+c}\llap{a+b+c}} 
> ]{
>   \mathrel{\rlap{x+y+z}\phantom{x+y+z}}=\mathrel{\phantom{a+b+c}\llap{m+n}}
> }
> ```
>
> 正确情况：o3-mini-high 错; Gemini 2.5 Pro 半对; Qwen3 235B 错; 

> Q: Draw a cross using `\rule` in latex. The commands `\hfil`, `\vbox`, `\raisebox`, `\rotatebox`, `\makebox`, `\vspace`, `\centerline`, `\noindent`, `\put`, `\par` and `tabular` are not allowed. Width and length of the arms of the cross are 1em and 6em.
>
> 参考答案：
> 
> ```latex
> \rule{1em}{6em}            \hspace{-3.5em}         \rule[+2.5em]{6em}{1em}
> \rule{6em}{1em}            \kern{-3.5em}           \rule[-2.5em]{1em}{6em}
> \rule[-2.5em]{1em}{6em}    \kern{-3.5em}           \rule        {6em}{1em}
> \rlap{\hskip  2.5em \rule[-3em]{1em}{6em}}         \rule[-0.5em]{6em}{1em}  % laps? \smash?
> \rlap{\hspace{2.5em}\rule      {1em}{6em}}         \rule[+2.5em]{6em}{1em}
> ```
>
> 正确情况：Gemini 2.5 Pro 对; gpt-5 对

> Q:
> 
> ```latex
> \[
> \begin{cases} l\ddot{\theta}=g\sin\theta-\ddot{x}\cos\theta  \\ y=x+l_0\sin\theta+n \end{cases} \xRightarrow{\displaystyle \theta \sim 0} \begin{cases} l\ddot{\theta}=g\theta-\ddot{x}  \\ y=x+l_0\theta+n \end{cases} % How to add a new line here?
> \xRightarrow{\displaystyle \mathcal{L}} \begin{cases} Y = \dfrac{(l-l_0)s^2 - g}{s^2(Mls^2-(M+m)g)}(U + R) + N \end{cases}
> \]
> ```
>
> 参考答案：加上 `\begin{gathered}` 或 `\begin{align*}` 等环境
>
> 正确情况：Gemini 2 Pro 对, Sonnet 3.5 错错, grok3 对错; 4oL 错; o3-mini-high 错; Qwen3 对

> Q: The `\rightarrow`, `\xrightarrow{}` and `\uparrow` are commands available in LaTeX, but how to achieve `\xuparrow{}`, a lengthened vertical arrow with text *beside* it, analogous to how `\xrightarrow[\begin{cases}1\\2\end{cases}]{\begin{gather}x+y \\ \sin +\sum \\ x+y+z \end{gather}}` creates a lengthened horizontal arrow with text *above* and *below* it. `amsmath` and `mathtools` are available, but commands `\if` `\else` `\relax` `\sbox` `\setbox` and `\savebox`, and, packages TikZ, `graphicx` and `calc` are not.  (Hint: `\left.\vphantom{#1}\right\uparrow` to achieve extensible arrow.)
> 
> 参考答案：
>
> ```latex
> \newcommand{\xuparrow}[2][]{
>     \hspace{0.3em}{\scriptstyle{#1}}\hspace{-0.3em}
>     \left.\vphantom{#1#2}\right\uparrow
>     \hspace{-0.3em}{\scriptstyle{#2}}\hspace{0.3em}
> }
>
> A \xuparrow[\begin{cases}1\\2\\3\\4\\5\\6\\7\end{cases}]{\begin{aligned}x+y \\ \sin +\sum_i \\ x+y+z \end{aligned}} B
> ```
> 

> Q: Why the `\scriptstyle` does not work for `\scriptstyle{\scriptstyle{\scriptstyle\begin{cases}A \\B+\sum_i \end{cases}+\scriptstyle\begin{aligned}1\\2\\3\end{aligned}}}`? How to make it work without applying `\scriptstyle` to every individual lines?
> 
> 参考答案：目前来看没办法。只能通过 `\scriptsize` 模拟实现。`\mathchoice` `\crampedclap` `\forcedscriptstyle` 等命令也无用。

> Q: How to make $\boldsymbol{\tau_{Y}}$ even bolder without any other formatting change and without `\usepackage{bm}`? Answer within 1 line in a code block.
>
> 参考答案：`\pmb{\boldsymbol{\tau_{Y}}} \boldsymbol{\pmb{\tau_{Y}}}`
>
> 正确情况：4oL 错; grok3 错; o3-mini-high 错; Gemini 2 Pro 对

> Q: How to create a text box with a red border and transparent background in LaTeX? The `\fcolorbox{red}{white}{$\frac{1}{2}$}` is available and what I want, but the background color of it is white. `\tcbox`, `\newtcbox`, TikZ, and mdframed are not available. I don't need environments like `\begin{document}` and so on, just the most crucial part is fine.
>
> 参考答案：`{\color{red}\boxed{\color{black}\frac{1}{2}}}`
>
> 正确情况：Gemini 2.5 Pro 半对

> Q: How inserting a new line within a `\texttt` in LaTeX math mode without `verbatim`, `alltt`, `lstlisting`, `tabular` environment, and `\parbox`, `\ttfamily`, `\par`, `\shortstack`, `\vtop`, `\caption`, `\protect`, `\halign`, `\bgroup`, `\offinterlineskip`, `\put`, `\makebox`, `\noindent`, `\vbox` commands.
>
> 正确答案：There is no direct way, some alternative ways are
> 
> ```latex
> \begin{array}{l}  \texttt{line1} \\  \texttt{line2}  \end{array}
> \begin{aligned}   \texttt{line1} \\  \texttt{line2}  \end{aligned}
>                     \verb|line1| \\    \verb|line2|
> ```

> Q: use CircuiTikz to draw a basic common source without bias or ac coupling
>
> 参考答案：
>
> ```latex
> \ctikzset{
> 	bipoles/thickness=1,  % \ctikzset{resistors/thickness=1}
> 	monopoles/ground/thickness/.initial=1,
> 	monopoles/ground/connectionthickness/.initial=1,
> 	monopoles/tground/thickness/.initial=1,
> 	transistors/thickness=1.618,
> 	% \ctikzset{transistors/scale=1.2}
> 	resistors/scale=0.75,
> 	capacitors/scale=0.65,
> 	transistors/arrow pos=end,
> 	tripoles/mos style/arrows,
> 	tripoles/pmos style/emptycircle,
> 	resistors/zigzag hook/.code={\pgfsetroundcap\pgfsetroundjoin},
> 	resistors/zigzag stub=0.02,
> }
> 
> \begin{circuitikz}[american, line width=1.6pt]
>     % \draw (0,0)                                   node[nmos, font=\sffamily\bfseries] (M1)  {M1};
> 	    % \draw (0,0)                                   node[nmos] (M1)  {\textbf{\fontfamily{phv}\selectfont M1}};
>     \draw (0,0)                                   node[nmos] (M1)  {\textbf{\fontspec{Segoe UI}M1}};
>     \draw (M1.gate)    to [short, -o]   ++(-1,0)  node[left]       {$V_{in}$};
>     \draw (M1.source)                             node[tlground]   {};
>     \draw (M1.drain)   to [R=$R_D$]     ++(0,2)   node[tground]    {$V_{DD}$};
>     \draw (M1.drain)   to [short, *-o]  ++(1,0)   node[right]      {$V_{out}$};
> \end{circuitikz}
> ```

> Q: use CircuiTikz to draw a basic two-stage amplifier in CMOS with differential input and common source output
>
> 参考答案：
>
> ```latex
> \begin{circuitikz}[american, line width=1.6pt]
> 	\draw[help lines] (0,0) grid (6,6);
> 	
> 	% Stage 1: Differential pair with current mirror load
> 	\draw
> 	(0,4) node [pmos, xscale=-1] (M3) {\ctikzflipx{$M_3$}}
> 	(2,4) node [pmos] (M4) {$M_4$}
> 	(M3.source) -- ++(0,0.2) coordinate (vdd1)
> 	(M4.source) -- ++(0,0.2) coordinate (vdd2)
> 	% (vdd1) -- (vdd2)
> 	(M4.gate) -- (M3.gate)
> 	(M4.gate) |- (M3.drain);
> 	
> 	\draw
> 	(0,2) node [nmos] (M1) {$M_1$}
> 	(2,2) node [nmos, xscale=-1] (M2) {\ctikzflipx{$M_2$}}
> 	(M1.drain) -- (M3.drain)
> 	(M2.drain) -- (M4.drain)
> 	(M1.gate) to[short, -o] ++(-0.2,0) node[left] {$V_{in}^-$}
> 	(M2.gate) to[short, -o] ++(0.2,0) node[right] {$V_{in}^+$};
> 	
> 	\draw
> 	($(M1.source)!0.5!(M2.source)$) ++(0,-0.5) node[nmos, anchor=drain] (M5) {$M_5$} % Corrected: Anchor at drain
> 	(M5.source) -- ++(0,-0.2) coordinate (gnd1)
> 	(M1.source) -| (M5.drain)
> 	(M2.source) -| (M5.drain)
> 	(M5.gate) to[short, -o] ++(-0.5,0) node[left] {$V_{bias1}$};
> 	
> 	% Stage 2: Common source amplifier
> 	\draw
> 	(6,0) node [nmos] (M6) {$M_6$}
> 	(6,4) node [pmos] (M7) {$M_7$}
> 	(M7.source) -- ++(0,0.2) coordinate (vdd3)
> 	(vdd1) -- (vdd3) node[above] {VDD} % VDD track
> 	(M6.source) -- ++(0,-0.2) coordinate (gnd2)
> 	(gnd1) -- (gnd2) node[below] {GND} % GND track
> 	(M6.gate) to[short, -o] ++(-0.7,0) node[left] {$V_{bias2}$}
> 	(M6.drain) -- (M7.drain)
> 	(M6.drain) -- ++(0, 1.23) to[short, -o] ++(1,0) node[right] {$V_{out}$};
> 	
> 	% connect two stage
> 	\draw (M4.drain) |- ++(1,-0.23) coordinate (Vo1) -- ++(1/3,0)  to[R=Rz] ++(4/3,0) to[C=Cc] ++(4/3,0);
> 	\draw (Vo1) |- (M7.gate);
> \end{circuitikz}
> ```

</details>

### Niche languages used in IC

##### Assembly

<details>
<summary>Assembly</summary>

> Q: `.long   -1559429120` to hex
>
> 正确答案：`0xA30D0000`
>
> 正确情况：sonnet 3.7 thinking 错对错; o3-mini 对对错; 2-flash-thinking 错

> Q: x87 FPU + GCC. LC0 in decimal? Do not use scientific notation, write out the entire number directly.
> 
> ```assembly
> .LC0:
>         .long   -1559429120
>         .long   -1834274295
>         .long   16433
>         .long   0
> ```
> 
> 正确答案：`1,290,111,812,442,216`  `1290892312867076`
>
> 正确情况：sonnet 3.7 thinking 错错; o3-mini 错错; Gemini 2.5 Pro 错错; o3-mini-high 对; lunarcall 对

</details>

##### Lisp (Cadence SKILL)

<details>
<summary>SKILL</summary>

<details>
<summary>General Lisp</summary>


```python
def greet(name):
  if name == "Alice":
    print("Hello, Alice!")
  elif name == "Bob":
    print("Hi, Bob!")
  else:
    print("Hello, stranger!")

greet("Alice")
greet("Bob")
greet("Charlie")
```

refactor to Cadence Virtuoso SKILL

> 参考答案：
> 
> ```lisp
> (defun greet (name)
>   (cond
>     ((equal name "Alice") 
>      (print "Hello, Alice!")
>      )
>     ((equal name "Bob") 
>      (print "Hi, Bob!")
>      )
>     (t
>      (print "Hello, stranger!")
>      )
>   )
> ) 
> (procedure (greet name)
>   (case name
>     ("Alice" (printf "Hello, Alice!\n")    )
>     ("Bob"   (printf "Hi, Bob!\n")         )
>     (t       (printf "Hello, stranger!\n") )
>   )
> )
> 
> (greet "Alice")
> (greet "Bob")
> (greet "Charlie")
> ```
>
> 正确情况：Gemini 2 Pro 错; r1 对; grok-3 对; Gemini 2.5 Pro 对; GPT4.5 对



Q: Write a function for me in Cadence SKILL: For an input less than 16, return 0.005; for 16–80 return 0.01; for 80–160 return 0.05; for 160–320 return 0.2; for 320–640 return 0.4; for greater than 640 return 1

参考答案：

```lisp
procedure (mapping x)
  (cond
    ((lessp x 16) 0.005)
    ((lessp x 80) 0.01)
    ((lessp x 160) 0.05)
    ((lessp x 320) 0.2)
    ((lessp x 640) 0.4)
    (t 1.0)
  )
; or
(defun mapping (x)
  (cond
    ((x < 16) 0.005)
    ((x < 80) 0.01)
    ((x < 160) 0.05)
    ((x < 320) 0.2)
    ((x < 640) 0.4)
    (t 1.0)
  )
)
```

正确情况：Gemini 2.5 Pro 对; k2-0905 对; opus-4.1 对


</details>

<details>
<summary>SKILL-Specific</summary>


</details>

</details>

##### Verilog (SystemVerilog, Verilog-AMS, etc.)

<details>
<summary>Verilog</summary>

> Q:
> ```verilog
> module shiftreg_PA_rev (
>     output reg A, 
>     input E, clk, rst
> );
>     reg B, C, D;
>     always @ (posedge clk, posedge rst) begin
>         if (rst == 1'b1) begin A = 0; B = 0; C = 0; D = 0; end
>         else begin
>             D = E;
>             C = D;
>             B = C;
>             A = B;
>         end
>     end
> endmodule
> ```
> 
> Schematic of this code?
>
> 典型错误：4-bit 的 serial shift regs。因为 module 名称也具有误导性。
> 
> 正确答案：因为是阻塞赋值，其实是一个 A = E 的 1-bit DFF

<!-- 太简单了，淘汰
> QC:
> ```verilog
> module simple_moore_fsm(
>     input wire clk,
>     input wire rst_n,
>     input wire x,
>     output reg y
> );
>     parameter S0 = 1'b0;
>     parameter S1 = 1'b1;
> 
>     reg current_state, next_state;
> 
>     always @(posedge clk or negedge rst_n) begin
>         if (!rst_n) current_state <= S0;
>         else        current_state <= next_state;
>     end
> 
>     always @(*) begin
>         case (current_state)
>             S0: begin
>                 if (x) next_state = S1;
>                 else   next_state = S0;
>             end
>             S1: begin
>                 if (x) next_state = S1;
>                 else   next_state = S0;
>             end
>             default: next_state = S0;
>         endcase
>     end
> 
>     always @(*) begin
>         case (current_state)
>             S0: begin
>                 if (x) y = 1'b1;
>                 else   y = 1'b0;
>             end
>             S1: begin
>                 if (x) y = 1'b0;
>                 else   y = 1'b1;
>             end
>             default: y = 1'b0;
>         endcase
>     end
> 
> endmodule
> ```
>
> 这段代码是 Moore FSM 还是 Mealy FSM？这段代码为什么是 Moore FSM?
>
> 正确答案：Mealy FSM
> 
> 正确情况：Sonnet 3.5 对; o1-mini 对对, llama-3.1-405b / 3.3-70b 对对对对, 4oL-20250326 对, 3-opus 对, 2-flash-thinking 对; Gemini 2.5 Pro 对; v3-0324 错; stargazer 对
-->

> Q: Write a Verilog-A model for a 12-input AND gate using a vector input.


Q: 

Write a Verilog-AMS 13-Bit Synchronous Pattern Generator: This module generates a finite, 240-cycle digital pattern on a 13-bit output bus, `D[12:0]`, without any comment.

The module is synchronous and updates its output state on the falling edge of the `CLK` input. The clock input threshold (vth) is defined as (V_HIGH+V_LOW)/2. It generates a 240-cycle pattern, after which the output holds the final state.

Generated Pattern Sequence: Cycles 0-79: An up-counter, from 0 to 79; Cycles 80-159: A 13-bit pseudo-random value. The sequence must be reproducible (i.e., generated from a fixed seed); Cycles 160-239: A down-counter for 80 cycles, starting from 13-bit all ones.

Output Waveform Specifications: V_HIGH: 1.0 V; V_LOW: 0.0 V; rise_time = fall_time = 50 ps

正确情况：Gemini 2.5 Pro 错错; Grok 4 错; Opus 4 错

```verilog
`include "constants.vams"
`include "disciplines.vams"

module decimator_data_stimuli (CLK, D);
    // Port declarations
    input             CLK;
    output     [12:0] D;
    electrical        CLK;
    electrical [12:0] D;
    
    // Parameters
    parameter real    V_HIGH    = 1.0;
    parameter real    V_LOW     = 0.0;
    parameter real    rise_time = 50e-12;
    parameter real    fall_time = 50e-12;
    parameter integer seed      = 12345; // Fixed seed for reproducibility
    
    // Internal variables
    integer cycle_count;
    integer pattern_value;
    integer random_seed;
    integer i;
    real vth;
    real clk_prev;
    
    analog begin
        @ (initial_step) begin
            cycle_count = 0;
            pattern_value = 0;
            random_seed = seed; // Initialize random seed
            clk_prev = V(CLK);
            vth = (V_HIGH + V_LOW) / 2;
        end
        
        @ (cross(V(CLK) - vth, -1)) begin  // Detect falling edge of CLK
            if (cycle_count < 240) begin   // Generate pattern based on cycle count
                if (cycle_count < 80) begin
                    // Cycles 0-79: Up-counter
                    pattern_value = cycle_count;
                end
                else if (cycle_count < 160) begin
                    // Cycles 80-159: Pseudo-random using $dist_uniform
                    pattern_value = $dist_uniform(random_seed, 0, 8191); // 0 to 2^13-1
                end
                else begin
                    // Cycles 160-239: Down-counter starting from 13'h1FFF
                    pattern_value = 13'h1FFF - (cycle_count - 160);      // After 240 cycles, hold the final value (which would be 13'h1FB0)
                end

                cycle_count = cycle_count + 1;  // Increment cycle counter
            end
        end
    end

    genvar bit; 
    generate   // Generate output voltages with specified rise/fall times
        for (bit = 0; bit < 13; bit = bit + 1) 
            analog begin
                V(D[bit]) <+ transition(((pattern_value >> bit) & 1) ? V_HIGH : V_LOW, 0, rise_time, fall_time);
            end
    endgenerate

endmodule
```

Q: https://zhuanlan.zhihu.com/p/1948107481772425798

</details>

##### SPICE (circuit)

<details>
<summary>SPICE</summary>

- https://arxiv.org/html/2502.07980v1
- https://arxiv.org/html/2507.19525v1
- https://link.springer.com/article/10.1007/s40593-025-00501-w

</details>

### Niche code within widely-used languages

#### Webarena & 前端

##### 基础知识 + 前端代码

<details>
<summary>基础知识 + 普通前端代码</summary>


###### 物理模拟

- 画一个 2 阶 RC 低通滤波器的电路图和频响图 Draw the schematic and frequency response (mag & phase) of a 2nd order RC low-pass filter. Make it interactive.
- 二阶系统阶跃响应减幅振荡示意图，同时画出系统 bode 图。把 Damping Ratio (ζ) 和 Natural Frequency (ωn) 做成可调的。用 mathjax 实时显示系统函数
- An interactive s-plane where left-clicking adds poles (for a physically realizable system, if poles are not real, they should be automatically added in conjugate pairs), and right-clicking adds zeros. The s-plane uses log-log coordinate axes (tick marks use engineering notation, e.g., 1k, 2k, 1M, 1G) to represent the real and imaginary parts. Plot the frequency response H(jω) in real-time (including magnitude response, phase response, DC gain, GBW, phase margin, and other information).
- Smith chart, polar coordinates charts (Γ Plane and Impedance Plane), Cartesian coordinates charts (Γ Plane and Impedance Plane) one-to-one interactive correspondence + contour, with real-time incident and reflected wave demonstration.      An interactive Smith chart explorer with corresponding polar and Cartesian charts with contours for both the Γ plane and impedance plane. The charts should be synchronized one-to-one. Plus real-time incident and reflected wave demonstration.
- An interactive phased array demo.
- An **interactive** demo for **principles** of BLDC and PMSM. So having only fancy animations is not enough and lengthy theoretical text is useless.
- An Interactive Newton's cradle with adjustable number of balls and wire length. The UI should be extremely simple, but the physics must be extremely realistic, considering non-ideal factors such as resistance, etc.
- An interactive second-order inverted pendulum on a cart simulation with random noise and damping. Add automatic control algorithm without any manual parameter adjustment by the user. You automatically determine the algorithm type and parameters; the user only needs to turn the algorithm on or off with a single button. At the same time, when the algorithm is enabled, allow the user to manually apply external force disturbances to test the robustness of the algorithm.
- Simulate the movement of multiple positive and negative charged particles within a square, with an electric field pointing to the right and a magnetic field pointing into the screen. The interaction forces between each particle need to be considered.
- Build a real-time microphone spectrum visualizer, with historical data also displayed. Use color as intensity, with one axis being frequency and the other being time. Place the historical maximum, sub-maximum, current maximum, and sub-maximum values in real-time on the plane. And add a 3d chart side by side, use z axis to represent the intensity instead of color, x and y as frequency and time without three.js.


###### 普通开发

<details>
<summary>普通开发</summary>

- A replica of wavedrom in D3.js (real-time rendering + syntax highlighting for code)
- A circuit schematic editor. Use key `i` to new an instance choosing dialog. The symbol of the circuit component should be drawn correctly

> Q: 
Build a replica of cadence virtuoso viva using D3.js
1. Multiple stripes (share the same x axis, share or not share the same y axis, configurable), multiple subwins (called configurable grid view in software engineering?) should be supported. 
2. shift+scroll, ctrl+scroll to zoom in and out on the x and y axis; <kbd>f</kbd> to fit
3. <kbd>v</kbd> and <kbd>h</kbd> should be supported. <kbd>v</kbd> creates a vertical marker which is a vertical line spanning all stripes on the same subwin that intersects the waveform on the same subwin, allowing to read the x-axis value at a specific point; <kbd>h</kbd> key creates a horizontal marker which is a horizontal line that intersects the waveform on one stripe, enabling to identify the points at which the signal reaches a specific y-axis value.
4. right-click to set each axis (log, linear, etc.), and to set line styles (thickness, etc.) should be supported. 
5. performance optimization for millions of data points

- A 108-key full-size keyboard tester. Once a key is pressed, the corresponding virtual key permanently changes color to indicate it is working, rather than temporarily highlighting.  注意：F1 不打开帮助; ctrl, win(meta), shift, capslock, ins, home 等特殊键
- 帮我把这个改一些不兼容的语法后，部署一下，要求和原来完全保持一致    https://observablehq.com/@mbostock/smith-chart
- Bing replica
- An online office word
- A hex (binary) editor
- Tangram puzzle game
- An interactive 3D bicycle (not a 2D model in 3D space. I want a real 3D bicycle with thickness.)                 ref: https://ciechanow.ski/bicycle/
- An interactive SVG introduction. Unlike raster images, SVGs can be embedded directly into HTML, allowing their elements, such as <circle> and <rect>, to be styled and animated with CSS and JavaScript. The guide explains fundamental shapes and emphasizes using the viewBox attribute to ensure graphics are truly scalable. It also demonstrates how to use presentational attributes like stroke and stroke-dasharray to create dynamic effects, such as self-drawing animations, making it a powerful tool for web development.                   ref: https://www.joshwcomeau.com/svg/friendly-introduction-to-svg/
- An interactive planar MOSFET 3d model with 2 fingers

also demonstrates how to use presentational attributes like stroke and stroke-dasharray to create dynamic effects, such as self-drawing animations, making it a powerful tool for web development.


</details>

###### Long live the svg

- Draw svg of transmission gate in mosfets and symbol without any fancy ui or color, without further introduction, so just two simple svgs.
- 用 svg 画一个单级单管共栅级放大电路的小信号电路图
- 用 svg 画出 $I_{in1}-I_{in2}=\dfrac{I_{SS}}{V_{ov}}(V_{in1} - V_{in2})\sqrt{1 - \dfrac{(V_{in1}-V_{in2})^2}{{4V_{ov}^2}}}$ 的函数图像，横纵坐标啥的都可以不需要，就曲线就行。取 x = (V_in1 - V_in2)/V_ov ∈ [-√2, √2], 对于 |x|> √2 的部分取 |x|=√2。画三条线，一条 is=vov=1，一条 is=1.5, vov=1, 一条 is=1.2, vov=1.2。不要使用 script
- `<svg width="100" height="120" viewBox="0 0 100 120" xmlns="http://www.w3.org/2000/svg"><line x1="30" y1="30" x2="30" y2="90" stroke="black" stroke-width="2" /><line x1="40" y1="30" x2="40" y2="90" stroke="black" stroke-width="2" /><line x1="40" y1="30" x2="70" y2="30" stroke="black" stroke-width="2" /><line x1="70" y1="10" x2="70" y2="30" stroke="black" stroke-width="2" /><line x1="50" y1="90" x2="70" y2="90" stroke="black" stroke-width="2" /><line x1="70" y1="90" x2="70" y2="110" stroke="black" stroke-width="2" /><polygon points="50,90 40,85 40,95" fill="black" /><text x="20" y="60" font-family="Arial" font-size="12" text-anchor="end">G</text><text x="75" y="15" font-family="Arial" font-size="12">D</text><text x="75" y="110" font-family="Arial" font-size="12">S</text></svg>` 这个 NMOS 的画法有一个错误，帮我修正一下。
  - 正确答案：把 `<polygon points="50,90 40,85 40,95" fill="black" />` 改成 `<polygon points="70,90 60,85 60,95" fill="black"/>`; `<line x1="50" y1="90" x2="70" y2="90" stroke="black" stroke-width="2"/>` 改成 `<line x1="40" y1="90" x2="70" y2="90" stroke="black" stroke-width="2"/>`
  - 正确情况：gpt-5-high 错; grok4 错; Gemini 2.5 Pro 错




##### 库的使用

<details>
<summary>库的使用</summary>


- A modern browser technology playground: Showcase all emerging, fancy, modern browser technologies. Do not consider compatibility issues at all.
- A *minimalistic* milkdown (a **WYSIWYG** markdown editor) demo      or: vditor
- A simple mathjax v3 CHTML demo with ams macros and physics macros enabled.
- MathJax vs KaTeX Renderer side by side, with a syntax highlight latex input box. **Enable the `physics` package in mathjax.**
- 2x2 layout: mathlive + latex code editor (with syntax highlight); mathjax + katex (to compare the rendered output). Enable all the possible packages for mathjax and katex. For instance, enable the `physics` package in mathjax.
- An interactive jsPDF + PDF.js pdf preview + iframe pdf preview demo
- An interactive GoJS + GSAP demo
- A real-time rendering mermaid diagram demo with a syntax highlighting code editor
- A demo for Shiki vs Prism.js vs Highlight.js side by side with minimalistic UI. I'm mainly looking at the actual comparison demo between the three, not superficial things like comparison tables or comparison section. Language: Verilog, tcl and lisp, with a code input area where users can modify the code or the code types. Dark theme + light theme, unify the syntax highlighting scheme.
- A minimalistic LaTeX syntax highlighting demo using monaco and @shikijs/monaco
- Editor Playground to try out Monaco, CodeMirror and Ace editor side by side. Sync the code among the three. Dark theme + light theme. It would be best to unify the syntax highlighting scheme and font size in the editor.
- 
- Build a plotting app to draw the graph of Math.random(x)*(Math.sin(x) + Math.random(x)), with a total of 20,000 points, where x in [0,50), refreshing the random data every 5 seconds. Time and display how long it takes to refresh the data and redraw the plot each time. Supports cursor-centric zoom on the x-axis using the mouse wheel, with no zoom on the y-axis. Choose any plot lib you'd like, the only goal is to be fast. > NOTE: For accurate timing, measure the full operation. Since some UI updates are asynchronous, stop the timer in a completion callback or post-render hook, not immediately after the dispatch call. This avoids measuring only the initial synchronous task, capturing the true, user-experienced duration from start to final render. Meanwhile, use a red and a green light to indicate the start and completion of rendering for user confirmation.
- A minimalistic KaTeX demo with `mhchem` enabled.
  - 正确情况：opus-4 都不行，让我很震惊。看来 Agent 确实是必经之路。

```tsx
// src/App.tsx
import React, { useEffect, useRef, useState } from 'react';
import katex from 'katex';
import 'katex/dist/katex.min.css';
import 'katex/dist/contrib/mhchem.js';

function UltraMinimalKatexMhchem() {
  const [latexInput, setLatexInput] = useState('\\ce{H2O}+\\sin x');
  const katexOutputRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const outputElement = katexOutputRef.current;
    if (outputElement) {
      try {
        katex.render(latexInput, outputElement, {
          displayMode: true,
          throwOnError: false,
        });
        outputElement.style.color = 'inherit';
      } catch (error) {
        outputElement.textContent = 'Error';
        outputElement.style.color = 'red';
      }
    }
  }, [latexInput]);

  return (
    <div>
      <div
        ref={katexOutputRef}
        style={{
          margin: '10px 0',
          fontSize: '1.3em',
          textAlign: 'center',
        }}
      ></div>
      <textarea
        rows={3}
        value={latexInput}
        onChange={(e) => setLatexInput(e.target.value)}
        placeholder="Input"
        style={{
          fontFamily: 'monospace',
          fontSize: '14px',
          display: 'block',
          width: '90%',
          maxWidth: '600px',
          margin: '10px auto',
          padding: '5px',
        }}
      />
    </div>
  );
}

export default UltraMinimalKatexMhchem;
```

katex 的 `mhchem` 没有生效，现在显示的 `\ce` 是红色的报错模式。如果把临时将代码中 throwOnError 设为 true 时，console 会报错  `ParseError: KaTeX parse error: Undefined control sequence: \ce at position 1: \ce{H2O}`。已知信息：

- 用最新稳定版的 vite 来开发一个 electron + react 应用，`vite.config.js` 的配置是项目生成时自动创建的默认配置，没有修改过
- KaTeX 用的是最新稳定版，正确安装，并只安装一个版本。其他 katex 功能都是正常的，如 `\sin x`
- "node_modules/katex/dist/contrib/mhchem.js" 确实存在，"node_modules/katex/contrib/mhchem.js" 也存在，但是换用 import 'katex/contrib/mhchem.js' 了以后 react 应用反而直接报错了，至少现在不报错
- `(window as any).katex = katex;` 放在导入 js 之前也试过了，没用。

正确答案：`import 'katex/dist/contrib/mhchem.mjs';`



</details>

###### WebGL & WebGPU

- An interactive (adjustable input points for FFT, configurable zero-padding, configurable input waveform, etc.) 1D FFT demo using WebGPU. Display performance metrics.
  - 2d ref: https://barthpaleologue.github.io/Blog/posts/ocean-simulation-webgpu/
- Four WebGL demos arranged in a 2x2 grid. The top row contains 2D WebGL demos: on the left, a @react-three demo; on the right, a pure WebGL demo. The bottom row contains 3D WebGL demos: on the left, aa @react-three demo; on the right, a pure WebGL demo.
An interactive test page comparing the rendering performance of WebGPU and WebGL2. Demands a certain pressure on gpu; don't have both tests come out at 60 fps.
- An interactive test page comparing the rendering performance of WebGPU and WebGL2. Demands a certain pressure on gpu; don't have both tests come out at 60 fps.
- Wrap a multi-page PDF onto an ellipsoid, and let the user scroll through the PDF in real time with the mouse wheel instead of scaling the ellipsoid.

</details>

#### Python 小众库

<details>
<summary>Python 小众库</summary>

> Q: 在 R3 的左侧，即 R4 的下侧，添加一个接地符号
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += elm.Resistor().label('R1')
>     d += elm.Resistor().label('R2').down()
>     d += elm.Resistor().label('R3').left()
>     d += elm.Resistor().label('R4').up()
> d.draw()
> ```
> 
> 参考答案：
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += elm.Resistor().label('R1')
>     d += elm.Resistor().label('R2').down()
>     R3 = elm.Resistor().label('R3').left()
>     d += R3
>     d += elm.Resistor().label('R4').up()
>     
>     d += elm.Ground().at(R3.end) # or d += elm.Ground().at(R4.start)
> d.draw()
> ```

> Q: 这是电容的一阶时间常数电路图，画一个电感的，和电容的图并排放置
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>  d.add(elm.Ground())
>  d.add(elm.SourceV().label('$V_{in}$'))
>  d.add(elm.Switch(action='close').right().label('S'))
>  d.add(elm.Resistor().right().label('$R$'))
>  d.add(elm.Dot(open=True).label('$V_{out}$'))
>  d.add(elm.Capacitor().down().label('$C$'))
>  d.add(elm.Ground())
> 
>  d.draw()
> ```
>
> 参考答案：
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Resistor().right().label('$R$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Capacitor().down().label('$C$'))
>     d += (elm.Ground())
>     
>     d.move(3, 0)
>     
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Inductor().right().label('$L$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
>     
>     d.draw()
> ```
>
> 正确情况：o1错,
>
> 两个关键点：1. `d.move(3, 0)` 2. RC, LR 的顺序


> Q: 这是电压源激励的一阶电路，在同一幅图下面画上电流源激励的一阶电路
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Resistor().right().label('$R$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Capacitor().down().label('$C$'))
>     d += (elm.Ground())
>     
>     d.move(3, 0)
>     
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Inductor().right().label('$L$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
>     
>     d.draw()
> ```
>
> 参考答案：
>
> ```python
> import schemdraw
> import schemdraw.elements as elm
> 
> with schemdraw.Drawing() as d:
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Resistor().right().label('$R$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Capacitor().down().label('$C$'))
>     d += (elm.Ground())
>     d.move(3, 0)
>     d += (elm.Ground())
>     d += (elm.SourceV().label('$V_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Inductor().right().label('$L$'))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
> 
>     d.move(-15, -5)
>     
>     d += (elm.Ground())
>     d += (elm.SourceI().label('$I_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Dot())
>     d += (R1 := elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
>     d += (elm.Line().right().at(R1.start))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Capacitor().down().label('$C$'))
>     d += (elm.Ground())
>     d.move(3, 0)
>     d += (elm.Ground())
>     d += (elm.SourceI().label('$I_{in}$'))
>     d += (elm.Switch(action='close').right().label('S'))
>     d += (elm.Dot())
>     d += (R2 := elm.Resistor().down().label('$R$'))
>     d += (elm.Ground())
>     d += (elm.Line().right().at(R2.start))
>     d += (elm.Dot(open=True).label('$V_{out}$'))
>     d += (elm.Inductor().down().label('$L$'))
>     d += (elm.Ground())
>     
>     d.draw()
> ```

</details>

