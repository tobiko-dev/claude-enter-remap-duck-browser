; ================================================================
; Claude Enter Remap
; Author:  Woobin Park
; GitHub:  https://github.com/tobiko-dev
; Version: 1.0.0
; License: MIT
;
; Remaps keyboard shortcuts in AI chat interfaces running inside
; DuckDuckGo browser (including the Fire private window):
;   Enter       →  new line
;   Ctrl+Enter  →  send message
; ================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force

; ── CONFIGURATION ─────────────────────────────────────────────────────────────
FIRE_MODE := true
SITES     := ["Claude"]
; SITES  := ["Claude", "ChatGPT", "Gemini", "Perplexity", "Copilot", "Le Chat"]
; ─────────────────────────────────────────────────────────────────────────────

; ── Tray ──────────────────────────────────────────────────────────────────────
A_TrayMenu.Delete()
A_TrayMenu.Add("⌨  Claude Enter Remap  —  running", (*) => {})
A_TrayMenu.Disable("⌨  Claude Enter Remap  —  running")
A_TrayMenu.Add()
A_TrayMenu.Add("Reload", (*) => Reload())
A_TrayMenu.Add("Exit", (*) => ExitApp())
A_TrayMenu.Default := "⌨  Claude Enter Remap  —  running"

TrayTip("Claude Enter Remap", "Active — Enter remapped on DuckDuckGo", 1)

; ── Condition ─────────────────────────────────────────────────────────────────
IsAISite() {
    global FIRE_MODE, SITES
    try {
        proc := StrLower(WinGetProcessName("A"))
        if !InStr(proc, "duck")
            return false
        if FIRE_MODE
            return true
        title := WinGetTitle("A")
        for site in SITES
            if InStr(title, site)
                return true
        return false
    } catch {
        return false
    }
}

; ── Key remaps ────────────────────────────────────────────────────────────────
#HotIf IsAISite()

$Enter::  Send "+{Enter}"
$^Enter:: Send "{Ctrl Up}{Enter}"

#HotIf
