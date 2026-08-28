return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        default_file_explorer = false,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                return name == ".." or name == ".git"
            end,
        },
    },
    lazy = false,
}
