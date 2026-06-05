# MaaBD2

![Platform](https://img.shields.io/badge/platform-Windows%20PC-4c8eda)
![Framework](https://img.shields.io/badge/powered%20by-MaaFramework-7b68ee)
![Status](https://img.shields.io/badge/status-active%20development-f6a434)
![Language](https://img.shields.io/badge/docs-中文%20%7C%20English-2ea44f)

_Brown Dust 2 PC Assistant_  
Powered by [MaaFramework](https://github.com/MaaXYZ/MaaFramework) & [MFAAvalonia](https://github.com/MaaXYZ/MFAAvalonia)

MaaBD2 is a Brown Dust 2 PC automation assistant built on MaaFramework. The project is in early active development and currently focuses on the Windows PC client. Its goal is to automate stable, repetitive, low-risk daily actions.

[简体中文](README.md) | [English](README.en.md)

## 📌 Notes

This project is still under development. Recognition templates and task flows will be improved as the game UI, resolutions, and automation needs evolve. For now, the recommended environment is the PC client with the Chinese UI and a visible game window.

If a task does not behave as expected, please keep the exported MFAAvalonia logs and a screenshot of the current game screen. They are very useful for debugging template offsets, window permissions, click positions, and task completion checks.

## ✨ Features

- 🏠 **Connect and return home**: Detects the login screen, home screen, and some activity/stage screens. When needed, it presses `H` or clicks the top-right Home button to return to the home screen.
- 🪟 **Automatic window normalization**: Public tasks first check the BD2 PC client area and resize it to the `1280x720` script baseline when needed.
- 🖥️ **PC window control**: Connects to the `BrownDust II` client window through the Win32 controller, then uses hidden helper scripts for real mouse clicks, drags, key presses, and window focusing.
- 🎁 **Reward claiming**: Enters visible reward entry points such as mail from the home screen and attempts to claim available rewards. More sign-in, mission, and event templates will be added gradually.
- 🧲 **Weekly Absorb / Rally**: Planned flow for entering story game cassettes, pressing `5/1/2/F` for Explore, Absorb, Rally, and map selection, then entering target maps. The default route is `7/8/9/13/16/17`. The first pass currently recognizes `Battle 1`.
- ⚙️ **Auto powder farm**: Opens inventory and equipment crafting, locates the selected N-rarity item, opens enhancement settings, enables auto dismantle, sets crafting quantity, then loops crafting and dismantling for powder.
- 🎚️ **Powder options**: Supports choosing `Mercenary Sword` or `Mercenary Bracelet`, and supports running `1-99` rounds or continuing until materials run out.
- 🗼 **Auto tower**: Designed for fixed-formation tower runs. It detects auto battle state, victory, next-floor buttons, and confirmation prompts to build a continuous tower-climbing flow.
- 📅 **Daily routine**: Reserved for chaining home recovery, reward claiming, mission cleanup, and other low-risk daily flows.
- ⚔️ **Fixed stage farming**: Reserved for repeated fixed-stage farming after navigation, battle-end checks, and recovery flows become stable.
- 🌐 **Bilingual documentation**: Includes Chinese and English documentation directories for user setup, template capture, cropping notes, and development planning.

## 🧪 Current Status

MaaBD2 is currently better suited for testing and iteration than long unattended runs. The most important verified capabilities are:

- ✅ PC client window binding and focusing.
- ✅ Login-page `Touch To Start` clicking.
- ✅ Returning to the home screen from several non-home screens.
- ✅ Mail entry clicking and no-reward handling.
- ✅ Mercenary Sword auto powder farming loop.
- ✅ Equipment and count options for powder farming.

Work still in progress:

- 🚧 Name verification template for the Mercenary Bracelet detail page.
- 🚧 More reward and daily-mission templates.
- 🚧 Tower recovery logic and continuous-floor stability.
- 🚧 Template adaptation for different resolutions, scaling ratios, and languages.

## 🚀 Quick Start

1. Download and extract [MFAAvalonia](https://github.com/MaaXYZ/MFAAvalonia).
2. Copy this project's `interface*.json` files and `resource` directory into the MFAAvalonia runtime directory.
3. Start MFAAvalonia as administrator.
4. Open the Brown Dust 2 PC client and keep the game window visible.
5. Select the MaaBD2 resource and the Windows PC controller in MFAAvalonia.
6. Run "Connect and Return Home" first to confirm that window binding, window-size checking, and click permissions work.

For detailed setup steps, see [PC Setup](docs/en_us/pc-setup.md).

## 📚 Documentation

- 🇨🇳 [中文用户文档](docs/zh_cn/README.md)
- 🇺🇸 [English Documentation](docs/en_us/README.md)
- 🖼️ [Capture Checklist](docs/en_us/capture-checklist.md)
- ✂️ [UI Template Notes](docs/en_us/ui-template-notes.md)
- 🧭 [Development Plan](docs/en_us/development-plan.md)

## 🧩 Project Layout

- `interface.json`: MaaFramework Project Interface V2 entry.
- `interface_zh.json` / `interface_en.json`: GUI localization strings.
- `resource/pipeline/`: Task flow definitions.
- `resource/image/`: Image recognition templates.
- `resource/tools/`: PC helper scripts for clicks, drags, key presses, and loop counting.
- `docs/`: User documentation, development notes, and screenshot/template guidance.
- `tools/`: Local development helpers such as template cropping scripts.

## 🤝 Contributing

Issues, screenshots, template crops, task-flow suggestions, and pull requests are welcome. Helpful debugging information includes:

- Screenshot of the current game screen.
- Exported MFAAvalonia logs.
- Current resolution and scaling ratio.
- The actual click position during task execution.
- Expected flow and reproduction steps.

This project follows common organization patterns in the MaaFramework ecosystem, with README structure inspired by [MaaEnd](https://github.com/MaaEnd/MaaEnd).
