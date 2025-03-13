# Linux Setting to Make Virtuoso Handy

virtuoso 弹出窗口不在顶层

```bash
gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'strict'
gconftool-2 --set /apps/metacity/general/new_windows_always_on_top --type bool true
```

如果是 Red Hat 也可以通过 GUI 来设置，但是 CentOS 是不行的。

Applications -> System Tools -> Configuration Editor(gconf-editor / dconf-editor) -> apps -> metacity -> general -> new_windows_always_on_top


| 操作系统版本               | GNOME 版本 | 窗口管理器 |
| -------------------------- | ---------- | ---------- |
| Red Hat Enterprise Linux 6 | GNOME 2    | Metacity   |
| Red Hat Enterprise Linux 7 | GNOME 3.22 | Mutter     |
| Red Hat Enterprise Linux 8 | GNOME 3.28 | Mutter     |
| Red Hat Enterprise Linux 9 | GNOME 40   | Mutter     |
| CentOS 6                   | GNOME 2    | Metacity   |
| CentOS 7                   | GNOME 3.22 | Mutter     |
| CentOS Stream 8            | Varies     |            |
