return {
    { "EdenEast/nightfox.nvim" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                no_italic = true,
                integrations = {
                    blink_cmp = true,
                },
                float = {
                    transparent = true,
                    solid = true
                },
            })
            vim.cmd.colorscheme("catppuccin-frappe")
            -- Make the floating window's background color match the background color of the theme
            vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'CmpItemMenu' })
            vim.api.nvim_set_hl(0, "Pmenu", { link = "CmpItemMenu" })
            vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "CmpItemMenu" })
        end
    },
}
