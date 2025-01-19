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
                vue = { "biome", "rustywind" },
                json = { "biome" },
                python = { "black", "isort" },
                php = { "tlint" },
            },
            default_format_opts = {
                lsp_format = "fallback",
                async = false,
                quiet = false,
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters = {
                golines = {
                    prepend_args = { "-m", "120" },
                },
            },
        },
    },
}
