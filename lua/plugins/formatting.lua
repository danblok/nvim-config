return {
    {
        "stevearc/conform.nvim",
        opts = {
            -- log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                lua = { "stylua" },
                go = {
                    "gofumpt",
                    "golines",
                    "goimports-reviser",
                },
                proto = { "buf" },
                yaml = { "yamlfmt" },
                sql = { "sqlfmt" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                js = { "prettierd" },
                ts = { "prettierd" },
                json = { "prettierd" },
                html = { "prettierd" },
                python = { "black", "isort" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
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
