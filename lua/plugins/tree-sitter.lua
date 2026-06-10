return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"typescript",
				"javascript",
				"python",
				"go",
				"json",
				"html",
				"css",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "latex", "tex" }, -- VimTeX handles this better
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			enable = true,
			max_lines = 3,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
		},
	},
}
