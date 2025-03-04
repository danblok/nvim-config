return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            accept = {
                auto_brackets = {
                    kind_resolution = {
                        enabled = true,
                        blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
                    },
                },
            },
        },
        cmdline = {
            sources = {},
        },
        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        signature = { enabled = true },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
    },
}
