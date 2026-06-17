-- ── CONFIGURATION ─────────────────────────────────────────────────────────────
--
-- Window title keywords that activate the remap.
-- The check runs only when you press Return — never on a timer.
--
-- Default: claude.ai only
local SITES = { "Claude" }
--
-- Uncomment the line below to enable all major AI chat sites instead:
-- local SITES = { "Claude", "ChatGPT", "Gemini", "Perplexity", "Copilot", "Le Chat" }
--
-- ─────────────────────────────────────────────────────────────────────────────

local RETURN_KEY = hs.keycodes.map["return"]

local function isAISite()
    local win = hs.window.focusedWindow()
    if not win then return false end
    local app = win:application()
    if not app then return false end
    if not (app:name() or ""):find("Duck") then return false end
    local title = win:title() or ""
    for _, site in ipairs(SITES) do
        if title:find(site) then return true end
    end
    return false
end

hs.eventtap.new(
    { hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp },
    function(event)
        -- Fast exit for every key except Return — no work done at all
        if event:getKeyCode() ~= RETURN_KEY then return false end

        local flags = event:getFlags()

        -- Shift+Return already produces a new line — leave it alone
        if flags.shift then return false end

        -- Only act when on a configured AI site
        if not isAISite() then return false end

        local isDown = event:getType() == hs.eventtap.event.types.keyDown

        if flags.cmd or flags.ctrl then
            -- Cmd/Ctrl+Return  →  plain Return  (send message)
            return true, { hs.eventtap.event.newKeyEvent({}, "return", isDown) }
        else
            -- Plain Return  →  Shift+Return  (new line)
            return true, { hs.eventtap.event.newKeyEvent({"shift"}, "return", isDown) }
        end
    end
):start()
