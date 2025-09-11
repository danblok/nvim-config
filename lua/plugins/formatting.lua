return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
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
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                html = { "prettier", "superhtml", stop_after_first = true },
                css = { "vscode-css-language-server", "biome", stop_after_first = true },
                vue = { "prettierd", "prettier", "rustywind" },
                json = { "biome", "prettierd" },
                python = { "ruff", "black", "isort" },
                -- php = { "duster" },
                php = { "pint" },
                blade = { "tlint" },
                -- csharp = { "csharpier" },
            },
            default_format_opts = {
                lsp_format = "fallback",
                async = false,
                quiet = false,
            },
            format_on_save = {
                timeout_ms = 5000,
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
