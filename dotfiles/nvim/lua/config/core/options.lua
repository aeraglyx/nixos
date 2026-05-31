vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.iskeyword:append("-")

-- TODO: per ft (.md)
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.scrolloff = 4
vim.opt.mousescroll = "ver:1,hor:1"

vim.opt.inccommand = "split"
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = "%s%3l  "
vim.opt.fillchars:append { eob = " " }

vim.opt.list = true
vim.opt.listchars = "tab:> ,trail:•"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.g.have_nerd_font = true
vim.opt.laststatus = 3
vim.opt.winborder = "rounded"

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.diagnostic.config({
    virtual_text = { current_line = true },
    -- virtual_lines = { current_line = true },
    -- underline = { severity = vim.diagnostic.severity.WARN },
    float = { header = "" },
    signs = false,
})

vim.filetype.add({
    extension = {
        sh = "bash",
        jsonc = "json",
        rasi = "rasi",
        fuse = "lua",
        tmTheme = "xml",
    },
    pattern = {
        [".*/hypr/.*%.conf"] = "hyprlang",
        [".*/config"] = "ini",
        [".*/dunstrc"] = "config",
    },
})

vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Disable New Line Comment",
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Hightlight selection on yank",
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    -- pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
})
