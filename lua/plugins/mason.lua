return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "angularls@20.3.0", "lua_ls", "gopls", "jdtls", "vtsls" },
			automatic_enable = {
				exclude = { "jdtls", "ts_ls" },
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
