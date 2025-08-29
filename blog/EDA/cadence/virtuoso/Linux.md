# Linux Setting to Make Virtuoso Handy

todo

- 重启后自动启动目录?
- 仿真完手机通知推送?

--- 

**远程客户端**

- vnc
- nomachine
- Exceed TurboX

---

**关闭 GNOME 所有动画效果**

```bash
gsettings set org.gnome.desktop.interface enable-animations false
```

---

**telnet 自动登录**

```bash
mkdir -p ~/myscript
touch ~/myscript/rmt

## setting `username` and `password` in `rmt` file
# code ~/myscript/rmt
# gedit ~/myscript/rmt
# nano ~/myscript/rmt

chmod 700 ~/myscript/rmt
echo 'set path = ( ~/myscript $path )' >> ~/.cshrc
source ~/.cshrc
```


`~/myscript/rmt` code: 

<details>
<summary>code</summary>

```bash
#!/usr/bin/expect -f

set timeout 10
set user "username"
set pass "password"

if {$argc < 1} {
  puts "Usage: $argv0 <hostname_or_ip> \[command_to_run]"
  exit 1
}

set server [lindex $argv 0]
set command [lrange $argv 1 end]

spawn telnet $server

expect {
  timeout {
    puts "Connection to $server timed out."
    exit 1
  }
  eof {
    puts "Connection to $server failed or was closed."
    exit 1
  }
  "*ogin incorrect" {
    puts "Login failed: incorrect username or password."
    exit 1
  }
  "*ogin:" {
    send "$user\r"
    exp_continue
  }
  "*assword:" {
    send "$pass\r"
  }
}

expect {
  -re {[#$%>\]] ?$} {
    if {[string length $command] > 0} {
      send "$command\r"
    }
  }
  timeout {
    puts "Did not get a command prompt after login."
    exit 1
  }
}

interact
```

todo: 

> 这个脚本有一个问题：当我执行 rmt server01，然后执行了一些命令并完成后，我通过 GUI 的叉按钮关闭 terminal 时，terminal 会弹出一个窗口 "there is still a process running in this terminal. closing the terminal will kill it." 应该是由于 expect 在跑导致的。如何让 terminal 在这种情况下不提示这个？（但是其他要提示的情况还是要提示的，例如 top 后想要直接关闭时，terminal 的提示）

```bash
proc cleanup {} {
    catch {close}
    catch {wait}
    exit 0
}

## Choice 1
trap cleanup {SIGHUP SIGINT SIGTERM}
## Choice 2
trap cleanup {INT TERM HUP}


## Choice 1
interact {
    eof {
        cleanup
    }
}
## Choice 2
interact {
    eof { 
        inter_return 
    }
} -escape \001
## Choice 3
interact {
    -re {(?i)^(exit|logout)\r?$} { inter_return }
    eof { inter_return }
    -o
    eof { inter_return }
} -escape \035

cleanup
```

</details>

---

**virtuoso 弹出窗口不在顶层**

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

---

**建议的文件夹 hierarchy**

```
cdnsws/
├── calibrerunset/
│   └── runset
├── corners/
│   └── corners.csv
├── jobrule
├── log
├── workspace
└── workspacetest
```
