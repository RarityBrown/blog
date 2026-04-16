# Linux Setting to Make Virtuoso Handy

todo

- 重启后自动启动目录?
- 仿真完手机通知推送?

--- 

**远程客户端**

- vnc
- nomachine
- Exceed TurboX


常见问题：

不常见问题：

Q: VNC 鼠标卡死，而显示、键盘等一切正常？

A: <kbd>F8</kbd> + "Send Ctrl+Alt+Del"

---

**获取系统信息**

```csh
lscpu | awk '/Thread\(s\) per core/{t=$4} /Core\(s\) per socket/{c=$4} /Socket\(s\)/{s=$2} /CPU max MHz/{m=$4} END{printf "(%d*%d)*%d @ %.0f MHz\n",t,c,s,m}'
awk '/MemTotal/{printf "%.1f GB\n", $2/1024/1024}' /proc/meminfo
```

例如 `(2*24)*2 @ 3347 MHz` 第一个 2 代表超线程，第二个 24 代表一个 cpu 中的物理核心数，第三个 2 代表两个 cpu socket，最后的表示最高主频。

---

**关闭 GNOME 所有动画效果, 一直 recursive-search**

```bash
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.nautilus.preferences recursive-search 'always'
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
gsettings set org.gnome.metacity new-windows-always-on-top true
gsettings set org.gnome.desktop.wm.preferences auto-raise true​
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

---

**使用 clipboard + base64 传输文件**

`licenser.py` on Windows

```python
import tkinter as tk
import time
import base64
import sys
import os
import ctypes
import hashlib

root = tk.Tk()
root.withdraw()
user32 = ctypes.windll.user32

def get_clipboard_text():
    for _ in range(20):
        try:
            return root.clipboard_get()
        except tk.TclError:
            time.sleep(0.01)
    return ""

def set_clipboard_text(text):
    root.clipboard_clear()
    root.clipboard_append(text)
    root.update()

def get_file_md5(path):
    hash_md5 = hashlib.md5()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

def main():
    received_chunks = set()
    file_name = None
    total_chunks = 0
    
    print("Listening via Hardware Sequence Number (Zero-Lock Mode)...")
    print("Waiting for the first chunk to start tracking stats...\n")
    
    start_time = None
    last_receive_time = time.time()
    last_feedback_time = 0
    total_bytes_received = 0
    last_seq = user32.GetClipboardSequenceNumber()
    
    while True:
        current_time = time.time()
        current_seq = user32.GetClipboardSequenceNumber()
        clip_data = ""
        
        if current_seq != last_seq:
            last_seq = current_seq
            clip_data = get_clipboard_text()
            if clip_data.startswith("DATA|"):
                try:
                    parts = clip_data.split("|", 5)
                    if len(parts) == 6:
                        chunk_idx = int(parts[1])
                        if file_name is None:
                            total_chunks = int(parts[2])
                            file_name = parts[3]
                        chunk_size = int(parts[4])
                        b64_data = parts[5]
                        
                        if chunk_idx not in received_chunks:
                            if len(received_chunks) == 0:
                                start_time = time.time()
                            
                            last_receive_time = time.time()
                            output_filename = f"recv_{file_name}"
                            
                            if not os.path.exists(output_filename):
                                with open(output_filename, "wb") as f:
                                    pass
                            

                            try:
                                data = base64.urlsafe_b64decode(b64_data)
                            except Exception as b64_err:
                                print(f"\n[DEBUG] Chunk {chunk_idx} Base64 Decode Failed: {b64_err}")
                                print(f"[DEBUG] b64_data len: {len(b64_data)}")
                                print(f"[DEBUG] Head: {b64_data[:30]} ... Tail: {b64_data[-30:]}")
                                continue
                            
                            try:
                                with open(output_filename, "r+b") as f:
                                    f.seek(chunk_idx * chunk_size)
                                    f.write(data)
                            except Exception as io_err:
                                print(f"\n[DEBUG] Chunk {chunk_idx} File IO Failed: {io_err}")
                                continue
                            
                            received_chunks.add(chunk_idx)
                            total_bytes_received += len(data)
                            elapsed = time.time() - start_time
                            speed_kbps = (total_bytes_received / 1024) / elapsed if elapsed > 0 else 0.0
                            percent = (len(received_chunks) / total_chunks) * 100
                            missed_count = total_chunks - len(received_chunks)
                            
                            sys.stdout.write(f"\rProgress: {percent:5.1f}% | Speed: {speed_kbps:6.1f} KB/s | Chunks: {len(received_chunks)}/{total_chunks} | Missing: {missed_count}   ")
                            sys.stdout.flush()
                            if len(received_chunks) >= total_chunks:
                                print(f"\n\n[SUCCESS] Transfer complete! Saved as {output_filename}")
                                print(f"MD5: {get_file_md5(output_filename)}")
                                set_clipboard_text(f"SUCCESS|{file_name}")
                                time.sleep(1)
                                break
                except Exception as e:
                    print(f"\n[DEBUG] Unhandled Exception: {e}")

        is_done_signal = (file_name and clip_data.startswith(f"DONE|{file_name}|"))
        is_timeout = (start_time and len(received_chunks) > 0 and len(received_chunks) < total_chunks and (current_time - last_receive_time) > 3.0)
        
        if is_done_signal or is_timeout:
            if (current_time - last_feedback_time) > 4.0:
                missing_list = sorted(list(set(range(total_chunks)) - received_chunks))
                
            if len(missing_list) > 0:
                    request_list = missing_list[:500]
                    missing_str = ",".join(map(str, request_list))
                    req_payload = f"REQ_MISSING|{file_name}|{missing_str}"
                    
                    set_clipboard_text(req_payload)
                    print(f"\n[FEEDBACK] Triggered. Requested {len(missing_list)} missing chunks...")
                    time.sleep(0.2)
                    last_seq = user32.GetClipboardSequenceNumber()
                    
                    last_feedback_time = current_time
                    last_receive_time = current_time

        time.sleep(0.01)

if __name__ == "__main__":
    main()
```

`sender.py` on Linux:

```python
import base64
import subprocess
import time
import os
import sys
import hashlib

CHUNK_SIZE = 1024 * 64
DELAY_SECONDS = 0.1

def set_clipboard(text):
    p = subprocess.Popen(['xclip', '-selection', 'clipboard'], stdin=subprocess.PIPE)
    p.communicate(input=text.encode() if isinstance(text, str) else text)

def get_clipboard():
    try:
        p = subprocess.Popen(['xclip', '-o', '-selection', 'clipboard'], stdout=subprocess.PIPE)
        out, _ = p.communicate()
        return out.strip()
    except:
        return ""

def get_file_md5(path):
    hash_md5 = hashlib.md5()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

def main():
    if len(sys.argv) < 2:
        print("Usage: python sender3.py <filename>")
        sys.exit(1)

    file_path = sys.argv[1]
    if not os.path.exists(file_path):
        print("Error: File not found - " + file_path)
        sys.exit(1)

    file_size = os.path.getsize(file_path)
    total_chunks = (file_size + CHUNK_SIZE - 1) // CHUNK_SIZE
    file_name = os.path.basename(file_path)

    print("Sending file: %s" % file_name)
    print("MD5: %s" % get_file_md5(file_path))
    print("Size: %d bytes" % file_size)
    print("Total chunks: %d" % total_chunks)
    print("--------------------------------------------------")

    chunks_to_send = list(range(total_chunks))

    with open(file_path, "rb") as f:
        while chunks_to_send:
            print("\n[START] Transmitting batch of %d chunks..." % len(chunks_to_send))

            for idx, chunk_idx in enumerate(chunks_to_send):
                f.seek(chunk_idx * CHUNK_SIZE)
                data = f.read(CHUNK_SIZE)
                b64_data = base64.urlsafe_b64encode(data).decode('ascii')

                payload = "DATA|%d|%d|%s|%d|%s" % (chunk_idx, total_chunks, file_name, CHUNK_SIZE, b64_data)
                set_clipboard(payload)

                if len(chunks_to_send) <= 10:
                    print(f"\n[DEBUG] Sent chunk {chunk_idx}, expected b64_len: {len(b64_data)}, payload_len: {len(payload)}")

                sys.stdout.write("\rSent chunk %d/%d (Index: %d)   " % (idx + 1, len(chunks_to_send), chunk_idx))
                sys.stdout.flush()
                if len(chunks_to_send) <= 10:
                    time.sleep(1)
                else:
                    time.sleep(DELAY_SECONDS)

            print("\n[WAIT] Batch finished. Waiting for Windows feedback...")
            time.sleep(1.0)

            set_clipboard("DONE|%s|%d" % (file_name, total_chunks))
            last_done_time = time.time()
            feedback_received = False

            while not feedback_received:
                reply = get_clipboard()

                if reply.startswith(("SUCCESS|" + file_name).encode()):
                    print("\n[SUCCESS] Windows confirmed 100% received!")
                    set_clipboard("CLEANUP")
                    return

                elif reply.startswith(("REQ_MISSING|" + file_name + "|").encode()):
                    parts = reply.split(b"|", 3)
                    missing_str = parts[2].decode('ascii')
                    if missing_str:
                        chunks_to_send = [int(x) for x in missing_str.split(",")]
                        print("\n[INFO] Windows requested %d missing chunks. Resending..." % len(chunks_to_send))
                    else:
                        chunks_to_send = []

                    feedback_received = True
                    time.sleep(1.0)
                    break


                if time.time() - last_done_time > 4.0:
                    set_clipboard("DONE|%s|%d" % (file_name, total_chunks))
                    last_done_time = time.time()


                time.sleep(0.5)

if __name__ == "__main__":
    main()
