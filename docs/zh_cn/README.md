# MaaBD2 用户文档

MaaBD2 是一个基于 MaaFramework 的棕色尘埃2 PC 端助手项目。当前版本仍处于开发骨架阶段，优先验证窗口绑定、弹窗处理、主界面识别和奖励领取闭环。

## 当前目标

第一阶段目标是稳定的日常任务闭环：

1. 打开棕色尘埃2 PC 客户端。
2. 通过 Win32 控制器绑定游戏窗口。
3. 关闭常见弹窗。
4. 识别主界面。
5. 领取邮件、每日奖励等低风险奖励。
6. 返回主界面。
7. 遇到无法识别的状态时停止，并保留日志和截图用于诊断。

战斗自动化会等导航和恢复流程稳定后再开始。

## 功能状态

- 窗口绑定：骨架已建立，默认通过窗口标题匹配棕色尘埃2 PC 客户端。
- 主界面识别：等待截图模板。
- 弹窗关闭：等待关闭按钮和确认按钮模板。
- 邮件奖励：流程占位已建立，等待入口和按钮模板。
- 每日任务：流程占位已建立，等待入口和按钮模板。
- 固定副本：预留功能，默认关闭。

## 项目布局

- `interface.json`：通用 MaaFramework 客户端读取的 Project Interface V2 入口。
- `interface_zh.json`：界面中文文案。
- `resource/default_pipeline.json`：通用识别和动作默认参数。
- `resource/pipeline/common.json`：主界面识别、弹窗关闭、返回等通用节点。
- `resource/pipeline/startup.json`：连接后识别当前界面并回到主界面的流程。
- `resource/pipeline/reward.json`：邮件、签到、每日奖励流程。
- `resource/pipeline/daily.json`：日常任务总流程。
- `resource/pipeline/combat.json`：后续固定副本刷取预留。
- `docs/zh_cn/capture-checklist.md`：截图采集清单。
- `docs/zh_cn/ui-template-notes.md`：UI 模板裁剪建议。
- `docs/zh_cn/pc-setup.md`：PC 端窗口绑定与调试指南。
- `docs/zh_cn/development-plan.md`：开发计划。

## 下一步

先按截图采集清单补齐模板图。第一轮只需要稳定识别主界面、关闭弹窗、进入邮件或每日任务中的一个入口。

PC 端调试时请保持游戏窗口可见，先避免最小化窗口。若截图方式不稳定，再尝试切换 Win32 截图方式。
