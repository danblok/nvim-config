return {
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruvbox-material")
            vim.api.nvim_set_hl(0, "GreenBold", { fg = "#d3869b" })
            vim.api.nvim_set_hl(0, "@variable.member", { fg = "#d4be98" })
            vim.api.nvim_set_hl(0, "@boolean", { fg = "#7daea3" })
            vim.api.nvim_set_hl(0, "@number", { fg = "#7daea3" })
            vim.api.nvim_set_hl(0, "@string.escape", { fg = "#7daea3" })
            vim.api.nvim_set_hl(0, "Normal", { bg = "#292828" })
        end,
    },
}
