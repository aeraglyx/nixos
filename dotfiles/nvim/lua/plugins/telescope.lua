vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        mappings = {
            i = { ["<esc>"] = actions.close },
        },
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        colorscheme = {
            enable_preview = true,
        },
    },
    extensions_list = { "fzf" },
})

local find_dotfiles = function() builtin.find_files({ cwd = "~/nixos/dotfiles" }) end
local find_nvim_files = function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end
local find_nixos_files = function() builtin.find_files({ cwd = "~/nixos" }) end

vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "search files" })
vim.keymap.set("n", "<leader>sp", builtin.live_grep, { desc = "[s]earch by gre[p]" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
vim.keymap.set("n", "<leader>si", builtin.highlights, { desc = "[s]earch h[i]ghlights" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
vim.keymap.set("n", "<leader>se", builtin.oldfiles, { desc = "[s]earch recent files" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[s]earch [k]eymaps" })
vim.keymap.set("n", "<leader>gf", builtin.git_status, { desc = "search [g]irl[f]riend"})
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
vim.keymap.set("n", "<leader>sf", builtin.buffers, { desc = "[s]earch existing bu[f]fers" })
vim.keymap.set("n", "<leader>sb", builtin.builtin, { desc = "[s]earch telescope [b]uiltins" })

vim.keymap.set("n", "<leader>.", find_dotfiles, { desc = "search dotfiles" })
vim.keymap.set("n", "<leader>vm", find_nvim_files, { desc = "search nvim config files" })
vim.keymap.set("n", "<leader>no", find_nixos_files, { desc = "search nixos config files" })
