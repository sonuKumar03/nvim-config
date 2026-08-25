return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			local languages = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"typescript",
				"javascript",
				"java",
				"go",
				"json",
				"yaml",
				"dockerfile",
				"html",
				"css",
			}

			treesitter.setup()
			treesitter.install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ok = pcall(vim.treesitter.start, args.buf)
					if ok then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			enable = true,
			max_lines = 3,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		init = function()
			-- Avoid conflicts with Neovim's built-in filetype textobject mappings.
			vim.g.no_plugin_maps = true
		end,
		config = function()
			local textobjects = require("nvim-treesitter-textobjects")

			textobjects.setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@function.outer"] = "V",
						["@function.inner"] = "V",
						["@class.outer"] = "V",
						["@class.inner"] = "V",
					},
				},
			})

			local select = require("nvim-treesitter-textobjects.select").select_textobject
			vim.keymap.set({ "x", "o" }, "af", function()
				select("@function.outer", "textobjects")
			end, { desc = "Treesitter: Select function" })
			vim.keymap.set({ "x", "o" }, "if", function()
				select("@function.inner", "textobjects")
			end, { desc = "Treesitter: Select inside function" })
			vim.keymap.set({ "x", "o" }, "ac", function()
				select("@class.outer", "textobjects")
			end, { desc = "Treesitter: Select class" })
			vim.keymap.set({ "x", "o" }, "ic", function()
				select("@class.inner", "textobjects")
			end, { desc = "Treesitter: Select inside class" })
		end,
	},
}
