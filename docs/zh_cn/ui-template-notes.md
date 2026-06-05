# UI 模板提取建议

以下建议基于当前三类截图：启动页、探索/战斗界面、主城/大厅界面。

## 总原则

- 当前 PC 端脚本以 `1280x720` 客户区为基准。公开任务会在入口处自动检查窗口大小；若当前已经是 `1280x720`，会直接跳过调整。
- 不要用整张截图做模板。
- 优先裁剪稳定图标、按钮边框、固定文字或图标加文字组合。
- 避免裁入角色立绘、活动大图、动态特效、资源数值、倒计时、红点数字。
- 模板区域尽量小，但要包含足够辨识度。
- 对不同状态的同一按钮保留多个模板，例如普通、带红点、按下态、灰态。

## 启动页

适合提取：

- `TOUCH TO START` 文字区域，用于识别登录/开始界面。
- 左上角电源按钮图标，用于识别启动页或退出入口。
- 左上角设置按钮图标，用于识别启动页。
- `BROWN DUST II` 标志可作为辅助识别，但不建议作为唯一模板，因为语言、版本活动或启动图可能变化。

不建议提取：

- 角色立绘。
- 大面积雪景背景。
- 光带和飘雪特效。

建议模板：

- `resource/image/startup/touch_to_start.png`
- `resource/image/startup/title_logo.png`
- `resource/image/startup/settings_button.png`

## 探索/战斗界面

适合提取：

- 右上角房子图标，用于识别可返回主界面的探索/战斗 HUD。
- 左下角方向键整体或方向键中心区域，用于识别探索操作界面。
- 右下角技能/交互按钮的圆形边框组合，用于识别战斗/探索 HUD。
- 顶部资源条黑色胶囊背景可以作为辅助，但不要包含具体数字。

不建议提取：

- 地图背景、地面纹理、火光、角色位置。
- 顶部资源数字。
- 中间地图提示文字。
- 右侧技能按钮内的具体按键字母或数字，除非目标就是识别该状态。

建议模板：

- `resource/image/hud/home_button.png`
- `resource/image/hud/dpad.png`
- `resource/image/hud/action_cluster.png`

## 主城/大厅界面

这是最适合作为日常入口识别的界面。

适合提取：

- 左上角返回箭头，用于识别主城层级。
- 左侧 `我的小屋`、`好友`、`公会` 等圆形图标，图标比文字更稳定。
- 右上角邮件信封图标，用于奖励领取入口。
- 右上角房子/设置组合图标，用于主界面识别。
- 底部导航栏的 `任务`、`活动`、`商店`、`付费商店` 图标。
- 右侧 `快速狩猎`、`战术教材` 入口可作为固定副本相关模板。

不建议提取：

- 背景活动大图。
- 活动 Banner 文字和剩余时间。
- 资源数量。
- 红点和黄点角标本身，除非要专门识别是否有可领取内容。

建议模板：

- `resource/image/home/home_marker.png`：建议裁右上角房子/设置组合，或左侧一组稳定功能图标。
- `resource/image/reward/mail_entry.png`
- `resource/image/reward/task_entry.png`
- `resource/image/reward/activity_entry.png`
- `resource/image/shop/shop_entry.png`
- `resource/image/combat/quick_hunt_entry.png`

## 当前优先模板

第一轮只需要以下模板：

1. `startup/touch_to_start.png`
2. `home/home_marker.png`
3. `common/close_button.png`
4. `reward/mail_entry.png`
5. `reward/task_entry.png`

这些模板足够支撑“启动 -> 进入主界面 -> 领取基础奖励”的 MVP。

已裁剪模板的来源截图和坐标记录在 `docs/screenshots/template-crops.json`，预览图为 `docs/screenshots/template_preview.png`。

如需重新生成模板，可运行 `tools/crop_templates.ps1`。

## 刷粉流程基准

自动刷粉最初在较大的客户端窗口中调试过。为了减少点击偏移，当前流程已转为 `1280x720` 基准：

- 入口会先检查并按需调整 BD2 客户区到 `1280x720`。
- 背包入口使用模板识别后的 `{BOX}` 中心点击，不再使用旧固定坐标。
- 装备页签模板在 `1280x720` 下分数较低，阈值暂定为 `0.40`。
- 装备制作列表拖拽已从旧 `1328x897` 坐标换算到 `1280x720`。

后续若某一步失败，应优先查看日志中的 `box=[x,y,w,h]` 和 `client=1280x720`，再决定是更新模板、放宽阈值，还是调整固定坐标。
