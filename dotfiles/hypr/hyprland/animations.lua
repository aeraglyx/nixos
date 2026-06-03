-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.curve("linear",   { type = "bezier", points = { {0.0, 0.0}, {1.0, 1.0} } })
hl.curve("ease_out", { type = "bezier", points = { {0.1, 1.0}, {0.1, 1.0} } })
hl.curve("wiggle",   { type = "spring", mass = 1, stiffness = 120.0, dampening = 16.0 })


hl.animation({ leaf = "global",        enabled = true, speed = 3.50, bezier = "ease_out" })

hl.animation({ leaf = "windows",       enabled = true, speed = 1.00, spring = "wiggle" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 12.0, bezier = "linear", style = "popin" })

hl.animation({ leaf = "layers",        enabled = true, speed = 1.00, spring = "wiggle" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 12.0, bezier = "linear", style = "popin" })
hl.animation({ leaf = "fadeLayersIn",  enabled = false })

hl.animation({ leaf = "border",        enabled = false })
hl.animation({ leaf = "workspaces",    enabled = false })
