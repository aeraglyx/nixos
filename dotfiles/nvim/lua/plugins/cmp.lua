return {
    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = "InsertEnter",
    --     dependencies = {
    --         -- "onsails/lspkind.nvim",
    --         "saadparwaiz1/cmp_luasnip",
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-path",
    --         "hrsh7th/cmp-buffer",
    --         -- "hrsh7th/cmp-cmdline",
    --         "hrsh7th/cmp-nvim-lsp-signature-help",
    --     },
    --     config = function()
    --         local cmp = require("cmp")
    --         cmp.setup({
    --             sources = {
    --                 { name = "luasnip" },
    --                 { name = "nvim_lsp" },
    --                 { name = "path" },
    --                 { name = "buffer" },
    --                 { name = "nvim_lsp_signature_help" },
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ["<Tab>"] = cmp.mapping.confirm({ select = true })
    --             })
    --         })
    --     end
    -- },

    {
        "saghen/blink.cmp",

        version = "1.*",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "rafamadriz/friendly-snippets"
        },

        opts = {
            cmdline = {
                keymap = { preset = 'inherit' },
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

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },

        opts_extend = { "sources.default" }
    }
}
