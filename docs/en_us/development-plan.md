# Development Plan

## Milestone 0: PC Environment

- MaaFramework reference clone exists in `../MaaFramework`.
- Confirm a generic MaaFramework client can load `MaaBD2/interface.json`.
- Open the Brown Dust 2 PC client.
- Confirm the Win32 controller can match the game window title.
- Start with `Foreground` screenshot capture, then try `Background` if compatibility allows.

## Milestone 1: Connection Loop

- Confirm `resource/pipeline/startup.json` can identify the current screen after the window is bound.
- Capture `home/home_marker.png`.
- Capture `common/close_button.png`.
- Run `Startup` until it can reliably reach the home screen.
- Add every unexpected popup to `CloseKnownPopup`.

## Milestone 2: Rewards

- Capture mail and daily mission entry templates.
- Implement mail claim-all flow.
- Implement daily mission claim flow.
- Keep reward popups generic where possible.

## Milestone 3: Daily Routine

- Chain startup and rewards through `DailyRoutine`.
- Add failure screenshots and log review notes.
- Document supported server, language, and resolution.

## Milestone 4: Fixed Stage Farming

- Only begin after Milestones 1-3 are stable.
- Pick one low-risk stage.
- Add stage navigation templates.
- Add result-screen recognition and retry limits.
