# Circuits


### 二维电容网络

先借助 AI 画一个漂亮的电路图出来：

```python
import schemdraw
import schemdraw.elements as elm

def draw_nxn_capacitor_network(n=2, step=1):
    d = schemdraw.Drawing()

    # 1. 水平方向电容
    for row in range(n+1):
        for col in range(n):
            x0, y0 = col*step, row*step
            cap_id = f'h,{col},{row}'  # horizontal capacitor at row,col
            d += (elm.Capacitor()
                    .at((x0, y0))
                    .right()
                    .length(step)
                    .label(f'$-Q_{{{cap_id}}}$', loc='left',  ofst=( (step/2-0.2), step/10))
                    .label(f'$+Q_{{{cap_id}}}$', loc='right', ofst=(-(step/2-0.2), step/10))
                    .label(f'$C_{{{cap_id}}}$', loc='top')
                 )

    # 2. 垂直方向电容
    for col in range(n+1):
        for row in range(n):
            x0, y0 = col*step, row*step
            cap_id = f'v,{col},{row}'  # vertical capacitor at row,col
            d += (elm.Capacitor()
                    .at((x0, y0))
                    .up()
                    .length(step)
                    .label(f'$-Q_{{{cap_id}}}$', loc='left',  ofst=( (step/2-0.2), step/5))
                    .label(f'$+Q_{{{cap_id}}}$', loc='right', ofst=(-(step/2-0.2), step/5))
                    .label(f'$C_{{{cap_id}}}$', loc='top')
                 )

    # 3. 接地和电压标注
    d += elm.Ground().at((0, 0))
    d += (elm.Dot(open=True)
          .at((n * step, n * step))
          .label(r'$0 \to V_X$', loc='right'))

    # 4. 节点处理
    for row in range(n+1):
        for col in range(n+1):
            connections = 0
            if col < n: connections += 1  # right connection
            if col > 0: connections += 1  # left connection
            if row < n: connections += 1  # up connection
            if row > 0: connections += 1  # down connection
            if row == 0 and col == 0: connections += 1  # ground connection
            if connections >= 3:
                d += (elm.Dot(open=False)
                     .at((col * step, row * step))
                     .label(f'$N_{{{col},{row}}}$', loc='top', ofst=(step/10, 0)))

    d.draw()

# 示例：画一个 2×2 的电容网络
draw_nxn_capacitor_network(n=2, step=3)
```

#### Q

假设所有电容值都已知、所有电容初始情况下都不带电。在某一时刻，电路右上角有电荷瞬间给电容网络充电，使得电路右上角的电压为 $V_X$，求每个电容两端的电压？

![Figure_1](https://github.com/user-attachments/assets/8cefa790-e0c3-4866-ac39-456c59769f9d)



#### A 

**核心思想：利用节点电压和电荷守恒定律求解。**

1. **定义未知量：** 将每个节点的电压设为未知量。对于一个 $n \times n$ 的电容网络，共有 $(n+1) \times (n+1)$ 个节点。由于左下角接地 ($V_{0,0}=0$) ，右上角电压已知为 $V_{n,n}=V_X$，因此共有 $(n+1)^2 - 2$ 个未知的节点电压。
2. **建立方程：**  针对每一个未知的节点，利用电荷守恒列出方程
   - 对于一个内部节点 $N_{r,c}$，与之相连的电容会影响该节点的电荷。考虑与节点 $N_{r,c}$ 相连的四个方向的电容（水平和垂直）：
     - 水平方向: $C_{h,c-1,r}$ (左侧) 和 $C_{h,c,r}$ (右侧) 
     - 垂直方向: $C_{v,c,r-1}$ (下方) 和 $C_{v,c,r}$ (上方) 
   - 根据电容的电荷量公式 $Q = CV$ ，以及电荷守恒定律，我们可以写出节点 $N_{r,c}$ 的电荷守恒方程：
   - $C_{h,c-1,r}(V_{r,c-1} - V_{r,c}) + C_{h,c,r}(V_{r,c+1} - V_{r,c}) + C_{v,c,r-1}(V_{r-1,c} - V_{r,c}) + C_{v,c,r}(V_{r+1,c} - V_{r,c}) = 0$
   对每一个未知的节点都列出一个这样的方程。
4. **求解方程组：**  对于一个 $n \times n$ 的网络，我们将得到 $(n+1)^2 - 2$ 个线性方程，且有 $(n+1)^2 - 2$ 个未知节点电压。这是一个线性方程组，用线性代数求解。

#### A (废案)


**1. 电荷守恒**

因为初始状态下所有节点都不带电，所以对于 $3\times 3-2=7$ 个 nodes 可以写出七个电荷守恒方程，例如对于节点 $N_{1,2}$ 有 $(+Q_{h,0,2})+(-Q_{h,1,2})+(+Q_{v,1,1})=0$

一般地，用数学语言写出有：

$$
\forall N_{r,c} \in \{N_{r,c} | 0 \le r, c \le 2\} \setminus \{N_{0,0}, N_{2,2}\}, \quad  Q_{N_{r,c}} = \sum (Q_{h}+Q_{v}) =  0
$$

但是，如果我们直接像图中一样，以电荷为未知数列方程，会导致 12 个电荷并不是完全线性无关的：例如把整个网络考虑成一个大电容器时，有 $-Q_{N_{0,0}}=-(-Q_{v,0,0}-Q_{h,0,0})=Q_{N_{2,2}}=(Q_{h,1,2}+Q_{v,2,1})$​

所以，一种更好的方式是，假设各节点的电压为未知数，列出 $(n+1)^2-2=7$ 个电荷守恒方程：

$$
\begin{cases}
C_{h,0,0}(V_{0,0} - V_{1,0}) + C_{h,1,0}(V_{2,0} - V_{1,0}) + C_{v,1,0}(V_{1,1} - V_{1,0}) = 0 \\
C_{h,0,1}(V_{1,1} - V_{0,1}) + C_{v,0,0}(V_{0,0} - V_{0,1}) + C_{v,0,1}(V_{0,2} - V_{0,1}) = 0 \\
C_{h,0,1}(V_{0,1} - V_{1,1}) + C_{h,1,1}(V_{2,1} - V_{1,1}) + C_{v,1,0}(V_{1,0} - V_{1,1}) + C_{v,1,1}(V_{1,2} - V_{1,1}) = 0 \\
\vdots
\end{cases}
$$


**2. 电压相等**

从左下角走到右上角，需要向右走 n 步，向上走 n 步，总共需要走 2n 步；需要从 2n 步中选择 n 步作为“右”（剩下的 n 步自动是“上”），所以有：

$$
C(2n, n)=\binom{2n}{n} = \frac{(2n)!}{(n!)^2}
$$

可以写出 $\binom{4}{2}=6$ 个电压相等的式子，形如下式：

$$
V_{\alpha,\beta}+V_{\beta,\gamma}+V_{\gamma,\delta}+V_{2,2}=(V_A-0)
$$

**3. 线性相关？**

- 对于 $n\times n$ 的网络，有是 $(n+1)^2-2=7$ 个未知的节点电压；或是 $2n(n+1)$ 个电容，即 $2n(n+1)$ 项未知的电荷
- 可以列出 $(n+1)^2-2$ 个电荷守恒方程, $\displaystyle\prod_{k=1}^{n} \frac{n+k}{k}$​ 个电压相等方程
- 但是此时方程比未知数多，有很多线性相关的方程? $\displaystyle (n+1)^2-2+\prod_{k=1}^{n}\frac{n+k}{k} \ge 2n(n+1)$

未完待续...


思考：

1. 把网络变成三维网格重解此题
2. 网络上的阻抗换成 $R+\frac{1}{sC}$ 的形式，重解此题
