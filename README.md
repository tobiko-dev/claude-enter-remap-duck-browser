# Claude Enter Remap

OS-level key interception for claude.ai in DuckDuckGo browser.
No extensions, no injection, no visible operations.

| Key            | Action        |
|----------------|---------------|
| Enter          | New line      |
| Shift+Enter    | New line      |
| Ctrl+Enter     | Send message  |
| Cmd+Enter      | Send message (Mac) |

The remap is active **only** when DuckDuckGo browser is the focused app
and the window title contains "Claude". All other apps and tabs are
unaffected.

---

## Windows — AutoHotkey v2

**Install:** https://www.autohotkey.com (get v2.x)

**Run:** double-click `claude-remap.ahk`
It runs silently with no tray icon, no window.

**Auto-start with Windows:**
1. `Win+R` → type `shell:startup` → Enter
2. Copy a shortcut to `claude-remap.ahk` into that folder

**How it works:** `#HotIf` evaluates only when you press Enter — no polling,
no timers. CPU usage is effectively zero.

---

## macOS — Hammerspoon

**Install:** https://www.hammerspoon.org
Grant Accessibility access when prompted (required for key interception).

**Add the config:**
Paste the contents of `claude-remap.lua` into `~/.hammerspoon/init.lua`,
then click Hammerspoon menu bar icon → **Reload Config**.

**Auto-start:** Hammerspoon launches at login by default.

**How it works:** `hs.eventtap` intercepts the Return key at the OS level.
The fast path exits immediately for any key that isn't Return, so overhead
is negligible.

---

## One known edge case

While a Claude tab is active, pressing plain Enter in the **address bar**
sends Shift+Enter instead (which typically opens the URL in a new window).
Workaround: use **Ctrl+Enter** in the address bar — the script remaps that
to plain Enter, which navigates normally.
