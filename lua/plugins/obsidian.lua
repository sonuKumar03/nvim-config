return {
	"epwalsh/obsidian.nvim",
	version = "*", -- use latest release instead of main branch
	lazy = true,
	-- Load on markdown files inside the vault, or when running obsidian commands
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/notes/**/*.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/notes/**/*.md",
	},
	cmd = {
		"ObsidianNew",
		"ObsidianQuickSwitch",
		"ObsidianToday",
		"ObsidianYesterday",
		"ObsidianTomorrow",
		"ObsidianSearch",
		"ObsidianTemplate",
		"ObsidianOpen",
		"ObsidianBacklinks",
		"ObsidianFollowLink",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "notes",
				path = "~/notes",
			},
		},
		daily_notes = {
			folder = "dailies",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			template = "daily.md",
		},
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			substitutions = {
				date = function()
					return os.date("%Y-%m-%d")
				end,
				time = function()
					return os.date("%H:%M")
				end,
			},
		},
		-- Configure UI styling for markdown buffers
		ui = {
			enable = true,
			update_debounce = 200,
			checkboxes = {
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
			},
			bullets = { char = "•", hl_group = "ObsidianBullet" },
		},
		-- Use telescope for pickers
		picker = {
			name = "telescope.nvim",
		},
	},
	keys = {
		{ "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "Note: New" },
		{ "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Note: Search Text" },
		{ "<leader>no", "<cmd>ObsidianOpen<cr>", desc = "Note: Open in App" },
		{ "<leader>nt", "<cmd>ObsidianToday<cr>", desc = "Note: Today's Daily" },
		{ "<leader>ny", "<cmd>ObsidianYesterday<cr>", desc = "Note: Yesterday's Daily" },
		{ "<leader>nf", "<cmd>ObsidianFollowLink<cr>", desc = "Note: Follow Link" },
		{ "<leader>ni", "<cmd>ObsidianTemplate<cr>", desc = "Note: Insert Template" },
		{ "<leader>nb", "<cmd>ObsidianBacklinks<cr>", desc = "Note: Backlinks" },
	},
}
