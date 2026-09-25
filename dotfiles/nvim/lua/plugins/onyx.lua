local path = vim.fn.expand("~/projects/code/onyx.nvim/")

if vim.fn.isdirectory(path) == 1 then
    vim.opt.rtp:append(path)
else
    vim.pack.add({ "https://github.com/aeraglyx/onyx.nvim" })
end

local onyx = require("onyx")
onyx.setup()


local colors = require("onyx.colors")

local groups = {
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeSelection = { reverse = true, bold = true },
    TelescopeMatching = { fg = colors.blue, bold = true },
    TelescopePreviewLine = { link = "TelescopeSelection" },
    TelescopeResultsDiffUntracked = { fg = colors.peach },
    BlinkCmpMenuBorder = { link = "FloatBorder" },
    BlinkCmpDocBorder = { link = "BlinkCmpMenuBorder" },
    IblIndent = { fg = colors.smol },
    IblScope = { fg = colors.meh },
    OilFile = { fg = colors.meh },
    Rfc3339 = { fg = colors.dim },
}

for group, parameters in pairs(groups) do
    vim.api.nvim_set_hl(0, group, parameters)
end
