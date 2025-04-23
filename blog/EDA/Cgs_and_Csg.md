# Cgs and Csg

引言：在 Virtuoso 中有 Cgs 和 Csg 两个值。他们究竟是什么？本文试图探究一番

未完待续...

## 基于电荷的电路瞬态仿真

我们先看看传统的电路仿真是怎么做的：

### 基于电压/电流的电路瞬态仿真 (Modified Nodal Analysis)

这种方法旨在求解电路中所有未知节点**电压** (以及独立电压源的**电流**，如果需要的话)。规定流入节点电流为 +，流出电流为 -

![image](https://github.com/user-attachments/assets/b020ed9c-bbaa-4d60-af9a-116ca86410d3)


`(C1 || R2) 串联 R3 串联 (C4 || R5)` 被阶跃电压源 $V_{\text{source}}(t)$ 连接，示意性质的 SPICE netlist 如下：

```
Vs 1 0 step 5V
C1 1 2 1u
R2 1 2 200
R3 2 3 500
C4 3 0 10u
R5 3 0 2k
```

#### 基础部分

1.  **确定未知数（节点电压）：**
    *   未知节点电压：$V_2, V_3$
    *   已知节点电压：$V_0 = 0,V_1 = V_{\text{source}}(t)$
2.  **应用基尔霍夫电流定律 (KCL):** 在每个未知电压节点（节点2和节点3）写出KCL方程，即**流入节点的电流总和为零**。
    *   **KCL @ Node 2:** $I_{C1 \text{(1->2)}} + I_{R2 \text{(1->2)}} + I_{R3 \text{(3->2)}} = 0$
    *   **KCL @ Node 3:** $I_{R3 \text{(2->3)}} + I_{C4 \text{(0->3)}} + I_{R5 \text{(0->3)}} = 0$
3.  **用节点电压表示支路电流（流入对应节点）：**
    *   电阻电流 (Ohm's Law): $I = (V_{\text{start}} - V_{\text{end}}) / R$
        *   流入 Node 2 的 $I_{R2} = (V_1 - V_2) / R_2$
        *   流入 Node 2 的 $I_{R3 \text{(3->2)}} = (V_3 - V_2) / R_3$
        *   流入 Node 3 的 $I_{R3 \text{(2->3)}} = (V_2 - V_3) / R_3$
        *   流入 Node 3 的 $I_{R5} = (0 - V_3) / R_5 = -V_3 / R_5$
    *   电容电流: $I = C \frac{d(V_{\text{start}} - V_{\text{end}})}{dt}$
        *   流入 Node 2 的 $I_{C1} = C_1 \frac{d(V_1 - V_2)}{dt} = C_1 ( \frac{dV_1}{dt} - \frac{dV_2}{dt} )$
        *   流入 Node 3 的 $I_{C4} = C_4 \frac{d(0 - V_3)}{dt} = -C_4 \frac{dV_3}{dt}$
4.  **代入KCL方程：** (将上面定义的流入电流代入KCL方程)
    *   **Node 2:** $C_1 \left( \frac{dV_1}{dt} - \frac{dV_2}{dt} \right) + \frac{V_1 - V_2}{R_2} + \frac{V_3 - V_2}{R_3} = 0$
    *   **Node 3:** $\frac{V_2 - V_3}{R_3} - C_4 \frac{dV_3}{dt} - \frac{V_3}{R_5} = 0$

#### 高级部分

##### 5. 整理成矩阵形式 (微分代数方程 DAE):

将未知电压项 ($V_2, V_3$) 及其导数放在左边，已知项 ($V_1, dV_1/dt$) 放在右边

$$
\newcommand{\dv}[2]{\dfrac{\mathrm{d} #1}{\mathrm{d} #2}}
\newcommand{\tallestelement}{\dfrac{\mathrm{d}V}{\mathrm{d}t}}

\begin{equation*}

\begin{bmatrix} C_1 \vphantom{\tallestelement} & 0 \\ 0 & C_4 \vphantom{\tallestelement} \end{bmatrix}
\begin{bmatrix} \dv{V_2}{t} \\ \dv{V_3}{t} \end{bmatrix}
+
\begin{bmatrix} \dfrac{1}{R_2} + \dfrac{1}{R_3} & -\dfrac{1}{R_3} \\ -\dfrac{1}{R_3} & \dfrac{1}{R_3} + \dfrac{1}{R_5} \end{bmatrix}
\begin{bmatrix} V_2 \vphantom{\tallestelement} \\ V_3 \vphantom{\tallestelement} \end{bmatrix}
=
\begin{bmatrix} C_1 \dv{V_1}{t} + \dfrac{V_1}{R_2} \\ 0 \vphantom{\tallestelement} \end{bmatrix}
\end{equation*}
$$

这可以写成更紧凑的形式：

$$
\mathbf{C} \dv{\mathbf{V}}{t} + \mathbf{G} \mathbf{V} = \mathbf{I}(t)
$$

其中：

*   $\mathbf{V} = [V_2, V_3]^T$ (未知电压向量)；$d\mathbf{V}/dt = [dV_2/dt, dV_3/dt]^T$ (电压导数向量)
*   $\mathbf{C}$ 是电容矩阵: $\mathbf{C} = \begin{bmatrix} C_1 & 0 \\ 0 & C_4 \end{bmatrix}$；$\mathbf{G}$ 是电导矩阵: $\mathbf{G} = \begin{bmatrix} (1/R_2 + 1/R_3) & -1/R_3 \\ -1/R_3 & (1/R_3 + 1/R_5) \end{bmatrix}$
*   $\mathbf{I}(t)$ 是包含源项和已知电压贡献的向量: $\mathbf{I}(t) = [C_1 dV_1/dt + V_1/R_2, 0]^T$

##### 6. 数值求解 (线性代数):

为了在计算机上求解，需要对时间进行离散化。例如，使用**后向欧拉法 (Backward Euler)**： $\frac{d\mathbf{V}}{dt} \approx \frac{\mathbf{V}^n - \mathbf{V}^{n-1}}{\Delta t}$ (其中 $\mathbf{V}^n$ 是当前时间步 $t_n$ 的电压向量，$\mathbf{V}^{n-1}$ 是上一步 $t_{n-1}$ 的电压向量，$\Delta t = t_n - t_{n-1}$ 是时间步长)。代入离散化公式：

$$
\mathbf{C} \frac{\mathbf{V}^n - \mathbf{V}^{n-1}}{\Delta t} + \mathbf{G} \mathbf{V}^n = \mathbf{I}^n
$$

整理得到关于未知 $\mathbf{V}^n$ 的线性方程组：

$$
\left( \frac{\mathbf{C}}{\Delta t} + \mathbf{G} \right) \mathbf{V}^n = \frac{\mathbf{C}}{\Delta t} \mathbf{V}^{n-1} + \mathbf{I}^n
$$

这是一个标准的线性代数问题 $\mathbf{A} \mathbf{x} = \mathbf{b}$，其中：

*   $\mathbf{A} = \frac{\mathbf{C}}{\Delta t} + \mathbf{G}$ (系统矩阵)
*   $\mathbf{x} = \mathbf{V}^n$ (当前时间步要求解的电压向量)
*   $\mathbf{b} = \frac{\mathbf{C}}{\Delta t} \mathbf{V}^{n-1} + \mathbf{I}^n$ (已知向量)

在每个时间步，构建矩阵 $\mathbf{A}$ 和向量 $\mathbf{b}$，然后求解 $\mathbf{V}^n$





### 基于电荷/磁通 (Q/Φ) 的仿真

这种方法使用存储在电容上的**电荷 (Q)** 作为状态变量 (对于 RC 电路)

#### 基础部分

1.  **确定状态变量（电容电荷）：**
    *   电容上的电荷：
        *   C1上的电荷: $Q_1 = C_1 (V_1 - V_2)$
        *   C4上的电荷: $Q_4 = C_4 (V_3 - 0) = C_4 V_3$
2.  **用状态变量表示电压/电流：**
    *   电容电压：$V_C = Q / C$
        *   $V_1 - V_2 = Q_1 / C_1 \implies V_2 = V_1 - Q_1 / C_1$
        *   $V_3 = Q_4 / C_4$
    *   电容电流：$I = dQ / dt$。注意：$dQ_1/dt$ 是从节点1流向节点2的电流（即流入Node 2）；$dQ_4/dt$ 是从节点3流向节点0的电流（即流出Node 3）。因此，流入Node 3的电容电流为 $-dQ_4/dt$。
        *   流入 Node 2 的 $I_{C1} = dQ_1 / dt$
        *   流入 Node 3 的 $I_{C4} = -dQ_4 / dt$
    *   电阻电流（用状态变量相关的电压表示，表示流入对应节点的电流）：
        *   流入 Node 2 的 $I_{R2}$ (从1到2) $= (V_1 - V_2) / R_2 = (Q_1 / C_1) / R_2 = Q_1 / (R_2 C_1)$
        *   流入 Node 2 的 $I_{R3}$ (从3到2) $= (V_3 - V_2) / R_3 = (Q_4/C_4 - (V_1 - Q_1/C_1)) / R_3$
        *   流入 Node 3 的 $I_{R3}$ (从2到3) $= (V_2 - V_3) / R_3 = ((V_1 - Q_1/C_1) - Q_4/C_4) / R_3$
        *   流入 Node 3 的 $I_{R5}$ (从0到3) $= (0 - V_3) / R_5 = -V_3 / R_5 = -(Q_4 / C_4) / R_5 = -Q_4 / (R_5 C_4)$
3.  **应用电荷守恒定律 (KCL的积分形式):** 在独立节点应用KCL（**流入电流和为零**），并用 $dQ/dt$ 和状态变量表示电流。
    *   **KCL @ Node 2 (流入 = 0):** $I_{C1 \text{(in)}} + I_{R2 \text{(in)}} + I_{R3 \text{(in)}} = 0$
        代入表达式： $\frac{dQ_1}{dt} + \frac{Q_1}{R_2 C_1} + \frac{Q_4/C_4 - (V_1 - Q_1/C_1)}{R_3} = 0$
    *   **KCL @ Node 3 (流入 = 0):** $I_{R3 \text{(in)}} + I_{C4 \text{(in)}} + I_{R5 \text{(in)}} = 0$
        代入表达式： $\frac{(V_1 - Q_1/C_1) - Q_4/C_4}{R_3} - \frac{dQ_4}{dt} - \frac{Q_4}{R_5 C_4} = 0$

#### 高级部分

##### 整理成状态方程 (一阶微分方程组 ODE):

将上述KCL方程整理，把 $dQ/dt$ 放在左边，其他项移到右边，然后整理成矩阵形式

$$
\newcommand{\dv}[2]{\dfrac{\mathrm{d} #1}{\mathrm{d} #2}}
\newcommand{\tallestelement}{\dfrac{\mathrm{d}V}{\mathrm{d}t}}

\begin{equation*}
\dv{}{t} \begin{bmatrix}
  Q_1 \vphantom{\tallestelement} \\
  Q_4 \vphantom{\tallestelement}
\end{bmatrix}
+
\begin{bmatrix}
  \dfrac{1}{R_2 C_1} + \dfrac{1}{R_3 C_1} & \dfrac{1}{R_3 C_4} \\
  \dfrac{1}{R_3 C_1} & \dfrac{1}{R_3 C_4} + \dfrac{1}{R_5 C_4}
\end{bmatrix}
\begin{bmatrix}
  Q_1 \vphantom{\tallestelement} \\
  Q_4 \vphantom{\tallestelement}
\end{bmatrix}
=
\begin{bmatrix}
  \dfrac{1}{R_3} \vphantom{\tallestelement} \\
  \dfrac{1}{R_3} \vphantom{\tallestelement}
\end{bmatrix}
V_1(t)
\end{equation*}
$$

这可以写成更紧凑的形式：

$$
\dv{\mathbf{Q}}{t} + \mathbf{A} \mathbf{Q} = \mathbf{B} u(t)
$$

其中：

*   $\mathbf{Q} = [Q_1, Q_4]^T$ (状态变量，电荷向量)
*   $d\mathbf{Q}/dt = [dQ_1/dt, dQ_4/dt]^T$
*   $\mathbf{A}$ 是系统矩阵 (如上所示)
*   $\mathbf{B}$ 是输入矩阵: $\mathbf{B} = [1/R_3, 1/R_3]^T$
*   $u(t) = V_1(t)$ (输入信号)

##### 数值求解 (线性代数):





**总结对比：**

*   **V/I (MNA):**
    *   未知数：节点电压 ($V_2, V_3$)。
    *   方程：基于KCL，得到微分代数方程组 (DAE) $\mathbf{C} \dot{\mathbf{V}} + \mathbf{G} \mathbf{V} = \mathbf{I}(t)$。
    *   求解：离散化后，每步求解 $(\mathbf{C}/\Delta t + \mathbf{G}) \mathbf{V}^n = \mathbf{b}$ 形式的线性方程。
*   **Q/Φ:**
    *   未知数：状态变量 - 电容电荷 ($Q_1, Q_4$)。
    *   方程：基于电荷守恒/KCL，得到一阶常微分方程组 (ODE) $\dot{\mathbf{Q}} = \mathbf{A} \mathbf{Q} + \mathbf{B} u(t)$。
    *   求解：离散化后，每步求解 $(\mathbf{I}/\Delta t - \mathbf{A}) \mathbf{Q}^n = \mathbf{b}$ 形式的线性方程。

两种方法对于线性电路最终都归结为求解线性方程组。Q/Φ 方法直接以电荷为变量，在某些需要精确电荷守恒的应用中可能更有优势。






## BSIM4



BSIM4 是基于电荷的，而不是基于电压电流的。





参考资料：

todo



the negative of the change in the charge on the gate (Qg) with respect to a change in the voltage at the source (Vs), with all other terminal voltages held constant; 

the negative of the change in the charge on the source (Qs) with respect to a change in the voltage at the gate (Vg), with other terminal voltages held constant.
$$
C_{gs}=-\dv{Q_g}{V_s} \qquad C_{sg}=-\dv{Q_s}{V_g}
$$
The inclusion of the negative sign is a convention employed in many device models to ensure consistency with circuit theory principles and the matrix representation of device behavior. It is crucial to recognize that these are not simple two-terminal capacitances as one might encounter in basic circuit theory but are elements of a more complex capacitance matrix that describes the intricate coupling between all terminals of the MOSFET.

在spectre里，Cij的定义为dQi/dVj,意义是恒量j端电压的变化引起i端电荷的变化情况，例如：Cgs=dQg/dVs，即源端电压的变化引起栅端电量的变化情况，Cgg=dQg/dVg，栅端电压的变化引起栅端电量的变化。
所以Cgs会为负数，因为例如源端电压增加dVs>0，即源端有正电荷积累，那么在栅端感应出来的电荷就为负的，即dQg<0，所以Cgs=dQg/dVs<0，所以只有Cgg,Css,Cdd等为正数，其它的都为负数，于是我们只要看它们的绝对值就好了。

这同样解释为什么Cgs与Csg有轻微的不等 ，因为在源端变化电压引起栅端电荷的变化量，与在栅端变化相同电压引起源端电荷变化量是不相同的。







