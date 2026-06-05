# PC 端调试指南

MaaBD2 当前优先支持棕色尘埃2 PC 客户端。使用方式接近明日方舟 PC 端：先打开游戏窗口，再由 MaaFramework 的 Win32 控制器绑定窗口并执行识别、点击和按键。

## 基本流程

1. 打开棕色尘埃2 PC 客户端。
2. 保持游戏窗口可见，先不要最小化。
3. 用通用 MaaFramework 客户端加载 `MaaBD2/interface.json`。
4. 选择 `Windows PC 客户端` 控制器。
5. 先运行 `连接并回到主界面`。

## 窗口匹配

当前默认窗口标题正则为：

```text
^BrownDust II$
```

如果客户端无法找到窗口，请先确认实际窗口标题。可以在 PowerShell 中运行：

```powershell
Get-Process | Where-Object { $_.MainWindowTitle } | Select-Object ProcessName, MainWindowTitle
```

如果你的客户端窗口标题不同，再把更准确的标题片段加入 `interface.json` 的 `controller[0].win32.window_regex`。

## 截图方式

默认使用：

```json
"screencap": "Foreground"
```

这通常适合早期调试，但要求窗口不要最小化。如果截图不稳定，可以尝试：

```json
"screencap": "Background"
```

若后台截图不可用，再回到 `Foreground`，并保持窗口在前台或至少可见。

## 输入方式

默认使用：

```json
"mouse": "PostMessageWithCursorPos",
"keyboard": "PostMessageWithCursorPos"
```

这类方式会短暂移动光标位置，兼容性通常比纯 `PostMessage` 更好。如果点击没有效果，可以依次尝试：

- `SendMessageWithCursorPos`
- `PostMessage`
- `SendMessage`
- `Seize`

如果游戏本身以管理员权限运行，通用客户端也可能需要以管理员权限运行。

## 当前限制

- 助手不会自动启动 PC 客户端，请先手动打开游戏。
- 现有截图模板来自 PC 端截图，但还需要更多弹窗、邮件页和任务页截图。
- `common/close_button.png` 暂未启用，等有弹窗截图后再补。

## 回主界面策略

当前 `连接并回到主界面` 会按以下顺序恢复：

1. 检查是否已到主界面。
2. 如果在启动页，点击 `TOUCH TO START`。
3. 尝试处理确认、跳过等弹窗。
4. 按 `H` 回到主界面。
5. 如果右上角 Home 按钮可见，点击 Home。
6. 循环等待，直到识别到主界面 UI。

主界面成功条件目前包括右上角稳定图标、邮件入口、底部任务入口中的任意一个。
