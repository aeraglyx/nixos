-- https://wiki.hypr.land/Configuring/Basics/Binds/

local terminal = "ghostty"
local file_manager = "nautilus"
local browser = "firefox"

local main_mod = "SUPER"

local tmp_win_wide = { float = true, center = true, size = { "monitor_w * 0.5", "monitor_h * 0.5" }}
local tmp_win_high = { float = true, center = true, size = { "monitor_w * 0.3", "monitor_h * 0.8" }}

-- power
hl.bind(main_mod .. " + X", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(main_mod .. " + ALT + X", hl.dsp.exec_cmd("shutdown now"))
hl.bind(main_mod .. " + SHIFT + X", hl.dsp.exec_cmd("reboot"))

-- wm stuff
hl.bind(main_mod .. " + K", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(main_mod .. " + G", hl.dsp.window.close())
hl.bind(main_mod .. " + SHIFT + G", hl.dsp.window.kill())
hl.bind(main_mod .. " + Q", hl.dsp.window.close())
hl.bind(main_mod .. " + M", hl.dsp.window.fullscreen())
hl.bind(main_mod .. " + C", hl.dsp.exec_cmd("hyprlock"))

local function run_script(script)
    local scripts_dir = "~/nixos/scripts/"
    return hl.dsp.exec_cmd("sh " .. scripts_dir .. script)
end

-- scripts and stuff
hl.bind(main_mod .. " + P", hl.dsp.exec_cmd("flameshot gui --clipboard --path ~/pictures/screenshots"))
hl.bind(main_mod .. " + SHIFT + P", hl.dsp.exec_cmd("flameshot gui --clipboard --last-region --accept-on-select --path ~/pictures/screenshots"))
hl.bind(main_mod .. " + Z", run_script("screen_recording.sh"))
hl.bind(main_mod .. " + SHIFT + Z", hl.dsp.exec_cmd(file_manager .. " ~/videos", tmp_win_wide))
hl.bind(main_mod .. " + ALT + L", run_script("reload_stuff.sh"))
hl.bind(main_mod .. " + B", run_script("bookmarks/menu.sh"))
hl.bind(main_mod .. " + SHIFT + B", run_script("bookmarks/add.sh"))
hl.bind(main_mod .. " + ALT + T", run_script("time/time.sh"))
hl.bind(main_mod .. " + Period", run_script("menu.sh"))
hl.bind(main_mod .. " + Comma", hl.dsp.exec_cmd(terminal .. " -e bash -c \"cd ~/notes && nvim ./notes.md\"", tmp_win_high))
hl.bind(main_mod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wtype -"))

-- workspaces and programs
hl.bind(main_mod .. " + Space", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(main_mod .. " + T", hl.dsp.focus({ workspace = 1 }))
hl.bind(main_mod .. " + SHIFT + T", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + F", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + R", hl.dsp.focus({ workspace = 2 }))
hl.bind(main_mod .. " + SHIFT + R", hl.dsp.exec_cmd(browser))
hl.bind(main_mod .. " + L", hl.dsp.focus({ workspace = 4 }))

hl.bind(main_mod .. " + D", function()
    hl.dispatch(hl.dsp.focus({ workspace = 5 }))
    hl.dispatch(hl.dsp.exec_cmd("hyprctl clients | grep -Fq \"class: discord\" || discord"))
end)

hl.bind(main_mod .. " + W", function()
    hl.dispatch(hl.dsp.focus({ workspace = 9 }))
    hl.dispatch(hl.dsp.exec_cmd("pgrep moonlight || mullvad-exclude moonlight"))
end)

hl.bind(main_mod .. " + S", hl.dsp.exec_cmd(terminal .. " -e rmpc", tmp_win_wide))

local function web_app(url)
    return "chromium --app=" .. url
end

-- web apps
hl.bind(main_mod .. " + I", hl.dsp.exec_cmd(web_app("https://monkeytype.com/"), tmp_win_wide))
hl.bind(main_mod .. " + N", hl.dsp.exec_cmd(web_app("https://search.nixos.org/packages?channel=unstable"), tmp_win_wide))
hl.bind(main_mod .. " + SHIFT + N", hl.dsp.exec_cmd(web_app("https://search.nixos.org/options?channel=unstable"), tmp_win_wide))

-- move focus
hl.bind(main_mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + A", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + E", hl.dsp.focus({ direction = "down" }))
hl.bind(main_mod .. " + U", hl.dsp.focus({ direction = "up" }))

-- move and resize windows
hl.bind(main_mod .. " + ALT + H", hl.dsp.layout("swapcol l"))
hl.bind(main_mod .. " + ALT + A", hl.dsp.layout("swapcol r"))
hl.bind(main_mod .. " + ALT + E", hl.dsp.layout("colresize -0.1"))
hl.bind(main_mod .. " + ALT + U", hl.dsp.layout("colresize +0.1"))

-- starts at 1, 0 is at 10
local numpad_keys = { "KP_End", "KP_Down", "KP_Next", "KP_Left", "KP_Begin", "KP_Right", "KP_Home", "KP_Up", "KP_Prior", "KP_Insert" }

-- switch workspaces and move active window to a workspace
for i = 1, 10 do
    local key = numpad_keys[i]
    -- local key = i % 10 -- 10 maps to key 0
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(main_mod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- scroll through existing workspaces
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e+1" }))

-- focus previous workspace
hl.bind(main_mod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

-- move/resize windows with mouse
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(),                       { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(),                     { mouse = true })
hl.bind(main_mod .. " + mouse:274", hl.dsp.window.float({ action = "toggle" }), { mouse = true })

-- volume
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%+"),  { locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%-"),  { locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

-- brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- multimedia
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
