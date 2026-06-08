return {
	{
		"stevearc/overseer.nvim",
		cmd = {
			"OverseerOpen",
			"OverseerClose",
			"OverseerToggle",
			"OverseerRun",
			"OverseerTaskAction",
		},
		opts = {
			dap = false,
			task_list = {
				keymaps = {
					["<C-j>"] = false,
					["<C-k>"] = false,
				},
			},
		},
	},
}
