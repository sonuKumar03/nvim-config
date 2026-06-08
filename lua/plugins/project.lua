return {
	{
		"nvim-telescope/telescope-project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			pcall(require("telescope").load_extension, "project")
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		version = "*",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			pcall(require("telescope").load_extension, "frecency")
		end,
	},
}
