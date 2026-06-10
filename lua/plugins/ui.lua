return {
	-- Catppuccin Theme: Sleek, high-quality colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- Load this theme first before other plugins compile
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Lualine Statusline: Customizable active status bar at the bottom
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				globalstatus = true, -- Single statusline for all windows instead of split bars
				icons_enabled = true,
			},
		},
	},

	-- Barbar Buffer Tabs: Top bar tabs showing active open buffers
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
			vim.g.barbar_auto_setup = false -- Disable auto-setup to let lazy.nvim configure it
		end,
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},

	-- Fidget: Visual progress bar spinner for LSP status updates (indexing, diagnosing, etc.)
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {},
	},

	-- Trouble: Expandable sidebar/bottom panel for project errors and workspace diagnostics
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			focus = false, -- Defer focusing when diagnostics window toggles
			auto_open = false,
			auto_close = false,
		},
	},

	-- Todo Comments: Highlight keywords like TODO, FIXME, NOTE dynamically inside code comments
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	-- Colorizer: Renders true colors inline in CSS, HSL, Hex values (e.g. #ff0077)
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			filetypes = { "*", "!lazy" }, -- Colorize all buffers except Lazy UI
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = false, -- Don't highlight literal names like 'red' (keeps it clean)
				RRGGBBAA = true,
				AARRGGBB = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "background",
				tailwind = true,
				sass = { enable = true, parsers = { "css" } },
				virtualtext = "■",
			},
		},
	},

	-- Render Markdown: Beautify markdown buffers, headers, and code block formatting
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},

	-- Markdown Preview: Live browser preview for markdown documentation
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown: Live Preview" },
		},
	},
}
