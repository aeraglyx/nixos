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

-- local find_dotfiles = function() builtin.find_files({ cwd = "~/nixos/dotfiles" }) end
-- local find_nvim_files = function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end
-- local find_nixos_files = function() builtin.find_files({ cwd = "~/nixos" }) end

vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>sp", builtin.live_grep, { desc = "[S]earch by Gre[p]" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>se", builtin.oldfiles, { desc = "[S]earch Recent Files" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>gf", builtin.git_status, { desc = "Search [G]it [F]iles" })
-- vim.keymap.set("n", "<leader>sf", builtin.buffers, { desc = "[S]earch existing bu[f]fers" })
-- vim.keymap.set("n", "<leader>sb", builtin.builtin, { desc = "[S]earch Select Telescope" })
-- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

-- vim.keymap.set("n", "<leader>.", find_dotfiles, { desc = "Search dotfiles" })
-- vim.keymap.set("n", "<leader>vm", find_nvim_files, { desc = "Search nvim config files" })
-- vim.keymap.set("n", "<leader>no", find_nixos_files, { desc = "Search NixOS config files" })
