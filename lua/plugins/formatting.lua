return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports-reviser", "golines", "gofumpt" },
                proto = { "buf" },
                yaml = { "yamlfmt" },
                sql = { "sqlfmt" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                js = { "prettierd" },
                html = { "prettierd" },
                python = { "black", "isort" },
            },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
            formatters = {
                golines = {
                    prepend_args = { "-m", "120" },
                },
                prettierd = {
                    env = {
                        string.format(
                            "PRETTIERD_DEFAULT_CONFIG=%s",
                            vim.fn.expand("~/.config/nvim/configs/.prettierrc.json")
                        ),
                    },
                },
            },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    require("conform").format({ bufnr = args.buf })
                end,
            })

            require("conform").setup(opts)
        end,
    },
}
