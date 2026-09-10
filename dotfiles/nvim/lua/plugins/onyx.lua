
vim.pack.add({
    "https://github.com/aeraglyx/onyx.nvim",
})

local onyx = require("onyx")

onyx.setup()

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
