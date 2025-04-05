local on_attach = function(_, bufnr)
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

vim.lsp.enable({
    "luals",
    "vuels",
    "phpactor",
    -- "psalm",
})

return {
    {
        "williamboman/mason.nvim",
        config = true,
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
