-- https://wiki.hypr.land/Configuring/Basics/Variables/

local colors = require("hyprland.theme")

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,

        col = {
            inactive_border = colors.smol,
            active_border = colors.meh,
        },

        resize_on_border = true,
        layout = "scrolling",

        snap = {
            enabled = true,
            respect_gaps = true,
        }
    },

    decoration = {
        rounding = 8,
        rounding_power = 3,

        shadow = {
            enabled = true,
            range = 1,
            render_power = 1,
            color = "#14141480",
            offset = {12, 12},
        },

        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        smart_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = false,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        focus_on_activate = true,
        background_color = colors.deep,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },

    input = {
        kb_layout  = "us",
        numlock_by_default = true,

        accel_profile = "custom 0.53 0.0 0.57 1.30 2.23 3.44 4.98 6.96",

        repeat_delay = 200,
        repeat_rate = 36,
    },

    cursor = {
        no_hardware_cursors = 1,
        inactive_timeout = 1,
    },

    ecosystem = {
        no_donation_nag = true,
    },
})
