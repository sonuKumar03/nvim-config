return {
	-- Which-Key: Popup keymap helper UI
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				{ "<leader>c", group = "Code" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>n", group = "Notes / Obsidian" },
				{ "<leader>o", group = "Terminal" },
				{ "<leader>p", group = "Projects" },
				{ "<leader>q", group = "Session / Quit" },
				{ "<leader>s", group = "Search / Replace" },
				{ "<leader>u", group = "Toggles / Options" },
				{ "<leader>x", group = "Diagnostics" },
				{ "<leader>P", desc = "Command Palette (VS Code)" },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Keymaps (which-key)",
			},
		},
	},

	-- Persistence: Session restoration manager
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			options = { "buffers", "curdir", "tabpages", "winsize", "skiprtp" },
		},
		keys = {
			{ "<leader>qs", function() require("persistence").load() end, desc = "Restore Session (Current Dir)" },
			{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
			{ "<leader>qd", function() require("persistence").stop() end, desc = "Stop Saving Session" },
		},
	},

	-- Legendary: VS Code-style Command Palette with keybinding hints & Telescope UI
	{
		"mrjones2014/legendary.nvim",
		priority = 10000,
		lazy = false,
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			include_builtin = true,
			include_legendary_cmds = true,
			extensions = {
				lazy_nvim = true,
				which_key = { auto_register = true },
			},
		},
		keys = {
			{ "<leader>P", "<cmd>Legendary<cr>", desc = "Command Palette (VS Code)" },
			{ "<C-p>", "<cmd>Legendary<cr>", desc = "Command Palette (VS Code)" },
			{ "<leader><space>", "<cmd>Legendary<cr>", desc = "Command Palette (VS Code)" },
		},
	},
}
