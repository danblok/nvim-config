return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        opts = {
            -- log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                lua = { "stylua" },
                go = {
                    -- "gofumpt",
                    "golines",
                    "goimports-reviser",
                    "crlfmt",
                    "gci",
                },
                proto = { "buf" },
                yaml = { "yamlfmt" },
                sql = { "sqlfmt" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                javascript = { "biome", "biome-organize-imports" },
                javascriptreact = { "biome", "biome-organize-imports" },
                typescript = { "biome", "biome-organize-imports" },
                typescriptreact = { "biome", "biome-organize-imports" },
                html = { "biome", "superhtml", stop_after_first = true },
                css = { "biome", "vscode-css-language-server", "biome", stop_after_first = true },
                vue = { "biome", "rustywind", stop_after_first = true },
                json = { "biome", },
                python = { "ruff", "black", "isort" },
                -- php = { "duster" },
                php = { "pint" },
                blade = { "blade-formatter" },
                graphql = { "biome" },
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
