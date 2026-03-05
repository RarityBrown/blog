## VNC & VPN for EDA

虽然 vnc 和 vpn 也不太算 eda，但是还是为了方便归类，一起放进来了。

---

需求一：在公司/学校网络中 RealVNC Viewer 不配置代理（使用系统代理），在非专用网络下配置 RealVNC Viewer 使用 zju-connect (HITSZ Connect Verge) 的代理。两种情况自动切换

AHKv2 草稿：

```ahk
#Requires AutoHotkey v2.0
; 定义 Wi‑Fi 与对应 ProxyServer 的设置映射
wifiSettings := { 
    "YourWifiName1": "socks://127.0.0.1:21800", 
    "YourWifiName2": "<system>" 
}

regPath := "HKEY_CURRENT_USER\Software\RealVNC\vncviewer"
regKey := "ProxyServer"

; 每 10 秒检测一次 Wi‑Fi 状态
SetTimer(CheckWifi, 10000)

CheckWifi(*) {
    global wifiSettings, regPath, regKey
    ; 将 netsh wlan show interfaces 的输出保存到临时文件中
    tempFile := A_Temp "\wifi.txt"
    RunWait('cmd /c netsh wlan show interfaces > "' tempFile '"',, "Hide")
    
    ; 读取输出内容
    output := FileRead(tempFile)
    currentSSID := ""
    
    ; 解析每一行，寻找含有 "SSID"（注意排除 "BSSID"）的行
    for line in StrSplit(output, "`n") {
        if (RegexMatch(line, "i)^\s*SSID\s*:\s*(.+)$", m) && !RegexMatch(line, "i)BSSID"))
        {
            currentSSID := Trim(m[1])
            break
        }
    }
    
    ; 如果未获取到 SSID，则退出函数
    if (currentSSID = "")
        return
    
    ; 若当前连接的 Wi‑Fi 名称在映射中，则更新注册表
    if (wifiSettings.HasKey(currentSSID)) {
        newVal := wifiSettings[currentSSID]
        RegWrite("REG_SZ", regPath, regKey, newVal)
        Tooltip "Connected WiFi: " currentSSID " -> Set ProxyServer to: " newVal, 10, 10
    }
    else {
        Tooltip "Connected WiFi: " currentSSID " -> No matching setting", 10, 10
    }
}
```

--- 

增加 linux 的显示分辨率, [source](https://www.xiaohongshu.com/user/profile/62aa23de000000001b02bd2b)

```bash
> xrandr
Screen 0: minimum 32 x 32, current 1920 x 1080, maximum 32768 x 32768
VNC-0 connected primary 1920x1080+0+0 0mm x 0mm
   1920x1080     60.00*+
   1920x1200     60.00  
   1600x1200     60.00  
   1680x1050     60.00  
   1400x1050     60.00  
   1360x768      60.00  
   1280x1024     60.00  
   1280x960      60.00  
   1280x800      60.00  
   1280x720      60.00  
   1024x768      60.00  
   800x600       60.00  
   640x480       60.00

> cvt 3840 2160
# 3840x2160 59.98 Hz (CVT 8.29M9) hsync: 134.18 kHz; pclk: 712.75 MHz
Modeline "3840x2160_60.00"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync

> xrandr --newmode "3840x2160_60.00"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync

> xrandr --addmode "VNC-0" "3840x2160_60.00"
```

---

```bash
gnome-tweaks
```


## Windows RDP

