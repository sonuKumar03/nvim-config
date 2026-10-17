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
				-- ts_ls: vtsls is used instead; stylua: formatting goes through conform;
				-- jdtls/texlab: installed but not configured here
				exclude = { "ts_ls", "stylua", "jdtls", "texlab" },
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
