---------------------
---- KEYBINDINGS ----
---------------------

require("default_apps")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal), {description = "Launch Kitty Terminal Emulator"})
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close(), {description = "Close active program"})
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"), {description = "Close all programs and exit Hyprland"})


-- Launch Programs with Bindings
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), {description = "Dolphin File Manager"})
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser), {description = "Google Chrome Web Browser"})
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu), {description = "Launch App Selection Screen - Rofi"})
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(runner), {description = "Launch Hypr App Launcher"})
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo(), {description = "Toggle window size - weird"})
-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Toggle Fullscreen" })
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Toggle Maximize Window" })
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.layout("addmaster"), { description = "Addmaster to Master layout" })
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.layout("removemaster"), { description = "Remove master to Master layout" })
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle Floating" })
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-toggle-allfloat"), { description = "Toggle floating for all windows of workspace" })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split dwindle only" })
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }), { description = "Move focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }), { description = "Move focus up" })
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }), { description = "Move focus down" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true, description = "Increase window width with keyboard" })
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true, description = "Reduce window width with keyboard" })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true, description = "Increase window height with keyboard" })

hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" }), { description = "Swap tiled window left" })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }), { description = "Swap tiled window right" })
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "u" }), { description = "Swap tiled window up" })
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "d" }), { description = "Swap tiled window down" })

hl.bind(mainMod .. " + CTRL + A", function() hl.config({ general = { layout = "lua:columns" } }) end, { description = "Columns Layout"})
hl.bind(mainMod .. " + CTRL + G", function() hl.config({ general = { layout = "lua:grid" } }) end, {description = "Grid Layout"})
hl.bind(mainMod .. " + CTRL + S", function() hl.config({ general = { layout = "dwindle" } }) end, {description = "Dwindle Layout"})
hl.bind(mainMod .. " + CTRL + Z", function() hl.config({ general = { layout = "master" } }) end, { description = "Master Layout" })
hl.bind(mainMod .. " + CTRL + X", function() hl.config({ general = { layout = "scrolling" } }) end, { description = "Scrolling Layout" })




-- Actions
hl.bind(mainMod .. " + CTRL + K", hl.dsp.exec_cmd("~/.config/hypr/scripts/keybindings.sh"), { description = "Show keybindings" })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock Screen" })

hl.bind(mainMod .." + TAB", function ()
    local layouts   = { "scrolling", "dwindle", "master", "columns", "grid"}
    local workspace = hl.get_active_workspace()
    if hl.get_active_special_workspace() then
        workspace = hl.get_active_special_workspace()
    end

    local next_layout = "grid"

    if not workspace then
        return
    end

    for i = 1, #layouts do
        if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
        end
    end

    if workspace.special then
        hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
    else
        hl.workspace_rule({ workspace = "name:" .. tostring(workspace.name), layout = next_layout })
    end
end)


-- Hypr App Switcher
hl.bind("ALT + TAB",         hl.dsp.exec_cmd("qs -p ~/.local/share/hypr-app-switcher ipc call app-switcher next"), { description = "Switch applications on active workspace" })
hl.bind("ALT + SHIFT + Tab", hl.dsp.exec_cmd("qs -p ~/.local/share/hypr-app-switcher ipc call app-switcher prev"), { description = "Switch applications on active workspace (backwards)" })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}), {description = "Show Workspace x number"})
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false}), {description = "Move app to x workspace"})
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86Calculator", hl.dsp.exec_cmd(calculator), {description = "Launch Calculator"})
hl.bind("XF86Mail", hl.dsp.exec_cmd(email), {description = "Launch Email Client"})
hl.bind("XF86HomePage", hl.dsp.exec_cmd(browser), {description = "Launch Web Browser"})
hl.bind(mainMod .. " + L ", hl.dsp.exec_cmd("hyprlock"), { description = "Lock Screen" })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
