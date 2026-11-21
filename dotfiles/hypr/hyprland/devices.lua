-- https://wiki.hypr.land/configuring/core/devices/

local utils = require("hyprland.utils")

hl.device({
    name = "kensington-slimblade-pro-trackball(wired)-kensington-slimblade-pro-trackball(wired)",
    accel_profile = utils.accel_profile(1.1),
})

hl.device({
    name = "kensington-slimblade-pro(2.4ghz-receiver)-kensington-slimblade-pro-trackball(2.4ghz-receiver)",
    accel_profile = utils.accel_profile(1.1),
})

hl.device({
    name = "synps/2-synaptics-touchpad",
    accel_profile = utils.accel_profile(0.35),
    natural_scroll = true,
    scroll_factor = 0.15,
})
