return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                highlights = {
                    ["@variable.parameter"] = { fg = "@variable" },
                    ["@lsp.type.parameter"] = { fg = "@variable" },
                    ["@function.builtin"] = { fg = "@function" },
                },
            })
            vim.cmd.colorscheme("onedark")
        end,
    },
}
