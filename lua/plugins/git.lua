-- Git related plugins

return {
    {
        "tpope/vim-fugitive",
    },
    { "tpope/vim-rhubarb" },
    {
        "lewis6991/gitsigns.nvim",
        keys = {
            { "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Prview hunk", silent = true } },
            {
                "<leader>gt",
                ":Gitsigns toggle_current_line_blame<CR>",
                { desc = "Toggle current line blame", silent = true },
            },
        },
        config = true,
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open git" },
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    },
}
