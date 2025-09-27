# VNC & VPN for EDA

虽然 vnc 和 vpn 也不太算 eda，但是还是为了方便归类，一起放进来了。


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
