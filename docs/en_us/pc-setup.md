# PC Setup Guide

MaaBD2 currently targets the Brown Dust 2 PC client first. The usage model is similar to the Arknights PC client flow: open the game window first, then let the MaaFramework Win32 controller bind that window and perform recognition, clicks, and key input.

## Basic Flow

1. Open the Brown Dust 2 PC client.
2. Keep the game window visible. Avoid minimizing it during early testing.
3. Load `MaaBD2/interface.json` in a generic MaaFramework client.
4. Select the `Windows PC Client` controller.
5. Run `Connect And Return Home` first.

## Window Matching

The default window-title regex is:

```text
^BrownDust II$
```

If the client cannot find the game window, check the actual window title with PowerShell:

```powershell
Get-Process | Where-Object { $_.MainWindowTitle } | Select-Object ProcessName, MainWindowTitle
```

If your client uses a different window title, add a more accurate title fragment to `controller[0].win32.window_regex` in `interface.json`.

## Screenshot Method

The default is:

```json
"screencap": "Foreground"
```

This is usually good for early testing, but the window should not be minimized. If capture is unstable, try:

```json
"screencap": "Background"
```

If background capture does not work, switch back to `Foreground` and keep the game window visible.

## Input Method

The default is:

```json
"mouse": "PostMessageWithCursorPos",
"keyboard": "PostMessageWithCursorPos"
```

This briefly moves the cursor position and is often more compatible than plain `PostMessage`. If clicks do not work, try these in order:

- `SendMessageWithCursorPos`
- `PostMessage`
- `SendMessage`
- `Seize`

If the game runs as administrator, the generic client may also need to run as administrator.

## Current Limitations

- The assistant does not start the PC client automatically. Open the game manually first.
- Existing templates are from PC screenshots, but more popup, mail-page, and task-page screenshots are needed.
- `common/close_button.png` is disabled for now and should be added after popup screenshots are available.

## Return-Home Strategy

`Connect And Return Home` currently recovers in this order:

1. Check whether the home screen is already visible.
2. If the startup screen is visible, click `TOUCH TO START`.
3. Try to handle confirm and skip popups.
4. Press `H` to return home.
5. If the top-right Home button is visible, click it.
6. Loop until a home-screen UI marker is recognized.

The home-screen success condition currently accepts any of these: a stable top-right icon, the mail entry, or the bottom task entry.
