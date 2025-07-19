return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup()
            vim.cmd.colorscheme("catppuccin-frappe")
        end
    },
    -- {
    --     "rmehri01/onenord.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("onenord").setup()
    -- vim.cmd.colorscheme("onenord")
    --     end,
    -- },
}
