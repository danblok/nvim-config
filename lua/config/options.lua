-- Sets relative and current line number.
vim.opt.number = true
vim.opt.relativenumber = true

-- Always show signcolumn
vim.opt.signcolumn = "yes"

-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Turns off hlsearch
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Sets no wrap
vim.opt.wrap = false

-- Sets strategy of splitting windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Syns clipboards
vim.opt.clipboard = "unnamedplus"

-- Sets cursor line to be in the center
vim.opt.scrolloff = 999

-- Opens a substitutions window below
vim.opt.inccommand = "split"

-- Enable virtual edit
vim.opt.virtualedit = "block"

-- Enable wider colors
vim.opt.termguicolors = true

-- Search ignores case and when there are cappital letters use smartcase
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Makes cursor thick in all modes
vim.o.guicursor = "i-ci:blinkwait700-blinkoff400-blinkon250"

-- Dont do backup
vim.opt.backup = false

-- Sets undodir directory
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Include '@' char in filenames
vim.opt.isfname:append("@-@")

---- Sets leader key
--vim.g.mapleader = " "
--vim.g.maplocalleader = " "

-- Better completition experience
vim.opt.completeopt = "menuone,noselect"

-- Set background to dark
vim.opt.background = "dark"
