return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    vim.list_extend(opts.ensure_installed, {
                        "gomodifytags",
                        "impl",
                        "goimports-reviser",
                        "stylua",
                        "gofumpt",
                        "golangci-lint",
                    })
                end,
            },
        },
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.code_actions.gomodifytags,
                nls.builtins.code_actions.impl,
                nls.builtins.diagnostics.golangci_lint,
                nls.builtins.diagnostics.hadolint,
                nls.builtins.diagnostics.checkmake,
                nls.builtins.diagnostics.buf,
                nls.builtins.diagnostics.sqlfluff.with({
                    extra_args = { "--dialect", "postgres" },
                }),
            })
        end,
    },
}
