return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release",
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
        },
    },
    config = function()
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
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    "vendor",
                    "storage/framework",
                    "bootstrap",
                },
            },
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")

        local builtin = require("telescope.builtin") -- Setup keymaps
        local map = vim.keymap.set
        map("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
        -- Use multigrep instead
        -- map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        map("n", "<leader>gf", builtin.git_files, { desc = "[G]it [F]iles" })
        map("n", "<leader>fb", builtin.buffers, { desc = "[F]ind by [B]uffers" })
        map("n", "<leader>sq", builtin.quickfix, { desc = "[S]ind by [Q]uick fix" })
        map("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
        map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch by [D]iagnostics" })
        map("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp tags" })
        map("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols, { desc = "[F]ind [S]ymbols" })
        map("n", "<space>en", function()
            require("telescope.builtin").find_files({
                cwd = vim.fn.stdpath("config"),
            })
        end, { desc = "[F]ind [H]elp tags" })

        require("plugins.telescope.multigrep").setup()

        vim.api.nvim_create_autocmd("User", {
            pattern = "TelescopeFindPre",
            callback = function()
                vim.o.winborder = "none"
            end,
        })
    end,
}
