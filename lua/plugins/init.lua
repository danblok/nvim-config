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
        "echasnovski/mini.surround",
        version = "*",
        config = function(_, config)
            require("mini.surround").setup(config)
        end,
    },
    {
        "tpope/vim-abolish",
        config = function() end,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
        },
        config = function() end,
    },
    -- {
    --     "fatih/vim-go",
    --     config = function() end,
    --     enable = false,
    -- },
}
