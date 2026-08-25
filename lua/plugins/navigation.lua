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
					defaults = {
						file_ignore_patterns = {
							"node_modules/",
							"%.git/",
							"%.nx/",
							"dist/",
							"build/",
							"coverage/",
							"%.angular/",
							"tmp/",
						},
						vimgrep_arguments = {
							"rg",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
							"--glob",
							"!**/node_modules/**",
							"--glob",
							"!**/.git/**",
							"--glob",
							"!**/.nx/**",
							"--glob",
							"!**/dist/**",
							"--glob",
							"!**/build/**",
							"--glob",
							"!**/coverage/**",
							"--glob",
							"!**/.angular/**",
							"--glob",
							"!**/tmp/**",
						},
					},
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
			close_if_last_window = true,
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

	-- Vim-Tmux-Navigator: Seamless navigation between Vim and Tmux splits
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Pane: Navigate Left" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Pane: Navigate Down" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Pane: Navigate Up" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Pane: Navigate Right" },
		},
	},

	-- Illuminate: Automatically highlight other uses of the word under cursor
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			delay = 200,
			large_file_cutoff = 2000,
			under_cursor = true,
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
			vim.keymap.set("n", "]r", function()
				require("illuminate").goto_next_reference(true)
			end, { desc = "Illuminate: Next Reference" })
			vim.keymap.set("n", "[r", function()
				require("illuminate").goto_prev_reference(true)
			end, { desc = "Illuminate: Prev Reference" })
		end,
	},
}
