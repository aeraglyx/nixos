vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/stevearc/oil.nvim",
})

local oil = require("oil")

oil.setup({
    default_file_explorer = false,
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
        end,
    },
})

vim.keymap.set("n", "<leader>et", "<cmd>Oil<CR>", { desc = "Open parent directory" })
