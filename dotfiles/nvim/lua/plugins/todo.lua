vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/folke/todo-comments.nvim",
})

local todo = require("todo-comments")

todo.setup({
    signs = false,
    highlight = {
        multiline = false,
    },
})

vim.keymap.set("n", "m.", function() todo.jump_next() end, { desc = "Next TODO comment" })
vim.keymap.set("n", "m,", function() todo.jump_prev() end, { desc = "Prev TODO comment" })
