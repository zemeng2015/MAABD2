# MaaBD2

_棕色尘埃 2 PC 小助手_  
Powered by [MaaFramework](https://github.com/MaaXYZ/MaaFramework) & [MFAAvalonia](https://github.com/MaaXYZ/MFAAvalonia)

MaaBD2 是一个基于 MaaFramework 的《棕色尘埃 2》PC 端自动化助手项目。项目当前处于早期快速迭代阶段，优先适配 Windows PC 客户端，目标是把稳定、重复、低风险的日常操作交给脚本处理。

[简体中文](README.md) | [English](README.en.md)

## 使用须知

本项目仍在开发中，识别模板和流程会随着游戏界面、分辨率和任务需求逐步完善。当前推荐先在 PC 客户端、中文界面、窗口可见的环境下使用。

如果任务没有按预期执行，请保留 MFAAvalonia 导出的日志和当时的游戏截图；这些信息对定位模板偏移、窗口权限、点击落点和任务终止条件非常有用。

## 功能一览

- **连接并回到主界面**：识别登录界面、主界面和部分活动/副本界面；必要时按 `H` 或点击右上角 Home，尽量回到主界面作为后续任务起点。
- **PC 窗口控制**：通过 Win32 控制器连接 `BrownDust II` 客户端窗口，并使用隐藏脚本执行真实鼠标点击、拖拽、按键和窗口置前。
- **领取奖励**：目前支持从主界面进入邮箱等入口并尝试领取可见奖励；后续会继续补全签到、任务、活动红点等模板。
- **自动刷粉**：从主界面进入背包和装备制作，定位指定 N 级装备，打开强化设置，设置自动分解和制作数量，循环制作并分解获取粉尘。
- **刷粉选项**：支持选择分解 `佣兵剑` 或 `佣兵环饰`，并可选择执行 `1-99` 轮或持续运行直到材料不足。
- **自动爬塔**：面向固定阵容爬塔场景，检测自动战斗状态、胜利结算、前往下一层和确认按钮，逐步形成连续爬塔流程。
- **每日任务**：预留日常任务入口，用于后续串联回主界面、奖励领取、任务清理和其它低风险日常流程。
- **固定副本**：预留固定副本刷取功能，等待导航、战斗结束判断和异常恢复流程更稳定后继续扩展。
- **双语用户文档**：提供中文和英文文档目录，方便后续给普通用户和开发者分别补充安装、截图、模板裁剪和调试说明。

## 当前状态

MaaBD2 目前更适合用于测试和迭代，不建议在无人值守场景下长时间运行。已经验证过的重点能力包括：

- PC 客户端窗口绑定和置前。
- 登录页 `Touch To Start` 点击。
- 从部分非主界面返回主界面。
- 邮箱入口点击与无奖励场景处理。
- 自动刷粉的佣兵剑循环流程。
- 自动刷粉的装备、次数选项框架。

仍在完善的部分包括：

- 佣兵环饰详情页名称校验模板。
- 更多奖励入口和每日任务模板。
- 爬塔异常恢复和连续楼层稳定性。
- 不同分辨率、缩放比例和语言环境下的模板适配。

## 快速开始

1. 下载并解压 [MFAAvalonia](https://github.com/MaaXYZ/MFAAvalonia)。
2. 将本项目的 `interface*.json` 与 `resource` 目录放入 MFAAvalonia 运行目录。
3. 以管理员权限启动 MFAAvalonia。
4. 打开《棕色尘埃 2》PC 客户端，并保持游戏窗口可见。
5. 在 MFAAvalonia 中选择 MaaBD2 资源和 Windows PC 控制器。
6. 先运行“连接并回到主界面”，确认窗口绑定和点击权限正常。

更详细的设置说明见 [PC 设置指南](docs/zh_cn/pc-setup.md)。

## 文档

- [中文用户文档](docs/zh_cn/README.md)
- [English Documentation](docs/en_us/README.md)
- [截图采集清单](docs/zh_cn/capture-checklist.md)
- [UI 模板裁剪建议](docs/zh_cn/ui-template-notes.md)
- [开发计划](docs/zh_cn/development-plan.md)

## 项目结构

- `interface.json`：MaaFramework Project Interface V2 入口。
- `interface_zh.json` / `interface_en.json`：GUI 多语言文案。
- `resource/pipeline/`：任务流程定义。
- `resource/image/`：图像识别模板。
- `resource/tools/`：PC 端点击、拖拽、按键和循环计数辅助脚本。
- `docs/`：用户文档、开发记录和截图模板说明。
- `tools/`：本地模板裁剪等开发辅助工具。

## 参与开发

欢迎提交 issue、截图模板、流程建议和 pull request。比较有帮助的信息包括：

- 游戏所在界面截图。
- MFAAvalonia 导出的日志。
- 当前分辨率和缩放比例。
- 任务运行时实际点到的位置。
- 期望流程和异常复现步骤。

本项目参考了 MaaFramework 生态中多个助手项目的组织方式，README 结构参考 [MaaEnd](https://github.com/MaaEnd/MaaEnd)。
