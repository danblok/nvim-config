return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup {
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
                    "html",
                    "gitcommit",
                    "git_config",
                    "git_rebase",
                    "gitignore",
                    "proto", },
                auto_install = false,
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
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
            }
        end,

    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
