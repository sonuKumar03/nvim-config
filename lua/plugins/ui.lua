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

	-- Dropbar: IDE-like breadcrumbs in the winbar with symbol pick support
	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Dropbar: Pick Symbols" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Dropbar: Context Start" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Dropbar: Next Context" })
		end,
	},

	-- Smear Cursor: Animated cursor trail for terminal Neovim
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
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

	-- Bufferline: Tabs-like header bar for open buffers
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Buffer: Next" },
			{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer: Prev" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Buffer: Next" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer: Prev" },
			{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Buffer: Pick" },
			{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Buffer: Delete" },
		},
		opts = {
			options = {
				mode = "buffers",
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},
}
