# 开发计划

## 阶段 0：PC 环境

- MaaFramework 参考仓库位于 `../MaaFramework`。
- 确认通用 MaaFramework 客户端可以加载 `MaaBD2/interface.json`。
- 打开棕色尘埃2 PC 客户端。
- 确认 Win32 控制器能匹配游戏窗口标题。
- 先使用 `Foreground` 截图方式验证识别，再根据兼容性尝试 `Background`。

## 阶段 1：连接闭环

- 确认 `resource/pipeline/startup.json` 可以在绑定窗口后识别当前界面。
- 采集 `home/home_marker.png`。
- 采集 `common/close_button.png`。
- 运行 `Startup`，直到它能稳定回到主界面。
- 把每个意外弹窗补进 `CloseKnownPopup`。

## 阶段 2：奖励领取

- 采集邮件和每日任务入口模板。
- 实现邮件全部领取流程。
- 实现每日任务奖励领取流程。
- 尽量复用通用奖励弹窗处理。

## 阶段 3：日常流程

- 通过 `DailyRoutine` 串联启动和奖励领取。
- 增加失败截图和日志复盘说明。
- 记录支持的服务器、语言和分辨率。

## 阶段 4：固定副本

- 阶段 1 到 3 稳定后再开始。
- 选择一个低风险副本。
- 添加副本导航模板。
- 添加结算界面识别和重试限制。
