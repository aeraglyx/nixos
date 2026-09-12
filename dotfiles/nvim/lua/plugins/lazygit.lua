vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/kdheepak/lazygit.nvim",
})

vim.g.lazygit_floating_window_scaling_factor = 1.0

vim.keymap.set("n", "<leader>gg", function()
    local file = vim.fn.expand("%:t")
    vim.cmd("LazyGit")
    vim.defer_fn(function()
        vim.api.nvim_feedkeys("/" .. file, "t", true)
        vim.api.nvim_input("<CR>")
        vim.api.nvim_input("<ESC>")
    end, 100) -- 40ms threshold on main pc
end, { desc = "[g]it" })
