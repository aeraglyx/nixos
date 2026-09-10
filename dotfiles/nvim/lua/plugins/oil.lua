vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons"
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
