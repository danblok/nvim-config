local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities
})

return {
    {
        "neovim/nvim-lspconfig",
        event = "VimEnter",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            -- Setup rounded borders for LSP windows
            require("lspconfig.ui.windows").default_options.border = "rounded"

            vim.diagnostic.config({
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                } or {},
                virtual_text = {
                    source = "if_many",
                    prefix = "●", -- Could be '●', '▎', 'x'
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            })


            local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
                '/vue-language-server' .. '/node_modules/@vue/language-server'
            local vue_plugin = {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
                configNamespace = 'typescript',
            }
            vim.lsp.config('vtsls', {
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                vue_plugin,
                            },
                        },
                    },
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            })

            local lsps = {
                { "expert" },
                { "eslint" },
                { "vtsls" },
                -- { "vue_language_server", vtsls_config },
                { "vue_ls" },
                { "biome" },
                {
                    "cssls",
                    {
                        filetypes = { "css", "scss", "less" },
                        settings = {
                            less = { validate = true, },
                            scss = { validate = true, },
                        },
                    }
                },
                { "html" },
                {
                    "tailwindcss",
                },
                {
                    "emmet-language-server",
                    {
                        cmd = { "emmet-language-server", "--stdio" },
                        filetypes = { "blade", "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "typescriptreact", "vue" },
                        init_options = {
                            includeLanguages = {
                                blade = "html",
                            },
                        },
                    }
                },
                { "sql-language-server" },
                { "marksman" },
                { "bashls" },
                { "pyright" },
                { "gopls" },
                { "buf",                { filetypes = { "proto" } } },
                { "phpantom_lsp" },
                -- { "phpactor" },
                {
                    "lua_ls",
                    {
                        settings = {
                            Lua = {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                    version = "LuaJIT",
                                },
                                diagnostics = {
                                    -- Get the language server to recognize the `vim` global
                                    globals = { "vim" },
                                },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    library = {
                                        vim.env.VIMRUNTIME .. "/lua",         -- core Neovim API
                                        vim.env.VIMRUNTIME .. "/lua/vim/lsp", -- lspconfig / diagnostics
                                        vim.fn.stdpath("config") .. "/lua",   -- my config
                                    },
                                },
                                -- Do not send telemetry data containing a randomized but unique identifier
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    }
                },
            }

            for _, lsp in pairs(lsps) do
                local name, config = lsp[1], lsp[2]

                vim.lsp.enable(name)

                if config then
                    vim.lsp.config(name, config)
                end
            end
        end,
    },
    {
        "mason-org/mason.nvim",
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
