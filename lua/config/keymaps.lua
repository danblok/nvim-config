-- Switch lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Moving with cursor pinned to the center of the screen
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

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

-- Setup diagnostics keymap
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "[C]ode [D]iagnostics" })

-- Tmux navigation
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")

-- Fixes delay in sql files on pressing Ctrl+c
vim.g.ftplugin_sql_omni_key = "<C-j>"
