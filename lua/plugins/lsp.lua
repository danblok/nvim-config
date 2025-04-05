local function on_attach(_, bufnr)
    local map = vim.keymap.set
    local builtin = require("telescope.builtin")

    map("n", "<leader>gr", builtin.lsp_references, { desc = "[G]oto [R]eferences", buffer = bufnr })
    map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", buffer = bufnr })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction", buffer = bufnr })
    map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = bufnr })
    map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation", buffer = bufnr })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration", buffer = bufnr })
    map("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition", buffer = bufnr })
    map("n", "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation", buffer = bufnr })
    map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "[C]ode [D]iagnostics", buffer = bufnr })
end

vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    },
    on_attach = on_attach,
    root_markers = { ".git" },
})

local lsps = {
    lua_ls = "lua-language-server",
    vue_ls = "vue-language-server",
    phpactor = "phpactor",
    omnisharp = "omnisharp",
    gopls = "gopls",
    rust_ls = "rust-analyzer",
    -- pyright = "pyright",
    basedpyright = "basedpyright",
    -- pylyzer = "pylyzer",
    bash_ls = "bash-language-server",
    -- golangci_lint = "golangci-lint-langserver",
    -- buf = "buf",
}

vim.lsp.enable(vim.fn.keys(lsps))

return {
    {
        "williamboman/mason.nvim",
        opts_extend = { "ensure_installed" },
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
            },
            ensure_installed = {
                -- LSP
                "lua-language-server",
                "vue-language-server",
                "phpactor",
                "omnisharp",
                "gopls",
                "rust-analyzer",
                "bash-language-server",
                "pyright",
                "basedpyright",
                -- Linters and Formatters
                "golangci-lint-langserver",
                "ruff",
                "pint",
                "oxlint",
                "biome",
                "tlint",
                "golangci-lint",
                "shellcheck",
                "hadolint",
                "checkmake",
                "buf",
                "sqlfluff",
                "bacon",
                "prettierd",
                "csharpier",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                {
                    path = "${3rd}/luv/library",
                    words = {
                        "vim%.uv",
                    },
                }
            },
        },
    },
}
