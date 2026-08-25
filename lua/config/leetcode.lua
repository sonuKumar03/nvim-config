local function scratch(opts)
	local name = opts and vim.trim(opts.args or "") or ""
	if name == "" then
		name = vim.fn.input("Python file name [main.py]: ", "", "file")
		if name == "" then
			name = "main.py"
		end
	end
	if not name:match("%.py$") then
		name = name .. ".py"
	end

	local path = vim.fn.fnamemodify(name, ":p")
	local parent = vim.fn.fnamemodify(path, ":h")
	local exists = vim.uv.fs_stat(path) ~= nil

	vim.fn.mkdir(parent, "p")
	vim.cmd("edit " .. vim.fn.fnameescape(path))
	vim.bo.filetype = "python"

	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	if exists and (#lines > 1 or lines[1] ~= "") then
		vim.notify(("Opened existing file: %s"):format(path), vim.log.levels.INFO)
		return
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, {
		"from typing import *",
		"",
		"class Solution:",
		"    def solve(self):",
		"        pass",
		"",
		"",
		'if __name__ == "__main__":',
		"    solution = Solution()",
		"",
	})
end

local function run()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		vim.notify("Save the file before running", vim.log.levels.WARN)
		return
	end

	vim.cmd.write()
	vim.cmd.botright("split")
	vim.fn.termopen({ "python3", path }, { cwd = vim.fn.fnamemodify(path, ":h") })
	vim.cmd.startinsert()
end

vim.api.nvim_create_user_command("LCP", scratch, { nargs = "*", complete = "file" })
vim.api.nvim_create_user_command("LCPR", run, {})
