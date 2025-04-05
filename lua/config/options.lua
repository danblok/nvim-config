local opt = vim.opt

-- Sets relative and current line number.
opt.number = true
opt.relativenumber = true

-- Maximum number of entries in a popup
opt.pumheight = 10

-- Preview incremental substitute
-- opt.inccommand = "nosplit"
opt.jumpoptions = "view"

opt.laststatus = 3

-- Always show signcolumn
opt.signcolumn = "yes"

-- Use spaces instead of tabs
opt.expandtab = true
opt.tabstop = 4
opt.smartindent = true

opt.shiftwidth = 4
opt.shiftround = true

-- Disable "Insert", "Visual", etc showing in the left bottom corner
-- opt.showmode = false

-- Turns off hlsearch
opt.hlsearch = false
opt.incsearch = true

-- Use rg
opt.grepprg = "rg --vimgrep"

-- Sets no wrap
opt.wrap = false

-- Sets strategy of splitting windows
opt.splitbelow = true
opt.splitright = true

-- Syns clipboards
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Sets cursor line to be in the center
opt.scrolloff = 999

-- Opens a substitutions window below
opt.inccommand = "split"

-- Enable virtual edit
opt.virtualedit = "block"

-- Enable wider colors
opt.termguicolors = true

-- Disable the default ruler
opt.ruler = false

-- Search ignores case and when there are cappital letters use smartcase
opt.ignorecase = true
opt.smartcase = true

-- Makes cursor thick in all modes
vim.o.guicursor = "i-ci:blinkwait700-blinkoff400-blinkon250"

-- Dont do backup
opt.backup = false

-- Sets undo settings
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.undolevels = 10000

-- Hide * markup for bold and italic, but not markers with substitutions
-- opt.conceallevel = 2

-- Include '@' char in filenames
opt.isfname:append("@-@")

-- Confirm to save changes before exiting modified buffer
opt.confirm = true

-- Better completition experience
opt.completeopt = "menu,menuone,noselect"

-- Set background to dar
opt.background = "dark"

-- Set some formatoptions
opt.formatoptions = "jcroqlnt"

opt.sidescrolloff = 8

opt.splitkeep = "screen"

-- Command-line completion mode
opt.wildmode = "longest:full,full"

-- Enable smoothscroll, didn't notice difference though
opt.smoothscroll = true

-- Border type for hover
opt.winborder = "rounded"
