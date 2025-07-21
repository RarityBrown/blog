# Linux Setting to Make Virtuoso Handy

virtuoso 弹出窗口不在顶层

```bash
gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'strict'
gconftool-2 --set /apps/metacity/general/new_windows_always_on_top --type bool true
```

ref:

```url
https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/30670/virtuoso-new--cell-view-window-display-at-the-bottom
https://community.cadence.com/cadence_technology_forums/f/custom-ic-design/27387/dialogs-come-up-behind-other-windows
https://support1.cadence.com/public/docs/content/11612426.html
http://support.cadence.com/wps/mypoc/cos?uri=deeplinkmin:ViewSolution;solutionNumber=11612426
https://blog.csdn.net/weixin_42767056/article/details/88714594
https://bbs.eetop.cn/thread-328477-1-1.html
https://bbs.eetop.cn/thread-484212-1-1.html
https://bbs.eetop.cn/thread-889813-1-1.html
https://bbs.eetop.cn/thread-893222-1-1.html
https://bbs.eetop.cn/thread-908468-1-1.html
```

如果是 Red Hat 也可以通过 GUI 来设置，但是 CentOS 是不行的。

Applications -> System Tools -> Configuration Editor(gconf-editor / dconf-editor) -> apps -> metacity -> general -> new_windows_always_on_top


<!--
virtuoso dialogs come up behind other windows. I'm using RHEL 7.9 with GNOME 3.28. `dconf-editor` and `gconf-editor` are not installed, and I don't have suto permission.

```
gsettings set org.gnome.shell.overrides attach-modal-dialogs false
gsettings set org.gnome.mutter attach-modal-dialogs false
gsettings set org.gnome.shell attach-modal-dialogs false
gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'strict'
gsettings set org.gnome.desktop.wm.preferences focus-mode 'click'
```
-->

| 操作系统版本                 | GNOME 版本                                  | 窗口管理器 |
| :--------------------------- | :------------------------------------------ | :--------- |
| Red Hat Enterprise Linux 6 / CentOS 6 | GNOME 2.28                                  | Metacity   |
| Red Hat Enterprise Linux 7 / CentOS 7 | GNOME 3.28 (从 RHEL/CentOS 7.6 开始)        | Mutter     |
| Red Hat Enterprise Linux 8   | GNOME 3.28 (8.0) 至 GNOME 3.32 (8.1 及以后) | Mutter     |
| Red Hat Enterprise Linux 9   | GNOME 40                                    | Mutter     |
| CentOS Stream 8              | GNOME 3.32.2                                | Mutter     |
| CentOS Stream 9              | GNOME 40                                    | Mutter     |
| CentOS Stream 10             | GNOME 47                                    | Mutter     |


> todo: 如何在没有管理员权限的情况下在 GNOME 中安装 Dash to Panel？

