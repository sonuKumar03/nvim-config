return {
	-- Autopairs: Automatically closes brackets, parenthesis, and quotes as you type
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true, -- Runs standard require("nvim-autopairs").setup() automatically
		opts = {},
	},

	-- Autotag: Automatically closes and renames XML/HTML/TSX/JSX tags dynamically
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	-- Surround: Fast operators to add, change, or delete surroundings (e.g. cs"' changes "text" to 'text')
	{
		"kylechui/nvim-surround",
		version = "^4.0.0", -- Pin version for stable updates
		event = "VeryLazy", -- Defer load since it maps operators locally on Normal mode keys
		opts = {},
	},
}
