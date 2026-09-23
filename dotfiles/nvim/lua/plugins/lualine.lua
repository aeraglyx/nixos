vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
})

local lualine = require("lualine")
local colors = require("onyx.colors")

local theme = {
    normal = {
        a = { fg = colors.meh },
        b = { fg = colors.dim },
        c = { fg = colors.dim },
    },
}

local function modified_color()
    return { fg = vim.bo.modified and colors.blue or colors.dim }
end

lualine.setup({
    options = {
        theme = theme,
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
        lualine_x = {
            "selectioncount",
            "encoding",
            "fileformat",
            { "filetype", icons_enabled = false },
            "location",
            "progress",
        },
        lualine_y = { },
        lualine_z = { }
    },
})
