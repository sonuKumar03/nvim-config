return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup({
				current_line_blame = false,
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, {
							buffer = bufnr,
							desc = desc,
						})
					end

					map("n", "]h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, "Git: Next Hunk")

					map("n", "[h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, "Git: Previous Hunk")

					map("n", "<leader>gs", gitsigns.stage_hunk, "Git: Stage Hunk")
					map("n", "<leader>gr", gitsigns.reset_hunk, "Git: Reset Hunk")
					map("n", "<leader>gS", gitsigns.stage_buffer, "Git: Stage Buffer")
					map("n", "<leader>gR", gitsigns.reset_buffer, "Git: Reset Buffer")
					map("n", "<leader>gu", gitsigns.undo_stage_hunk, "Git: Undo Stage Hunk")
					map("n", "<leader>gp", gitsigns.preview_hunk, "Git: Preview Hunk")
					map("n", "<leader>gP", gitsigns.preview_hunk_inline, "Git: Preview Hunk Inline")
					map("n", "<leader>gb", gitsigns.toggle_current_line_blame, "Git: Toggle Blame")
					map("n", "<leader>gd", gitsigns.diffthis, "Git: Diff This")
					map("n", "<leader>gq", gitsigns.setqflist, "Git: Hunks to Quickfix")
					map("n", "<leader>gQ", gitsigns.setloclist, "Git: Hunks to Location List")
					map("o", "ih", gitsigns.select_hunk, "Git: Inner Hunk")
					map("x", "ih", gitsigns.select_hunk, "Git: Inner Hunk")
				end,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("diffview").setup({
				use_icons = true,
				view = {
					default = {
						layout = "diff2_horizontal",
					},
				},
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		config = function()
			require("neogit").setup({
				kind = "tab",
				signs = {
					item = { ">", "v" },
					section = { ">", "v" },
				},
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = {
			"Git",
			"G",
			"Gdiffsplit",
			"Gvdiffsplit",
		},
	},
}
