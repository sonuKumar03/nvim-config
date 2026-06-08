return {
	{
		"nvim-pack/nvim-spectre",
		cmd = {
			"Spectre",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("spectre").setup({
				open_cmd = "vnew",
				live_update = false,
				is_insert_mode = false,
			})
		end,
	},
}
