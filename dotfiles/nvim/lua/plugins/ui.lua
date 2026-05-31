return {
    {
        "aeraglyx/onyx.nvim",
        dev = true,
        priority = 1000,
        config = function()
            require("onyx").setup()
            local reload_onyx = function()
                vim.cmd("Lazy reload onyx.nvim")
                local notify_orig = vim.notify
                vim.notify = function(...) end
                vim.cmd("Lazy reload lualine.nvim")
                vim.cmd("Lazy reload todo-comments.nvim")
                vim.cmd("Lazy reload indent-blankline.nvim")
                vim.cmd("Lazy reload nvim-notify")
                vim.cmd("Lazy reload gitsigns.nvim")
                vim.cmd("Lazy reload nvim-web-devicons")
                vim.notify = notify_orig
            end
            vim.keymap.set("n", "<leader>th", reload_onyx, { desc = "Reload [TH]eme" })
        end
    },
    {
        -- "uga-rosa/ccc.nvim"
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ "*" }, { names = false })
        end
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({ color_icons = false })
            local colors = require("onyx.colors")
            require("nvim-web-devicons").set_default_icon('', colors.text, 251)
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = require("onyx.lualine"),
                    section_separators = "",
                    component_separators = "",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { },
                    lualine_c = { { "branch", icon = "" }, "filename", "diagnostics" },
                    lualine_x = { "encoding", "fileformat", { "filetype", icons_enabled = false } },
                    lualine_y = { },
                    lualine_z = { "progress" }
                },
            })
        end
    },
    {
        "rcarriga/nvim-notify",
        opts = { background_colour = "#000000" },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            presets = { lsp_doc_border = true },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true },
                },
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = {"BufReadPre", "BufNewFile"},
        main = "ibl",
        opts = {
            indent = { char = "|", tab_char = "|" },
            scope = { enabled = false },
        }
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                backdrop = 1, -- shade of the backdrop (1 is normal)
                width = 120,
                height = 1,
            },
        }
    },
}
