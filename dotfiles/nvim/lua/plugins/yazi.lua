vim.pack.add({
    "https://github.com/mikavilpas/yazi.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
})

local yazi = require("yazi")

yazi.setup({
    floating_window_scaling_factor = 0.8,
    keymaps = {
        show_help = "<f1>",
    },
})

vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>fr", "<cmd>Yazi cwd<cr>",    { desc = "Open yazi in nvim's working directory" })
vim.keymap.set("n", "<leader>ft", "<cmd>Yazi<cr>",        { desc = "Open yazi at the current file" })
vim.keymap.set("n", "<leader>fs", "<cmd>Yazi toggle<cr>", { desc = "Resume the last yazi session" })
