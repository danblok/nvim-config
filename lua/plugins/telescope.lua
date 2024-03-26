return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            -- {
            --     "nvim-telescope/telescope-ui-select.nvim",
            -- },
        },
        config = function()
            local builtin = require("telescope.builtin") -- Setup keymaps
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "[G]it [F]iles" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind by [B]uffers" })
            vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "[S]ind by [Q]uick fix" })
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch by [D]iagnostics" })

            -- Setup telescope
            require("telescope").setup({
                defaults = {
                    sorting_strategy = "ascending",
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            require("telescope").load_extension("fzf")
            -- require("telescope").load_extension("ui-select")
        end,
    },
}
