# MATLAB

## Symbolic Toolbox

```matlab
syms x y z
assume([x y z], 'real');

A = (x + y*i);      
abs(A)                                                     % 自动化简

B = (x + y*z*i);
abs(B)                                                     % 不自动化简
simplify(abs(B), 'Steps', 1000)                            % 不能正常化简
simplify(abs(B), 'Steps', 7, 'Criterion', 'preferReal')    % 正常化简
simplify(sqrt(B*conj(B)))                                  % 正常化简
simplify(sqrt(real(B)^2 + imag(B)^2))                      % 正常化简

C = 1/(x + y*i);      
abs(C)                                                     % 自动化简

D = 1/(x + y*z*i);
abs(D)                                                     % 不自动化简
simplify(abs(D))                                           % 不能默认化简
simplify(abs(D), 'Steps', 12)                              % 正常化简
```

## Uncommon but useful features

Draw a vertical line across all plots in a subplot or stackedplot

```matlab
% Sample data
t = -2:0.1:10;
subplot(2,1,1); y1 = sin(t); plot(t, y1);
subplot(2,1,2); y2 = cos(t); plot(t, y2);

% Get figure handle
fig = gcf;

% Define x-coordinate for the vertical line
x_line = 7;

% Get x-axis limits from the first subplot (assuming both subplots have the same x-limits)
ax1 = fig.Children(2); % Get the first subplot axes (second child, as order is reversed)
x_limits = xlim(ax1); % Get x-limits of the first subplot

% Get the position of the first subplot in normalized figure coordinates
ax1_pos = ax1.Position;

% Calculate normalized x-coordinate, considering the axes position
x_norm = ax1_pos(1) + (x_line - x_limits(1)) / (x_limits(2) - x_limits(1)) * ax1_pos(3);

% Draw vertical line using annotation
annotation(fig, 'line', [x_norm x_norm], [0 1], 'LineStyle', '--');
```

![untitled](https://github.com/user-attachments/assets/29d92373-77a3-485f-8bd1-bb2ed205e869)



## 绘图的一些碎碎念

MATLAB 和 Matplotlib 的 2d 和 3d 交互式绘图因为历史原因都是基于纯 CPU 的，而没有 GPU OpenGL 加速。用惯了 GeoGebra，看惯了 3b1b manim 生成的视频后会非常不适应。VisPy 是一个解决方案，但是创建于 2013 年的它还没有成为主流，而且正因为没有成为主流，项目资金来源和开发进度都远不能及 Matplotlib，因此 VisPy 目前还没有正式推出 V1.0 版本。不过我们还是可以尝试一下 VisPy:

```bash
pip install vispy
pip install PyQt6
pip install pytest
pip install jupyter_rfb
```

VisPy 相较于 Matplotlib 多了很多底层的 OpenGL 接口，不过也提供了一些高层次的 [API](https://vispy.org/getting_started/index.html)

```python
# %matplotlib notebook
import numpy as np
import vispy.plot as vp
import matplotlib.pyplot as plt
x = np.arange(0, 100, 1)
y = x**2

########################## vispy ##########################
fig = vp.Fig(size=(800, 600), show=False, bgcolor='w')  # 白色背景
plotwidget = fig[0, 0]
plot = plotwidget.plot(np.column_stack((x, y)),  # 将 x 和 y 组合成 (n, 2) 的数组
                      title="y = x^2",
                      color='#1f77b4',     # matplotlib 默认蓝色
                      marker_size=0,       # 移除数据点标记
                      width=2,             # 线宽
                      xlabel='x',
                      ylabel='y')

# 添加标签和网格
grid = vp.visuals.GridLines(color=(0, 0, 0, 0.5))
grid.set_gl_state('translucent')
fig[0, 0].view.add(grid)
fig.show(run=False)   # 非阻塞显示
########################## vispy ##########################

######################## matplotlib #######################
plt.figure(figsize=(8, 6))
plt.plot(x, y, linewidth=2)
plt.title("y = x^2")
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.show()
######################## matplotlib #######################
```

结论是几乎不可用。缺少大量基础设置。但是交互视图性能确实是相当高，可惜了。
