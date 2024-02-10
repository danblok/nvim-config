return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
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
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<bs>",
					},
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
						include_surrounding_whitespace = true,
					},
				},
			})

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
}
