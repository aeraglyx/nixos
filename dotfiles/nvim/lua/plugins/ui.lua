vim.pack.add({ "https://github.com/nvim-mini/mini.diff" })
local diff = require("mini.diff")
diff.setup({
    view = {
        style = "sign",
        signs = { add = "┃", change = "┃", delete = "▁" },
    },
})



vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })
local colorizer = require("colorizer")
colorizer.setup({
    options = { parsers = { names = { enable = false }, }, },
})



vim.pack.add({ "https://github.com/rachartier/tiny-cmdline.nvim" })
local tiny_cmdline = require("tiny-cmdline")
tiny_cmdline.setup({
    width = { value = 60 },
    position = { y = "75%" },
    native_types = { },
})



vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
local indent = require("ibl")
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
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Zen Mode" })



vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
local icons = require("nvim-web-devicons")
icons.setup({
    color_icons = false,
})
local colors = require("onyx.colors")
require("nvim-web-devicons").set_default_icon('', colors.text, 251)


