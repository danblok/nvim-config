return {
    "saghen/blink.cmp",
    version = '*',
    event = "InsertEnter",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        fuzzy = {
            implementation = "prefer_rust",
        },
        completion = {
            menu = {
                border = "rounded"
            },
            trigger = {
                show_on_insert = false,
            },
            keyword = {
                range = "full",
            },
            accept = {
                auto_brackets = {
                    kind_resolution = {
                        enabled = true,
                        blocked_filetypes = {
                            "typescriptreact",
                            "javascriptreact",
                            "vue"
                        },
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = {
                    border = "rounded"
                },
            },
            -- menu = menu,
        },
        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
        },
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
        },
        signature = {
            enabled = true,
            window = {
                border = "rounded"
            },
        },
        sources = {
            default = { "lsp", "path", "lazydev", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
        snippets = { preset = "default" },
    },
}
