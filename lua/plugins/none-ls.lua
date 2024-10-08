return {
    -- {
    --     "nvimtools/none-ls.nvim",
    --     dependencies = {
    --         {
    --             "williamboman/mason.nvim",
    --             opts = function(_, t)
    --                 t.ensure_installed = t.ensure_installed or {}
    --                 t = vim.list_extend(t.ensure_installed, {
    --                     "stylua",
    --                     "yamlfmt",
    --                     "gofumpt",
    --                     "goimports-reviser",
    --                     "sqlfmt",
    --                     "prettierd",
    --                     "golines",
    --                     "isort",
    --                     "gomodifytags",
    --                     "impl",
    --                     "golangci-lint",
    --                     "buf",
    --                     "checkmake",
    --                     "hadolint",
    --                     "sqlfluff",
    --                     "shfmt",
    --                     "black",
    --                     "golangci-lint",
    --                     "gomodifytags",
    --                     "gotests",
    --                     "buf",
    --                     "htmlint",
    --                     "shellcheck",
    --                 })
    --             end,
    --         },
    --     },
    --     config = function(_, opts)
    --         local nls = require("null-ls")
    --         opts.sources = vim.list_extend(opts.sources or {}, {
    --             nls.builtins.code_actions.gomodifytags,
    --             nls.builtins.code_actions.impl,
    --             -- nls.builtins.code_actions.tsserver,
    --             -- nls.builtins.diagnostics.tsserver,
    --             nls.builtins.diagnostics.golangci_lint,
    --             nls.builtins.diagnostics.hadolint,
    --             nls.builtins.diagnostics.checkmake,
    --             nls.builtins.diagnostics.buf,
    --             nls.builtins.diagnostics.sqlfluff.with({
    --                 extra_args = { "--dialect", "postgres" },
    --             }),
    --         })
    --     end,
    -- },
}
