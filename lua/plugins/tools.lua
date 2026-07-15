return {
	-- Which-Key: Popup keymap helper UI
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			spec = {
				{ "<leader>c", group = "Code" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>h", group = "Harpoon" },
				{ "<leader>n", group = "Notes / Obsidian" },
				{ "<leader>o", group = "Tasks" },
				{ "<leader>p", group = "Projects" },
				{ "<leader>q", group = "Session / Quit" },
				{ "<leader>s", group = "Search / Replace" },
				{ "<leader>t", group = "Tests" },
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
			dap = false,
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

	-- LeetCode Helpers: Scratchpad creation and job execution tools
	{
		"leetcode-custom",
		dir = vim.fn.stdpath("config"), -- Point to local config as dummy directory
		dependencies = { "nvim-lua/plenary.nvim" },
		init = function()
			local open_output = function(output, code)
				vim.schedule(function()
					local buf = vim.api.nvim_create_buf(false, true)
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
					vim.api.nvim_open_win(buf, true, {
						relative = "editor",
						width = math.floor(vim.o.columns * 0.7),
						height = math.floor(vim.o.lines * 0.6),
						row = math.floor(vim.o.lines * 0.2),
						col = math.floor(vim.o.columns * 0.15),
						style = "minimal",
						border = "rounded",
					})
					vim.bo[buf].bufhidden = "wipe"
					vim.bo[buf].modifiable = false
					vim.api.nvim_buf_set_name(buf, ("LeetCode run [%d]"):format(code))
				end)
			end

			local run_job = function(command, args, cwd, on_exit)
				local Job = require("plenary.job")
				local output = {}

				Job:new({
					command = command,
					args = args,
					cwd = cwd,
					on_stdout = function(_, data)
						if data and data ~= "" then
							table.insert(output, data)
						end
					end,
					on_stderr = function(_, data)
						if data and data ~= "" then
							table.insert(output, data)
						end
					end,
					on_exit = function(_, code)
						on_exit(output, code)
					end,
				}):start()
			end

			local run_python = function(path)
				run_job("python3", { path }, vim.fn.fnamemodify(path, ":h"), open_output)
			end

			local detect_java_class = function()
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				local text = table.concat(lines, "\n")
				return text:match("public%s+class%s+([%w_]+)") or text:match("class%s+([%w_]+)") or "Solution"
			end

			local run_java = function(path)
				local cwd = vim.fn.fnamemodify(path, ":h")
				local build_dir = vim.fn.tempname()
				local class_name = detect_java_class()
				vim.fn.mkdir(build_dir, "p")

				run_job("javac", { "-d", build_dir, path }, cwd, function(compile_output, compile_code)
					if compile_code ~= 0 then
						open_output(compile_output, compile_code)
						return
					end
					run_job("java", { "-cp", build_dir, class_name }, cwd, open_output)
				end)
			end

			-- Registers command :LeetCodeScratch to open a blank Python buffer template
			vim.api.nvim_create_user_command("LeetCodeScratch", function()
				vim.cmd("enew")
				vim.bo.buftype = ""
				vim.bo.bufhidden = "hide"
				vim.bo.swapfile = false
				vim.bo.filetype = "python"
				vim.api.nvim_buf_set_lines(0, 0, -1, false, {
					"from typing import *",
					"",
					"class Solution:",
					"    def solve(self) -> None:",
					"        pass",
					"",
				})
			end, {})

			-- Registers command :LeetCodeRun to execute the active solution file in background
			vim.api.nvim_create_user_command("LeetCodeRun", function()
				local path = vim.api.nvim_buf_get_name(0)
				if path == "" then
					vim.notify("Save the file before running", vim.log.levels.WARN)
					return
				end
				run_python(path)
			end, {})

			vim.api.nvim_create_user_command("LeetCodeJavaScratch", function()
				vim.cmd("enew")
				vim.bo.buftype = ""
				vim.bo.bufhidden = "hide"
				vim.bo.swapfile = false
				vim.bo.filetype = "java"
				vim.api.nvim_buf_set_lines(0, 0, -1, false, {
					"import java.util.*;",
					"",
					"class Solution {",
					"    public static void main(String[] args) {",
					"        Solution solution = new Solution();",
					"    }",
					"}",
					"",
				})
			end, {})

			vim.api.nvim_create_user_command("LeetCodeJavaRun", function()
				local path = vim.api.nvim_buf_get_name(0)
				if path == "" then
					vim.notify("Save the file before running", vim.log.levels.WARN)
					return
				end
				run_java(path)
			end, {})
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
