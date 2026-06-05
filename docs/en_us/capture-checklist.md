# Screenshot Capture Checklist

Use one fixed PC client window size for the first milestone. Start with a 16:9 or near-16:9 visible window.

## Required Screens

- Home screen with all normal buttons visible.
- Loading screen after app launch.
- Server login or tap-to-start screen, if present.
- Announcement popup.
- Event banner popup.
- Generic close button variants.
- Generic confirm button variants.
- Mail entrance on home screen.
- Task entrance on the bottom home navigation bar.
- Mail page with claim-all button.
- Mail page after all rewards are claimed.
- Daily mission entrance.
- Daily mission page with claimable rewards.
- Reward confirmation popup.
- Network error or reconnect dialog.

## Template Naming

- `resource/image/home/home_marker.png`
- `resource/image/common/close_button.png`
- `resource/image/reward/mail_entry.png`
- `resource/image/reward/task_entry.png`
- `resource/image/startup/touch_to_start.png`
- `resource/image/hud/home_button.png`

Keep templates small and stable. Prefer distinctive icons and text regions over full-screen screenshots.

See `resource/image/template-manifest.json` for the full template placement manifest.

## Notes To Record

- Game server and language.
- PC client source, window title, and window size.
- Win32 screenshot and input methods used during testing.
- Any popup that appears only once per day or only after updates.
