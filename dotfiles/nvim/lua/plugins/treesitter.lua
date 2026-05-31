return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local parsers = {
                "bash",
                "c",
                "cpp",
                "glsl",
                "rust",
                "python",
                "julia",
                "diff",
                "nix",
                "gitignore",
                -- "editorconfig",
                "lua",
                "luadoc",
                "vim",
                "vimdoc",
                "markdown",
                "markdown_inline",
                "query",
                "json",
                "toml",
                "yaml",
                "xml",
                -- "csv",
                "hyprlang",
                "html",
                "css",
                "rasi",
                "ini",
            }
            require("nvim-treesitter").install(parsers)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = parsers,
                callback = function(args)
                    vim.treesitter.start(args.buf)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    }
}
