return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            vim.defer_fn(function()
                require("nvim-treesitter.configs").setup({
                    -- Ensure these parsers installed
                    ensure_installed = {
                        "lua",
                        "luadoc",
                        "vim",
                        "vimdoc",
                        "query",
                        "c",
                        "cpp",
                        "javascript",
                        "typescript",
                        "bash",
                        "python",
                        "sql",
                        "go",
                        "gomod",
                        "gosum",
                        "gowork",
                        "templ",
                        "yaml",
                        "dockerfile",
                        "json",
                        "json5",
                        "proto",
                        "make",
                        "gitcommit",
                        "git_config",
                        "git_rebase",
                        "gitignore",
                    },
                    -- Auto install parser on unknown file type
                    auto_install = true,
                    -- Enable treesitter highlighting
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                    },
                    -- Enable Incremental selection
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "<c-space>",
                            node_incremental = "<c-space>",
                            scope_incremental = "<c-s>",
                            node_decremental = "<bs>",
                        },
                    },
                    -- Enable indentation with treesitter
                    indent = {
                        enable = true,
                    },
                    -- Configure textobjects selection
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true,
                            keymaps = {
                                ["aa"] = "@parameter.outer",
                                ["ia"] = "@parameter.inner",
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                ["ic"] = "@class.inner",
                                ["ai"] = "@conditional.outer",
                                ["ii"] = "@conditional.inner",
                                ["ab"] = "@block.outer",
                                ["ib"] = "@block.inner",
                                ["aq"] = "@block.outer",
                                ["iq"] = "@block.inner",
                            },
                        },
                    },
                })
            end, 0)

            vim.filetype.add({
                extension = {
                    templ = "templ",
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            max_lines = 3,
        },
    },
}
