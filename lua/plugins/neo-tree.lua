return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        },
        opts = {
            window = {
                position = "current",
            },
            default_component_configs = {
                indent = {
                    indent_size = 4,
                    padding = 4,
                },
            },
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)

            -- Disable dark background
            vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none", fg = "none", ctermfg = "none", ctermbg = "none" })
            vim.api.nvim_set_hl(
                0,
                "NeoTreeEndOfBuffer",
                { bg = "none", fg = "none", ctermfg = "none", ctermbg = "none" }
            )
        end,
    },
}
