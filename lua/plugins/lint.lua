return {
    {
        "mfussenegger/nvim-lint",
        dependencies = { "mason.nvim" },
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                go = { "revive" },
                bash = { "bash-language-server", "shellcheck" },
                hadolint = { "hadolint" },
                make = { "checkmake" },
                proto = { "buf" },
                js = { "oxlint", "biome" },
                ts = { "oxlint" },
                sql = { "sql-formatter" },
                php = { "tlint" },
                rs = { "bacon" },
                py = { "ruff" },
            },
        },
        config = function(_, opts)
            local lint = require("lint")
            lint.linters_by_ft = opts.linters_by_ft
            vim.api.nvim_create_autocmd(opts.events, {
                group = vim.api.nvim_create_augroup("lint", { clear = true }),
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
