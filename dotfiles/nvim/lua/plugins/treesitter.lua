vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

local treesitter = require("nvim-treesitter")

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
    "hyprlang",
    "html",
    "css",
    "rasi",
    "ini",
    "ron",
}

treesitter.install(parsers):wait(60000)

local filetypes = vim.iter(parsers)
    :map(function(lang) return vim.treesitter.language.get_filetypes(lang) end)
    :flatten(1):totable()

vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function(args)
        vim.treesitter.start(args.buf)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
            vim.cmd("TSUpdate")
        end
    end
})
