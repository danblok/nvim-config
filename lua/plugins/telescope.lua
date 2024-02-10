return {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		dependencies = { 
			'nvim-lua/plenary.nvim',
			{ 
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
			}
		},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles'})
			vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
			vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind by [B]uffers' })
			vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = '[S]ind by [Q]uick fix' })
			vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
			vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch by [D]iagnostics' })

			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					}
				}
			})

			require('telescope').load_extension('fzf')
		end,
	},
}
