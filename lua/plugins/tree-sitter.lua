return {
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
			"go"
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
}
