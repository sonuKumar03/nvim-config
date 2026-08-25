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
				{ "<leader>h", group = "Harpoon" },
				{ "<leader>n", group = "Notes / Obsidian" },
				{ "<leader>o", group = "Tasks" },
				{ "<leader>p", group = "Projects" },
				{ "<leader>q", group = "Session / Quit" },
				{ "<leader>s", group = "Search / Replace" },
				{ "<leader>u", group = "Toggles / Options" },
				{ "<leader>x", group = "Diagnostics" },
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

	-- Overseer: Extensible task runner and build system manager
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
			task_list = {
				keymaps = {
					["<C-j>"] = false,
					["<C-k>"] = false,
				},
			},
		},
	},

	-- ToggleTerm: Persistent floating/split terminals for project shells and REPLs
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = {
			"ToggleTerm",
			"ToggleTermToggleAll",
			"TermExec",
			"TermNew",
			"TermSelect",
		},
		keys = {
			{ [[<C-\>]], "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Terminal: Toggle" },
			{ "<leader>ot", "<cmd>ToggleTerm<cr>", desc = "Terminal: Toggle" },
		},
		opts = {
			open_mapping = [[<C-\>]],
			direction = "float",
			float_opts = {
				border = "curved",
			},
		},
	},

	-- VimTeX: Rich integration for LaTeX documents compiling
	{
		"lervag/vimtex",
		lazy = false, -- VimTeX manages its own load sequences dynamically
		init = function()
			vim.g.vimtex_view_method = "skim" -- Viewer configuration (Skim on macOS)
		end,
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

	-- Sleuth: Automatically detect tabstop and shiftwidth from files
	{
		"tpope/vim-sleuth",
		lazy = false, -- Needs to load early to inspect file indents when buffers open
	},
}
