vim.pack.add({ "https://github.com/nguyenvukhang/nvim-toggler" })

local toggler = require("nvim-toggler")

toggler.setup({
    remove_default_keybinds = true,
})

vim.keymap.set({"n", "v"}, "<leader>te", toggler.toggle, { desc = "Toggle text" })
