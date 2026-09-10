vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
})

local lualine = require("lualine")

local function modified_color()
    local colors = require("onyx.colors")
    return { fg = vim.bo.modified and colors.aqua or colors.dim }
end

lualine.setup({
    options = {
        theme = require("onyx.lualine"),
        section_separators = "",
        component_separators = "",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { },
        lualine_c = {
            { "branch", icon = "" },
            { "filename", color = modified_color, symbols = { modified = "" } },
            { "diagnostics" },
        },
        lualine_x = { "encoding", "fileformat", { "filetype", icons_enabled = false } },
        lualine_y = { },
        lualine_z = { "progress" }
    },
})
