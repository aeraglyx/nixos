local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", "<leader>so", "<cmd>source %<CR>")
-- keymap.set("n", "<leader>e", "<cmd>Explore<CR>")
keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")
keymap.set("i", "<C-BC>", "<C-w>")

-- saving
keymap.set("n", "<C-s>", "<cmd>w<CR>")
keymap.set("v", "<C-s>", "<esc><cmd>w<CR>")
keymap.set("i", "<C-s>", "<esc><cmd>w<CR>gi")

-- quitting
keymap.set({ "n", "i", "v" }, "<C-d>", "<esc><cmd>q<CR>")
keymap.set({ "n", "i", "v" }, "<C-D>", "<esc><cmd>q!<CR>")

-- copying
keymap.set("v", "y", "ygv<esc>", { noremap = true, silent = true })
keymap.set("n", "Y", "<cmd>%y<CR>")

-- new lines
keymap.set("n", "<space>o", "mxo<esc>`x")
keymap.set("n", "<space>O", "mxO<esc>`x")

-- moving vertically through wrapped lines
keymap.set("n", "<down>", "gj")
keymap.set("n", "<up>", "gk")

-- moving lines up and down
keymap.set("n", "<A-e>", "<cmd>m +1<CR>==")
keymap.set("n", "<A-u>", "<cmd>m -2<CR>==")
keymap.set("v", "<A-e>", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "<A-u>", ":m '<-2<CR>gv=gv", { silent = true })
keymap.set("i", "<A-e>", "<esc><cmd>m +1<CR>==gi")
keymap.set("i", "<A-u>", "<esc><cmd>m -2<CR>==gi")

-- windows
keymap.set("n", "<leader>wa", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
keymap.set("n", "<leader>we", "<cmd>split<CR>", { desc = "Split window horizontally" })
keymap.set("n", "<leader>wi", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>wk", "<cmd>close<CR>", { desc = "Close current split" })

-- window navigation
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-a>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-e>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-u>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tk", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<F1>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<F3>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- comments
keymap.set("v", "m", "mxgc`x", { remap = true, desc = "Comment selection" })
keymap.set("n", "mm", "mxgcc`x", { remap = true, desc = "Comment line" })

-- TODO
keymap.set("n", "mo", "oTODO: <esc>mmA", { remap = true, desc = "Add a T[O]DO comment" })
keymap.set("n", "me", "oNOTE: <esc>mmA", { remap = true, desc = "Add a NOT[E] comment" })
keymap.set("n", "mh", "oHACK: <esc>mmA", { remap = true, desc = "Add a [H]ACK comment" })
keymap.set("n", "ma", "oWARN: <esc>mmA", { remap = true, desc = "Add a W[A]RN comment" })
keymap.set("n", "mf", "oFIXME: <esc>mmA", { remap = true, desc = "Add a [F]IXME comment" })
keymap.set("n", "mu", "oBUG: <esc>mmA", { remap = true, desc = "Add a B[U]G comment" })

-- numbers
keymap.set({ "n", "v" }, "+", "<C-a>", { desc = "Increment number" })
keymap.set({ "n", "v" }, "-", "<C-x>", { desc = "Decrement number" })

-- LSP
keymap.set("n", "l", "gr", { remap = true, desc = "LSP stuff" })
keymap.set("n", "<leader>er", "<cmd>lua vim.diagnostic.open_float(0)<CR>", { desc = "Show diagnostics" })

-- miscellaneous
keymap.set("n", "gl", "gx", { remap = true, desc = "[G]o to [L]ink" })
keymap.set("n", "fm", "mx:%s/\r$<CR>`x", { remap = true, desc = "Remove ^M" })
keymap.set("n", " ", "<nop>", { desc = "Ignore space", silent = true })

-- spell checking
vim.keymap.set("n", "<leader>sp", function()
    vim.cmd("setlocal spell!")
end, { desc = "Toggle spell checking" })

-- lazygit.nvim
keymap.set("n", "<leader>gg", function()
    local file = vim.fn.expand("%:t")
    vim.cmd("LazyGit")
    vim.defer_fn(function()
        vim.api.nvim_feedkeys("/" .. file, "t", true)
        vim.api.nvim_input("<CR>")
        vim.api.nvim_input("<ESC>")
    end, 100) -- 40ms threshold on main pc
end, { desc = "[g]it" })

-- zen mode
keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Zen Mode" })

-- oil.nvim
keymap.set("n", "<leader>et", "<cmd>Oil<CR>", { desc = "Open parent directory" })
