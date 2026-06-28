require("hyprland.config")
require("hyprland.binds")
require("hyprland.rules")
require("hyprland.animations")


hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})


hl.on("hyprland.start", function()
    hl.exec_cmd("sunsetr")
    hl.exec_cmd("hyprlock")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("mpd-mpris")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("ghostty", { workspace = "1" } )
    hl.exec_cmd("firefox", { workspace = "2 silent" } )
end)


hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
