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
                javascript = { "biome", "prettierd" },
                typescript = { "biome", "prettierd" },
                html = { "prettierd" },
                css = { "biome" },
                vue = { "prettierd", "rustywind" },
                json = { "prettierd" },
                python = { "black", "isort" },
                php = { "pint" },
                blade = { "blade-formatter" },
                csharp = { "csharpier" },
            },
            default_format_opts = {
                lsp_format = "fallback",
                async = false,
                quiet = false,
            },
            format_on_save = {
                timeout_ms = 1000,
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
