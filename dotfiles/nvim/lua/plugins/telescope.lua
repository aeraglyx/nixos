return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.0",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            }
        },

        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close
                        },
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

            local find_dotfiles = function()
                builtin.find_files({ cwd = "~/dotfiles" })
            end

            local find_nvim_files = function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end

            local find_nixos_files = function()
                builtin.find_files({ cwd = "~/nixos" })
            end

            vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Search Files" })
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>st", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
            vim.keymap.set("n", "<leader>se", builtin.oldfiles, { desc = "[S]earch Recent Files" })
            vim.keymap.set("n", "<leader>sf", builtin.buffers, { desc = "Search existing buffers" })
            vim.keymap.set("n", "<leader>sb", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
            vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            vim.keymap.set("n", "<leader>gf", builtin.git_status, { desc = "Search [G]it [F]iles" })

            vim.keymap.set("n", "<leader>.", find_dotfiles, { desc = "Search dotfiles" })
            vim.keymap.set("n", "<leader>vm", find_nvim_files, { desc = "Search nvim config files" })
            vim.keymap.set("n", "<leader>no", find_nixos_files, { desc = "Search NixOS config files" })
        end
    }
}
