-- Moving with cursor pinned to the center of the screen
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>X", ":source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- Paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Cancel action with Ctrl + C
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Buffers navigation
vim.keymap.set("n", "H", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "L", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", { silent = true })

-- For better experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Quickfix
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- Fixes delay in sql files on pressing Ctrl+c
vim.g.ftplugin_sql_omni_key = "<C-j>"
