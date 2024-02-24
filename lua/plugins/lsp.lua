return {
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            { "folke/neodev.nvim" },

            "nanotee/sqls.nvim",
        },
        opts = {
            diagnostics = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
        },
        config = function()
            -- Diagnostics setup
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signatureHelp"] =
                vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
            vim.diagnostic.config({
                float = { border = "rounded" },
            })

            require("lspconfig.ui.windows").default_opts({ border = "rounded" })
            local builtin = require("telescope.builtin") -- Setup keymaps

            require("neodev").setup({})

            local on_attach = function(_, bufnr)
                -- Helper func
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                end

                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
                nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
                nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
                nmap("gr", builtin.lsp_references, "[G]oto [R]eferences")
                nmap("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
                nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                    vim.lsp.buf.format()
                end, { desc = "Format current buffer with LSP" })
            end

            local servers = {
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                        diagnostics = { disable = { "missing-fields" } },
                    },
                },
                clangd = {
                    filetypes = { "c", "cpp" },
                },
                docker_compose_language_service = {
                    filetypes = { "yml", "yaml" },
                },
                sqls = {
                    filetypes = { "sql" },
                },
            }

            require("neodev").setup()

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities()
            local mason_lspconfig = require("mason-lspconfig")

            require("mason").setup()
            mason_lspconfig.setup({
                ensure_installed = { "lua_ls", "clangd" },
            })

            mason_lspconfig.setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    })
                end,
            })
        end,
    },
}
