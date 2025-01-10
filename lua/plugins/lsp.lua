local on_attach = function(_, bufnr)
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences", buffer = bufnr })
    vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols", buffer = bufnr })
    vim.keymap.set(
        "n",
        "<leader>ws",
        builtin.lsp_dynamic_workspace_symbols,
        { desc = "[W]orkspace [S]ymbols", buffer = bufnr }
    )

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", buffer = bufnr })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction", buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = bufnr })
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Documentation", buffer = bufnr })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration", buffer = bufnr })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition", buffer = bufnr })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation", buffer = bufnr })
    vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "[C]ode [D]iagnostics", buffer = bufnr })
end

return {
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            { "folke/neodev.nvim" },
            { "nanotee/sqls.nvim" },
            {
                "pmizio/typescript-tools.nvim",
                dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
                opts = {},
            },
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
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })

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
                flake8 = {
                    prefer_local = ".venv/bin",
                },
            }

            require("neodev").setup()

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities()
            local mason_lspconfig = require("mason-lspconfig")

            require("mason").setup()
            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "gopls",
                    "html",
                    "bashls",
                    "biome",
                },
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
