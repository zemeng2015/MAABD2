param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("key", "click", "wheel", "drag", "focus", "resize", "log")]
    [string]$Mode,

    [int]$KeyCode = 0,
    [int]$X = 0,
    [int]$Y = 0,
    [int]$EndX = 0,
    [int]$EndY = 0,
    [int]$WheelDelta = 0,
    [string]$Box = "",
    [int]$BaseWidth = 1280,
    [int]$BaseHeight = 719,
    [int]$TargetWidth = 1280,
    [int]$TargetHeight = 720,
    [int]$DurationMs = 700,
    [int]$HoldMs = 120,
    [string]$Message = ""
)

$ErrorActionPreference = "Stop"

$signature = @"
using System;
using System.Runtime.InteropServices;

public static class Bd2InputNative
{
    [StructLayout(LayoutKind.Sequential)]
    public struct RECT
    {
        public int Left;
        public int Top;
        public int Right;
        public int Bottom;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct POINT
    {
        public int X;
        public int Y;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct INPUT
    {
        public uint type;
        public InputUnion U;
    }

    [StructLayout(LayoutKind.Explicit)]
    public struct InputUnion
    {
        [FieldOffset(0)]
        public MOUSEINPUT mi;
        [FieldOffset(0)]
        public KEYBDINPUT ki;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct MOUSEINPUT
    {
        public int dx;
        public int dy;
        public uint mouseData;
        public uint dwFlags;
        public uint time;
        public IntPtr dwExtraInfo;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct KEYBDINPUT
    {
        public ushort wVk;
        public ushort wScan;
        public uint dwFlags;
        public uint time;
        public IntPtr dwExtraInfo;
    }

    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

    [DllImport("user32.dll")]
    public static extern bool GetClientRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll")]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);

    [DllImport("user32.dll")]
    public static extern bool ClientToScreen(IntPtr hWnd, ref POINT lpPoint);

    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);

    [DllImport("user32.dll")]
    public static extern uint MapVirtualKey(uint uCode, uint uMapType);

    [DllImport("user32.dll")]
    public static extern void mouse_event(uint dwFlags, uint dx, uint dy, uint dwData, UIntPtr dwExtraInfo);
}
"@

if (-not ("Bd2InputNative" -as [type])) {
    Add-Type -TypeDefinition $signature
}

$hwnd = [Bd2InputNative]::FindWindow("UnityWndClass", "BrownDust II")
if ($hwnd -eq [IntPtr]::Zero) {
    throw "BrownDust II window was not found."
}

$logPath = Join-Path $PSScriptRoot "bd2_input.log"
function Write-DebugLog([string]$Message) {
    $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fff') $Message"
    Add-Content -LiteralPath $logPath -Value $line -Encoding UTF8
}

[Bd2InputNative]::ShowWindow($hwnd, 9) | Out-Null
[Bd2InputNative]::SetForegroundWindow($hwnd) | Out-Null
Start-Sleep -Milliseconds 120

function Send-Key([int]$vk) {
    $scan = [Bd2InputNative]::MapVirtualKey([uint32]$vk, 0)

    $down = New-Object Bd2InputNative+INPUT
    $down.type = 1
    $down.U.ki.wVk = [ushort]$vk
    $down.U.ki.wScan = [ushort]$scan
    $down.U.ki.dwFlags = 0x0008

    $up = New-Object Bd2InputNative+INPUT
    $up.type = 1
    $up.U.ki.wVk = [ushort]$vk
    $up.U.ki.wScan = [ushort]$scan
    $up.U.ki.dwFlags = 0x0008 -bor 0x0002

    $sentDown = [Bd2InputNative]::SendInput(1, [Bd2InputNative+INPUT[]]@($down), [Runtime.InteropServices.Marshal]::SizeOf([type][Bd2InputNative+INPUT]))
    Start-Sleep -Milliseconds $HoldMs
    $sentUp = [Bd2InputNative]::SendInput(1, [Bd2InputNative+INPUT[]]@($up), [Runtime.InteropServices.Marshal]::SizeOf([type][Bd2InputNative+INPUT]))
    Write-DebugLog "key vk=$vk scan=$scan sentDown=$sentDown sentUp=$sentUp holdMs=$HoldMs"
}

function Send-Click([int]$sx, [int]$sy, [int]$bw, [int]$bh) {
    $rect = New-Object Bd2InputNative+RECT
    if (-not [Bd2InputNative]::GetClientRect($hwnd, [ref]$rect)) {
        throw "GetClientRect failed."
    }

    $clientWidth = $rect.Right - $rect.Left
    $clientHeight = $rect.Bottom - $rect.Top

    $pt = New-Object Bd2InputNative+POINT
    $pt.X = [int][Math]::Round($sx * $clientWidth / $bw)
    $pt.Y = [int][Math]::Round($sy * $clientHeight / $bh)

    if (-not [Bd2InputNative]::ClientToScreen($hwnd, [ref]$pt)) {
        throw "ClientToScreen failed."
    }

    [Bd2InputNative]::SetCursorPos($pt.X, $pt.Y) | Out-Null
    Start-Sleep -Milliseconds 150

    [Bd2InputNative]::mouse_event(0x0002, 0, 0, 0, [UIntPtr]::Zero)
    Start-Sleep -Milliseconds $HoldMs
    [Bd2InputNative]::mouse_event(0x0004, 0, 0, 0, [UIntPtr]::Zero)
    Write-DebugLog "click base=($sx,$sy,$bw,$bh) client=${clientWidth}x${clientHeight} screen=($($pt.X),$($pt.Y)) holdMs=$HoldMs"
}

function Get-BoxCenter([string]$raw) {
    $matches = [regex]::Matches($raw, "-?\d+")
    if ($matches.Count -lt 4) {
        throw "Invalid box: $raw"
    }

    $bx = [int]$matches[0].Value
    $by = [int]$matches[1].Value
    $bw = [int]$matches[2].Value
    $bh = [int]$matches[3].Value

    return @{
        X = [int][Math]::Round($bx + $bw / 2.0)
        Y = [int][Math]::Round($by + $bh / 2.0)
    }
}

function Send-Wheel([int]$sx, [int]$sy, [int]$bw, [int]$bh, [int]$delta) {
    $rect = New-Object Bd2InputNative+RECT
    if (-not [Bd2InputNative]::GetClientRect($hwnd, [ref]$rect)) {
        throw "GetClientRect failed."
    }

    $clientWidth = $rect.Right - $rect.Left
    $clientHeight = $rect.Bottom - $rect.Top

    $pt = New-Object Bd2InputNative+POINT
    $pt.X = [int][Math]::Round($sx * $clientWidth / $bw)
    $pt.Y = [int][Math]::Round($sy * $clientHeight / $bh)

    if (-not [Bd2InputNative]::ClientToScreen($hwnd, [ref]$pt)) {
        throw "ClientToScreen failed."
    }

    [Bd2InputNative]::SetCursorPos($pt.X, $pt.Y) | Out-Null
    Start-Sleep -Milliseconds 150
    [Bd2InputNative]::mouse_event(0x0800, 0, 0, [uint32]$delta, [UIntPtr]::Zero)
    Write-DebugLog "wheel delta=$delta base=($sx,$sy,$bw,$bh) client=${clientWidth}x${clientHeight} screen=($($pt.X),$($pt.Y))"
}

function Convert-ClientPoint([int]$sx, [int]$sy, [int]$bw, [int]$bh) {
    $rect = New-Object Bd2InputNative+RECT
    if (-not [Bd2InputNative]::GetClientRect($hwnd, [ref]$rect)) {
        throw "GetClientRect failed."
    }

    $clientWidth = $rect.Right - $rect.Left
    $clientHeight = $rect.Bottom - $rect.Top

    $pt = New-Object Bd2InputNative+POINT
    $pt.X = [int][Math]::Round($sx * $clientWidth / $bw)
    $pt.Y = [int][Math]::Round($sy * $clientHeight / $bh)

    if (-not [Bd2InputNative]::ClientToScreen($hwnd, [ref]$pt)) {
        throw "ClientToScreen failed."
    }

    return @{
        Point = $pt
        ClientWidth = $clientWidth
        ClientHeight = $clientHeight
    }
}

function Send-Drag([int]$sx, [int]$sy, [int]$ex, [int]$ey, [int]$bw, [int]$bh, [int]$duration) {
    $start = Convert-ClientPoint $sx $sy $bw $bh
    $end = Convert-ClientPoint $ex $ey $bw $bh
    $startPt = $start.Point
    $endPt = $end.Point

    [Bd2InputNative]::SetCursorPos($startPt.X, $startPt.Y) | Out-Null
    Start-Sleep -Milliseconds 180
    [Bd2InputNative]::mouse_event(0x0002, 0, 0, 0, [UIntPtr]::Zero)

    $steps = [Math]::Max(8, [int][Math]::Round($duration / 35.0))
    for ($i = 1; $i -le $steps; $i++) {
        $t = $i / [double]$steps
        $cx = [int][Math]::Round($startPt.X + ($endPt.X - $startPt.X) * $t)
        $cy = [int][Math]::Round($startPt.Y + ($endPt.Y - $startPt.Y) * $t)
        [Bd2InputNative]::SetCursorPos($cx, $cy) | Out-Null
        Start-Sleep -Milliseconds ([Math]::Max(10, [int][Math]::Round($duration / $steps)))
    }

    Start-Sleep -Milliseconds 120
    [Bd2InputNative]::mouse_event(0x0004, 0, 0, 0, [UIntPtr]::Zero)
    Write-DebugLog "drag base=($sx,$sy)->($ex,$ey),$bw,$bh client=$($start.ClientWidth)x$($start.ClientHeight) screen=($($startPt.X),$($startPt.Y))->($($endPt.X),$($endPt.Y)) durationMs=$duration"
}

function Set-ClientSize([int]$targetWidth, [int]$targetHeight) {
    $clientRect = New-Object Bd2InputNative+RECT
    if (-not [Bd2InputNative]::GetClientRect($hwnd, [ref]$clientRect)) {
        throw "GetClientRect failed."
    }

    $windowRect = New-Object Bd2InputNative+RECT
    if (-not [Bd2InputNative]::GetWindowRect($hwnd, [ref]$windowRect)) {
        throw "GetWindowRect failed."
    }

    $clientWidth = $clientRect.Right - $clientRect.Left
    $clientHeight = $clientRect.Bottom - $clientRect.Top
    $windowWidth = $windowRect.Right - $windowRect.Left
    $windowHeight = $windowRect.Bottom - $windowRect.Top

    if ([Math]::Abs($clientWidth - $targetWidth) -le 2 -and [Math]::Abs($clientHeight - $targetHeight) -le 2) {
        Write-DebugLog "resize skipped targetClient=${targetWidth}x${targetHeight} actualClient=${clientWidth}x${clientHeight}"
        return
    }

    $extraWidth = $windowWidth - $clientWidth
    $extraHeight = $windowHeight - $clientHeight
    $newWindowWidth = $targetWidth + $extraWidth
    $newWindowHeight = $targetHeight + $extraHeight

    if (-not [Bd2InputNative]::MoveWindow($hwnd, $windowRect.Left, $windowRect.Top, $newWindowWidth, $newWindowHeight, $true)) {
        throw "MoveWindow failed."
    }

    Start-Sleep -Milliseconds 500

    $newClientRect = New-Object Bd2InputNative+RECT
    [Bd2InputNative]::GetClientRect($hwnd, [ref]$newClientRect) | Out-Null
    $newClientWidth = $newClientRect.Right - $newClientRect.Left
    $newClientHeight = $newClientRect.Bottom - $newClientRect.Top
    Write-DebugLog "resize targetClient=${targetWidth}x${targetHeight} oldClient=${clientWidth}x${clientHeight} oldWindow=${windowWidth}x${windowHeight} newWindow=${newWindowWidth}x${newWindowHeight} actualClient=${newClientWidth}x${newClientHeight}"
}

if ($Mode -eq "log") {
    Write-DebugLog "stage $Message"
} elseif ($Mode -eq "focus") {
    Write-DebugLog "focus"
} elseif ($Mode -eq "resize") {
    Set-ClientSize $TargetWidth $TargetHeight
} elseif ($Mode -eq "key") {
    Send-Key $KeyCode
} elseif ($Mode -eq "click") {
    if ($Box -ne "") {
        $center = Get-BoxCenter $Box
        Write-DebugLog "box=$Box center=($($center.X),$($center.Y))"
        $X = $center.X
        $Y = $center.Y
    }
    Send-Click $X $Y $BaseWidth $BaseHeight
} elseif ($Mode -eq "drag") {
    Send-Drag $X $Y $EndX $EndY $BaseWidth $BaseHeight $DurationMs
} else {
    Send-Wheel $X $Y $BaseWidth $BaseHeight $WheelDelta
}
