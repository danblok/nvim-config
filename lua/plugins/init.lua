return {
    -- Detect tabstop and shiftwidth automatically
    { "tpope/vim-sleuth" },

    -- Comment blocks
    { "numToStr/Comment.nvim", opts = {} },

    -- Indentation guides even on blank lines
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                show_start = false,
            },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "lewis6991/gitsigns.nvim",
    },
    {
        "jesseduffield/lazygit",
    },
}
