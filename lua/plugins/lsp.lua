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

-- local lsps = {
--     lua_ls = "lua-language-server",
--     vue_ls = "vue-language-server",
--     phpactor = "phpactor",
--     omnisharp = "omnisharp",
--     gopls = "gopls",
--     rust_ls = "rust-analyzer",
--     -- pyright = "pyright",
--     basedpyright = "basedpyright",
--     -- pylyzer = "pylyzer",
--     bash_ls = "bash-language-server",
--     vts_ls = "vtsls",
--     -- golangci_lint = "golangci-lint-langserver",
--     -- buf = "buf",
-- }

-- vim.lsp.enable(vim.fn.keys(lsps))

return {
    {
        "neovim/nvim-lspconfig",
        event = "VimEnter",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            -- Setup neovim lua configuration
            -- rounded border
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

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- TS/JS

            -- managed to get vue-language-server working with vtsls following https://github.com/vuejs/language-tools/wiki/Neovim
            local vue_language_server_path = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

            local vue_plugin = {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
                configNamespace = "typescript",
            }
            local vtsls_config = {
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                vue_plugin,
                            },
                        },
                    },
                },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            }

            local vue_ls_config = {
                on_init = function(client)
                    client.handlers["tsserver/request"] = function(_, result, context)
                        local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
                        if #clients == 0 then
                            vim.notify("Could not found `vtsls` lsp client, vue_lsp would not work without it.",
                                vim.log.levels.ERROR)
                            return
                        end
                        local ts_client = clients[1]

                        local param = unpack(result)
                        local id, command, payload = unpack(param)
                        ts_client:exec_cmd({
                            title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
                            command = "typescript.tsserverRequest",
                            arguments = {
                                command,
                                payload,
                            },
                        }, { bufnr = context.bufnr }, function(_, r)
                            local response_data = { { id, r.body } }
                            ---@diagnostic disable-next-line: param-type-mismatch
                            client:notify("tsserver/response", response_data)
                        end)
                    end
                end,
            }
            -- nvim 0.11 or above
            vim.lsp.config("vtsls", vtsls_config)
            vim.lsp.config("vue_ls", vue_ls_config)
            vim.lsp.enable({ "vtsls", "vue_ls" })

            -- Biome
            vim.lsp.config("biome", { capabilities = capabilities })
            vim.lsp.enable("biome")

            -- CSS
            local css_settings = {
                validate = true,
                lint = {},
            }

            -- Turn of unknownAtRules if in a Tailwind project
            -- if is_tailwind_project() then
            --     css_settings.lint.unknownAtRules = "ignore"
            -- end

            vim.lsp.config("cssls", {
                capabilities = capabilities,
                filetypes = { "css", "scss", "less" },
                settings = {
                    css = css_settings,
                    less = {
                        validate = true,
                    },
                    scss = {
                        validate = true,
                    },
                },
            })
            vim.lsp.enable("cssls")

            -- HTML
            -- vim.lsp.config("html", {
            --     capabilities = capabilities,
            --     cmd = { "superhtml", "--stdio" },
            --     filetypes = { "html", "php" },
            --     init_options = {
            --         configurationSection = { "html", "css", "javascript" },
            --         embeddedLanguages = {
            --             css = true,
            --             javascript = true,
            --         },
            --     },
            -- })
            vim.lsp.enable("html")

            -- JSON

            -- Conditionally set up jsonls and EsLint if biome.json does not exist
            -- if not biome_file_exists() then
            --     vim.lsp.config("jsonls", {
            --         capabilities = capabilities,
            --         cmd = { "vscode-json-language-server", "--stdio" },
            --         filetypes = { "json", "jsonc" },
            --         init_options = {
            --             provideFormatter = true,
            --         },
            --     })
            --
            --     vim.lsp.enable("jsonls")
            --     -- EsLint
            --     vim.lsp.enable("eslint")
            -- else
            --     print("biome.json found, not enabling jsonls or eslint")
            -- end

            -- Tailwind
            -- if is_tailwind_project() then
            vim.lsp.config("tailwindcss", {
                capabilities = capabilities,
            })
            vim.lsp.enable("tailwindcss")
            -- end

            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",
                callback = function()
                    vim.lsp.start({
                        cmd = { "emmet-language-server", "--stdio" },
                        root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
                        -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
                        -- **Note:** only the options listed in the table are supported.
                        init_options = {
                            ---@type table<string, string>
                            includeLanguages = {},
                            --- @type string[]
                            excludeLanguages = {},
                            --- @type string[]
                            extensionsPath = {},
                            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                            preferences = {},
                            --- @type boolean Defaults to `true`
                            showAbbreviationSuggestions = true,
                            --- @type "always" | "never" Defaults to `"always"`
                            showExpandedAbbreviation = "always",
                            --- @type boolean Defaults to `false`
                            showSuggestionsAsSnippets = false,
                            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                            syntaxProfiles = {},
                            --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                            variables = {},
                        },
                    })
                end,
            })
            -- Emmet
            -- vim.lsp.config("emmet-language-server", {
            --     capabilities = capabilities,
            -- })
            vim.lsp.enable("emmet-language-server")

            -- Markdown
            vim.lsp.enable("marksman")

            -- php
            vim.lsp.enable("phpactor")
            -- vim.lsp.enable("psalm")

            -- Bash
            vim.lsp.enable("bashls")

            -- Python
            vim.lsp.enable("pyright")

            -- Go
            vim.lsp.enable("gopls")

            -- GraphQL
            -- vim.lsp.enable("graphql")

            -- Rust
            -- vim.lsp.enable("rust_analyzer")

            -- Lua
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
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
            })
            vim.lsp.enable("lua_ls")
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
