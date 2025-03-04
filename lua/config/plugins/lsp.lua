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
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
            },
            { "saghen/blink.cmp" },
            { "williamboman/mason.nvim", config = true },
            { "williamboman/mason-lspconfig.nvim", config = function() end },
            { "j-hui/fidget.nvim" },
        },
        opts = {
            servers = {
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
                dockerls = {},
                sqls = {
                    connections = {},
                },
                gopls = {},
                awk_ls = {},
                basedpyright = {},
                bashls = {
                    filetypes = { "sh" },
                },
                biome = {},
                -- ts_ls = {},
                html = {},
                pbls = {},
                templ = {},
                cssls = {},
                css_variables = {},
                cssmodules_ls = {},
                -- intelephense = {},
                phpactor = {},
                tailwindcss = {},
                volar = {
                    -- filetypes = {
                    --     "typescript",
                    --     "javascript",
                    --     "javascriptreact",
                    --     "typescriptreact",
                    --     "vue",
                    -- },
                    init_options = {
                        vue = {
                            hybridMode = false,
                        },
                    },
                },
                rust_analyzer = {},
                csharp_ls = {
                    verbose = false,
                },
                -- omnisharp = {},
            },
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            for server, config in pairs(opts.servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                config.on_attach = on_attach
                lspconfig[server].setup(config)
            end

            require("mason").setup()
            -- vim.api.nvim_create_autocmd("LspAttach", {
            --     callback = function(args)
            --         local client = vim.lsp.get_client_by_id(args.data.client_id)
            --         if not client then
            --             return
            --         end
            --
            --         if client:supports_method("textDocument/formatting") then
            --             -- Format the current buffer on save
            --             vim.api.nvim_create_autocmd("BufWritePre", {
            --                 buffer = args.buf,
            --                 callback = function()
            --                     vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            --                 end,
            --             })
            --         end
            --     end,
            -- })
        end,
    },
}
