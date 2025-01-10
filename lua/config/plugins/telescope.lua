return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
        },
    },
    config = function()
        -- Setup telescope
        require("telescope").setup({
            extensions = {
                fzf = {
                    fuzzy = true,
                    -- override_generic_sorter = true,
                    -- override_file_sorter = true,
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
            },
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")

        local builtin = require("telescope.builtin") -- Setup keymaps
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
        -- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "[G]it [F]iles" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind by [B]uffers" })
        vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "[S]ind by [Q]uick fix" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch by [D]iagnostics" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp tags" })
        vim.keymap.set("n", "<space>en", function()
            require("telescope.builtin").find_files {
                cwd = vim.fn.stdpath("config")
            }
        end, { desc = "[F]ind [H]elp tags" })

        require("config.plugins.telescope.multigrep").setup()
    end,
}
