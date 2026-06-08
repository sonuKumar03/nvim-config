return {
	{
		"romgrk/barbar.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = {
			"BufferNext",
			"BufferPrevious",
			"BufferClose",
			"BufferCloseAllButVisible",
			"BufferPick",
			"BufferGoto",
		},
		version = "^1.7.1",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
}
