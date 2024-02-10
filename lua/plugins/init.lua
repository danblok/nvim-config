return {
	{ "folke/which-key.nvim" },
	{ 
		"folke/neoconf.nvim",
		cmd = "Neoconf",
	},
	{ "folke/neodev.nvim" },
	{
		"tpope/vim-sleuth",
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup({})
		end,
	},
}
