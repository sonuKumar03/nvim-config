return {
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
		config = function()
			local run_python = function(path)
				local Job = require("plenary.job")
				local output = {}

				Job:new({
					command = "python3",
					args = { path },
					cwd = vim.fn.fnamemodify(path, ":h"),
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
					end,
				}):start()
			end

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

			vim.api.nvim_create_user_command("LeetCodeRun", function()
				local path = vim.api.nvim_buf_get_name(0)
				if path == "" then
					vim.notify("Save the file before running", vim.log.levels.WARN)
					return
				end
				run_python(path)
			end, {})
		end,
	},
}
