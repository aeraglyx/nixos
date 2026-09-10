vim.pack.add({
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/nvim-lua/plenary.nvim"
})

local todo = require("todo-comments")

todo.setup({
    signs = false,
    highlight = {
        multiline = false,
    },
})

vim.keymap.set("n", "]t", function() todo.jump_next() end, { desc = "Next TODO comment" })
vim.keymap.set("n", "[t", function() todo.jump_prev() end, { desc = "Previous TODO comment" })
