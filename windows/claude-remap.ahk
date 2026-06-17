#Requires AutoHotkey v2.0
#SingleInstance Force

; ── CONFIGURATION ─────────────────────────────────────────────────────────────
;
; Window title keywords that activate the remap.
; The check runs only when you press Enter — never on a timer.
;
; Default: claude.ai only
SITES := ["Claude"]
;
; Uncomment the line below to enable all major AI chat sites instead:
; SITES := ["Claude", "ChatGPT", "Gemini", "Perplexity", "Copilot", "Le Chat"]
;
; ─────────────────────────────────────────────────────────────────────────────

A_IconHidden := true   ; No tray icon, fully silent

; ── Condition ─────────────────────────────────────────────────────────────────
; Called only when Enter is physically pressed — never on a timer or loop.
IsAISite() {
    global SITES
    try {
        proc  := StrLower(WinGetProcessName("A"))
        title := WinGetTitle("A")
        if !InStr(proc, "duck")
            return false
        for site in SITES
            if InStr(title, site)
                return true
        return false
    } catch {
        return false
    }
}

; ── Key remaps ────────────────────────────────────────────────────────────────
; $ = physical keypresses only, so Send below cannot re-trigger these.

#HotIf IsAISite()

$Enter::  Send "+{Enter}"   ; Enter       →  new line     (Shift+Enter)
$^Enter:: Send "{Enter}"    ; Ctrl+Enter  →  send message (Enter)

#HotIf
