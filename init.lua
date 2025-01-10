-- Set <leader> key to "space"
vim.g.mapleader = " "

-- Import keymaps and options
require("config.keymaps")
require("config.options")

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Import plugins from "lua/plugins/" dir
require("lazy").setup({
    spec = {
        { import = "config.plugins" },
        -- { import = "plugins" },
    },
})
