return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        opts = {
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                lua = { "stylua" },
                yaml = { "yamlfmt" },
                sql = { "sqlfmt" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                javascript = { "biome" },
                typescript = { "biome" },
                html = { "prettierd" },
                css = { "biome" },
                vue = { "biome", "rustywind" },
                json = { "biome" },
                php = { "pint", "php_cs_fixer" },
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
