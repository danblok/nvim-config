return {
    {
        "mfussenegger/nvim-lint",
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                bash = { "bash", "shellcheck" },
                docker = { "hadolint" },
                js = { "oxlint" },
                ts = { "oxlint" },
                sql = { "sqlfluff" },
                php = { "tlint" },
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
