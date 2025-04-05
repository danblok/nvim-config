local menu = {
    draw = {
        -- columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
            -- label = {
            --     text = function(ctx)
            --         return require("colorful-menu").blink_components_text(ctx)
            --     end,
            --     highlight = function(ctx)
            --         return require("colorful-menu").blink_components_highlight(ctx)
            --     end,
            -- },
            kind_icon = {
                text = function(ctx)
                    require("lspkind")
                    local icon = ctx.kind_icon
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                        if dev_icon then
                            icon = dev_icon
                        end
                    else
                        icon = require("lspkind").symbolic(ctx.kind, {
                            mode = "symbol",
                        })
                    end

                    return icon .. ctx.icon_gap
                end,

                -- Optionally, use the highlight groups from nvim-web-devicons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                    local hl = ctx.kind_hl
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                        local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                        if dev_icon then
                            hl = dev_hl
                        end
                    end
                    return hl
                end,
            }
        }
    }
}

return {
    "saghen/blink.cmp",
    version = '*',
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
                auto_show_delay_ms = 500
            },
            menu = menu,
        },
        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        signature = {
            enabled = true,
        },
        sources = {
            default = { "lsp", "lazydev", "path", "snippets", "buffer" },
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
