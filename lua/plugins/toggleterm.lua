return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = {
			"ToggleTerm",
			"TermExec",
		},
		opts = {
			open_mapping = [[<c-\>]],
			direction = "horizontal",
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			close_on_exit = true,
		},
	},
}
