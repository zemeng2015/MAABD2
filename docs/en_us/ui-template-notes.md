# UI Template Extraction Notes

These notes are based on the current screenshot categories: startup screen, exploration/combat HUD, and home/lobby screen.

## General Rules

- The current PC task baseline is a `1280x720` client area. Run "Normalize Window Size" before tasks when possible; the powder-farming task also normalizes the window at entry.
- Do not use full screenshots as templates.
- Prefer stable icons, button borders, fixed text, or icon-plus-label combinations.
- Avoid character art, event banners, dynamic effects, resource numbers, timers, and notification badge numbers.
- Keep templates small, but include enough distinctive detail.
- Keep multiple templates for the same button when useful, such as normal, badged, pressed, or disabled states.

## Startup Screen

Good candidates:

- `TOUCH TO START`, used to detect the login/start screen.
- Top-left power icon, used as a startup-screen or exit-entry marker.
- Top-left settings icon, used as another startup-screen marker.
- `BROWN DUST II` logo can be used as a secondary marker, but should not be the only template because language, version, or event startup art may change.

Avoid:

- Character art.
- Large snowy background regions.
- Light bands and snow particle effects.

Suggested templates:

- `resource/image/startup/touch_to_start.png`
- `resource/image/startup/title_logo.png`
- `resource/image/startup/settings_button.png`

## Exploration / Combat HUD

Good candidates:

- Top-right home icon, used to identify an exploration/combat HUD that can return to home.
- Bottom-left D-pad or D-pad center region, used to identify the exploration control screen.
- Bottom-right circular action cluster, used to identify combat/exploration HUD.
- Top resource bar capsule background can be used as a secondary marker, but crop out the numeric values.

Avoid:

- Map background, floor texture, firelight, and character positions.
- Resource numbers.
- Center map hint text.
- Specific key labels or numbers inside skill buttons unless that state is the target.

Suggested templates:

- `resource/image/hud/home_button.png`
- `resource/image/hud/dpad.png`
- `resource/image/hud/action_cluster.png`

## Home / Lobby Screen

This is the best screen for daily task entry detection.

Good candidates:

- Top-left back arrow, used to identify the current lobby layer.
- Left-side circular icons such as My Room, Friends, and Guild; icons are usually more stable than text.
- Top-right mail icon, used as a reward-entry target.
- Top-right home/settings icon group, used for home-screen detection.
- Bottom navigation icons such as Tasks, Events, Shop, and Paid Shop.
- Right-side Quick Hunt and Tactical Lesson entries, useful for later fixed-stage workflows.

Avoid:

- Background event art.
- Event banner text and countdowns.
- Resource values.
- Red or yellow notification badges by themselves, unless the task is specifically to detect claimable content.

Suggested templates:

- `resource/image/home/home_marker.png`: crop the top-right home/settings group, or a stable cluster of left-side feature icons.
- `resource/image/reward/mail_entry.png`
- `resource/image/reward/task_entry.png`
- `resource/image/reward/activity_entry.png`
- `resource/image/shop/shop_entry.png`
- `resource/image/combat/quick_hunt_entry.png`

## Current Priority Templates

The first pass only needs:

1. `startup/touch_to_start.png`
2. `home/home_marker.png`
3. `common/close_button.png`
4. `reward/mail_entry.png`
5. `reward/task_entry.png`

These are enough for the MVP loop: start app, enter home, and claim basic rewards.

The source screenshots and crop boxes for generated templates are recorded in `docs/screenshots/template-crops.json`. The preview sheet is `docs/screenshots/template_preview.png`.

To regenerate the templates, run `tools/crop_templates.ps1`.

## Powder Flow Baseline

Auto powder farming was originally tuned on a larger client window. To reduce click offsets, the current flow now uses a `1280x720` baseline:

- The task entry resizes the BD2 client area to `1280x720`.
- The bag entry clicks the recognized `{BOX}` center instead of an old fixed coordinate.
- The equipment-tab template scores lower at `1280x720`, so its threshold is temporarily set to `0.40`.
- Equipment-crafting list drags have been converted from the old `1328x897` coordinate baseline to `1280x720`.

When a later step fails, first check the log for `box=[x,y,w,h]` and `client=1280x720`, then decide whether to update the template, relax the threshold, or adjust a fixed coordinate.
