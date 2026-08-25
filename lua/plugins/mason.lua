return {
	{
		"mason-org/mason.nvim",
		opts = {
			PATH = "prepend",
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "angularls@20.3.0", "lua_ls", "pyright", "ruff", "gopls", "vtsls" },
			automatic_enable = {
				exclude = { "ts_ls" },
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
