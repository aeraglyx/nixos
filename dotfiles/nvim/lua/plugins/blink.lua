vim.pack.add({
    "https://github.com/saghen/blink.cmp",
    "https://github.com/saghen/blink.lib",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/rafamadriz/friendly-snippets",
})

local blink = require("blink.cmp")

blink.setup({
    cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
    },

    keymap = {
        preset = "none",
        ["<Tab>"] = { "accept", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
    },

    appearance = {
        nerd_font_variant = "mono"
    },

    completion = {
        menu = { border = "rounded" },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            window = { border = "rounded" },
        },
        ghost_text = {
            enabled = true,
            show_with_menu = false
        },
        trigger = {
            show_in_snippet = false
        }
    },

    signature = {
        enabled = true,
        window = { border = "rounded" }
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "lua" }
})
