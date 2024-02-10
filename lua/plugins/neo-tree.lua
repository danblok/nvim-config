return {
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		config = function()
			require("neo-tree").setup({
				window = {
					position = "current",
				},
				default_component_configs = {
					indent = {
						indent_size = 4,
						padding = 4,
					},
				},
			})

			-- Disable dark background
			vim.cmd[[hi NeoTreeNormal guibg=NONE ctermbg=NONE ctermfg=NONE guifg=NONE]]
			vim.cmd[[hi NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE ctermfg=NONE guifg=NONE]]
		end,
	}
}
