# MaaBD2 User Guide

MaaBD2 is a Brown Dust 2 PC assistant project built on MaaFramework. The current version is still a development scaffold, focused on validating Win32 window binding, popup handling, home-screen detection, and reward collection.

## Current Goal

The first milestone is a stable daily-task loop:

1. Open the Brown Dust 2 PC client.
2. Bind the game window through the Win32 controller.
3. Close common popups.
4. Recognize the home screen.
5. Claim low-risk rewards such as mail and daily rewards.
6. Return to the home screen.
7. Stop with logs and screenshots when a state cannot be recognized.

Combat automation is intentionally deferred until the navigation and recovery loop is stable.

## Feature Status

- Window binding: scaffolded with a default window-title regex for the Brown Dust 2 PC client.
- Home-screen detection: waiting for template screenshots.
- Popup closing: waiting for close and confirm button templates.
- Mail rewards: flow placeholder is ready, waiting for entry and button templates.
- Daily missions: flow placeholder is ready, waiting for entry and button templates.
- Fixed-stage farming: reserved for later and disabled by default.

## Layout

- `interface.json`: Project Interface V2 entry for generic MaaFramework clients.
- `interface_zh.json`: Chinese UI labels.
- `resource/default_pipeline.json`: Shared default recognition and action settings.
- `resource/pipeline/common.json`: Common home detection, popup closing, and back navigation nodes.
- `resource/pipeline/startup.json`: Post-connection flow that identifies the current screen and returns to home.
- `resource/pipeline/reward.json`: Mail, sign-in, and daily reward flow.
- `resource/pipeline/daily.json`: Daily task orchestration.
- `resource/pipeline/combat.json`: Reserved for later fixed-stage farming.
- `docs/en_us/capture-checklist.md`: Screenshot capture checklist.
- `docs/en_us/ui-template-notes.md`: UI template extraction notes.
- `docs/en_us/pc-setup.md`: PC window binding and debugging guide.
- `docs/en_us/development-plan.md`: Development plan.

## Next Step

Collect the template screenshots listed in the capture checklist. For the first pass, only home-screen detection, popup closing, and one reward entry need to work reliably.

For PC debugging, keep the game window visible at first. Avoid minimizing it until the Win32 screenshot method is confirmed stable.
