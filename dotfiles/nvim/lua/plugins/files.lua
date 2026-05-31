return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        opts = {
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return name == ".." or name == ".git"
                end,
                -- natural_order = true,
            },
        },
        lazy = false,
    },
}
