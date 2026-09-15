local path = vim.fn.expand("~/projects/code/onyx.nvim/")

if vim.fn.isdirectory(path) == 1 then
    vim.opt.rtp:append(path)
else
    vim.pack.add({ "https://github.com/aeraglyx/onyx.nvim" })
end

local onyx = require("onyx")
onyx.setup()
