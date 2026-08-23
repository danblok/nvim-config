return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        version = false,
        opts_extend = { "ensure_installed" },
        opts = {
            ensure_installed = {
                "lua",
                "luadoc",
                "vim",
                "markdown",
                "vimdoc",
                "query",
                "c",
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
                "vue",
                "rust",
                "php",
                "php_only",
                "css",
            },
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
        },
        config = function(_, opts)
            local TS = require("nvim-treesitter")
            TS.setup(opts)

            local already_installed = TS.get_installed()

            local to_install = vim
                .iter(opts.ensure_installed)
                :filter(function(parser) return not vim.tbl_contains(already_installed, parser) end)
                :totable()

            if #to_install > 0 then TS.install(to_install) end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
                callback = function()
                    -- highlighting
                    if vim.tbl_get(opts, "highlight", "enable") ~= false then
                        pcall(vim.treesitter.start)
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            textobjects = {
                select = {
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
        },
        config = function(_, opts)
            TS = require("nvim-treesitter-textobjects")
            TS.setup(opts)
        end,
    },
}
