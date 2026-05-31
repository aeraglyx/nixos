return {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
        {
            "<leader>fr",
            "<cmd>Yazi cwd<cr>",
            desc = "Open yazi in nvim's working directory",
        },
        {
            "<leader>ft",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
        {
            "<leader>fs",
            "<cmd>Yazi toggle<cr>",
            desc = "Resume the last yazi session",
        },
    },
    opts = {
        open_for_directories = false,
        floating_window_scaling_factor = 0.8,
        keymaps = {
            show_help = "<f1>",
        },
    },
    init = function()
        -- mark netrw as loaded so it's not loaded at all.
        -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
        vim.g.loaded_netrwPlugin = 1
    end,
}
