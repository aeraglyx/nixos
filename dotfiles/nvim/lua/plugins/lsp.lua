return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "saghen/blink.cmp",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()

            local lua_ls_opts = {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        }
                    }
                }
            }

            local nixd_opts = {
                cmd = { "nixd" },
                settings = {
                    nixd = {
                        nixpkgs = { expr = "import <nixpkgs> {}" },
                        -- formatting = { command = { "alejandra" } },
                    }
                }
            }

            local basedpyright_opts = {
                settings = {
                    basedpyright = {
                        -- "off", "basic", "standard", "strict", "recommended", "all"
                        typeCheckingMode = "standard",
                    },
                }
            }

            vim.lsp.config("lua_ls", lua_ls_opts)
            vim.lsp.config("basedpyright", basedpyright_opts)
            vim.lsp.config("nixd", nixd_opts)

            vim.lsp.enable({
                "lua_ls",
                "clangd",
                "basedpyright",
                "nixd",
                "bashls",
                "rust_analyzer",
                "cssls",
                "julials",
            })

            -- require('lspconfig.ui.windows').default_options.border = "rounded"

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("attach-lsp-group", { clear = true }),
                callback = function(args)

                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    client.server_capabilities.semanticTokensProvider = nil

                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                    map("<leader>re", vim.lsp.buf.rename, "[RE]name")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    map("K", vim.lsp.buf.hover, "TODO")
                    map("<leader>rs", ":LspRestart<CR>", "[R]e[S]tart LSP server")
                end
            })
        end
    }
}
