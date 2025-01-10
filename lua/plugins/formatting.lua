return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        opts = {
            log_level = vim.log.levels.DEBUG,
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
                js = { "biome" },
                ts = { "biome" },
                json = { "biome" },
                html = { "htmlbeautifier", "rustywind" },
                python = { "black", "isort" },
            },
            default_format_opts = {
                lsp_format = "fallback",
                async = false,
                quiet = false,
            },
            format_on_save = {
                timeout_ms = 500,
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
            vim.api.nvim_create_autocmd({ "BufWritePre", "BufNewFile" }, {
                pattern = "*",
                callback = function(args)
                    require("conform").format({ bufnr = args.buf or vim.api.nvim_get_current_buf() })
                end,
            })

            require("conform").setup(opts)
        end,
    },
}
