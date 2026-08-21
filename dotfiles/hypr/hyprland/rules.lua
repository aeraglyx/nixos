-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local colors = require("hyprland.theme")


local size_wide = { "monitor_w * 0.5", "monitor_h * 0.5" }
local size_high = { "monitor_w * 0.3", "monitor_h * 0.8" }
local size_thic = { "monitor_w * 0.6", "monitor_h * 0.7" }

local function match_floating_win(match, size)
    hl.window_rule({
        match = match,
        size = size,
        float = true,
        center = true,
    })
end


hl.window_rule({ match = { title = ".*Blender.*" },   workspace = "4" })
hl.window_rule({ match = { title = ".*Discord.*" },   workspace = "5" })
hl.window_rule({ match = { title = ".*Signal.*" },    workspace = "5" })
hl.window_rule({ match = { title = ".*Moonlight.*" }, workspace = "9" })
hl.window_rule({ match = { title = ".*Parsec.*" },    workspace = "9" })
hl.window_rule({ match = { title = ".*Tor Browser.*" }, workspace = "10" })


hl.window_rule({ match = { class = "firefox" }, scrolling_width = 0.7})
hl.window_rule({ match = { class = "blender" }, scrolling_width = 0.8})


match_floating_win({ class = "popup.app.wide" }, size_wide)
match_floating_win({ class = "popup.app.high" }, size_high)
match_floating_win({ class = "popup.app.thic" }, size_thic)

match_floating_win({ class = "blender", title = "Preferences" }, size_high)
match_floating_win({ class = "blender", title = "File Browser" }, size_wide)
match_floating_win({ class = "blender", title = "Image Editor" }, size_wide)

match_floating_win({ class = "xdg-desktop-portal-gtk" }, size_wide)
match_floating_win({ class = "qimgv", title = "Edit shortcut" }, size_wide)


hl.window_rule({ match = { class = "Matplotlib" }, float = true, center = true })
hl.window_rule({ match = { title = ".* - Moonlight.*" }, fullscreen = true })
hl.window_rule({ match = { class = "one.alynx.showmethekey" }, float = true })
hl.window_rule({
    match = { class = "showmethekey-gtk" },
    float = true,
    workspace = "4",
    no_initial_focus = true,
    move = { 40, 1190 },
    size = { 600, 80 }
})


hl.window_rule({ match = { class = "Tor Browser" }, border_color = colors.red })
hl.window_rule({ match = { float = false }, no_shadow = true })


-- ignore maximize requests from all apps
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})
