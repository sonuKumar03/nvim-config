return {
	-- Telescope: Extensible fuzzy finder dialogs (file list, grep, buffers, etc.)
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-frecency.nvim",
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			-- Load compiled C native fzf extension for fast queries
			pcall(telescope.load_extension, "fzf")
			-- Load Neovim system handler UI overrides (e.g. LSP code action choices dialogs)
			pcall(telescope.load_extension, "ui-select")
			-- Load custom project list switcher
			pcall(telescope.load_extension, "project")
			-- Load search history frequency & recency weight finder
			pcall(telescope.load_extension, "frecency")
		end,
	},

	-- Spectre: Project-wide search and replace interface panel
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
				open_cmd = "vnew", -- Open panel in vertical split buffer
				live_update = false,
				is_insert_mode = false,
			})
		end,
	},

	-- Neo-tree: File system drawer explorer sidebar
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree", -- Lazy loads on Neotree commands (triggered by sidebar keymaps)
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			window = {
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["s"] = "open_vsplit",
					["S"] = "open_split",
					["t"] = "open_tabnew",
					["a"] = { "add", config = { show_path = "none" } },
					["A"] = "add_directory",
					["d"] = "delete",
					["r"] = "rename",
					["c"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
				},
			},
		},
	},

	-- Harpoon: Quick file pinning and jumping
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})
		end,
		keys = {
			{ "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon: Add File" },
			{ "<leader>hh", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: List Menu" },
			{ "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "Harpoon: Go to File 1" },
			{ "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "Harpoon: Go to File 2" },
			{ "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "Harpoon: Go to File 3" },
			{ "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "Harpoon: Go to File 4" },
		},
	},

	-- Aerial: Code outline navigation sidebar
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			on_attach = function(bufnr)
				vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr, desc = "Aerial: Jump Prev" })
				vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr, desc = "Aerial: Jump Next" })
			end,
			nerd_font = "auto",
			layout = {
				width = 35,
				min_width = 28,
				max_width = { 45, 0.35 },
			},
		},
		keys = {
			{ "<leader>co", "<cmd>AerialToggle! right<cr>", desc = "Code: Toggle Outline (Aerial)" },
		},
	},
}

