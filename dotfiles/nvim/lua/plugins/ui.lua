vim.pack.add({ "https://github.com/nvim-mini/mini.diff" })
local diff = require("mini.diff")
diff.setup({
    view = {
        style = "sign",
        signs = { add = "┃", change = "┃", delete = "▁" },
    },
})



vim.pack.add({ "https://github.com/rcarriga/nvim-notify" })
local notify = require("notify")
notify.setup({
    background_colour = "#000000",
})



vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })
local colorizer = require("colorizer")
colorizer.setup({
    options = { parsers = { names = { enable = false }, }, },
})



vim.pack.add({
    "https://github.com/folke/noice.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/rcarriga/nvim-notify",
})
local noice = require("noice")
noice.setup({
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
})



vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
local indent = require("ibl")
-- event = {"BufReadPre", "BufNewFile"},
indent.setup({
    indent = { char = "|", tab_char = "|" },
    scope = { enabled = false },
})



vim.pack.add({ "https://github.com/folke/zen-mode.nvim" })
local zen = require("zen-mode")
zen.setup({
    window = {
        backdrop = 1,
        width = 100,
        height = 1,
    },
})



vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
local icons = require("nvim-web-devicons")
icons.setup({
    color_icons = false,
})

local colors = require("onyx.colors")
require("nvim-web-devicons").set_default_icon('', colors.text, 251)


