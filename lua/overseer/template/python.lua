local util = require("overseer.template._util")

return {
	generator = function(search)
		local root = util.find_root({ "pyproject.toml", "requirements.txt", "setup.py" }, search.dir or vim.fn.getcwd())
		if not root then
			return "No Python project markers found"
		end

		return {
			{
				name = "Python: pytest",
				builder = function()
					return {
						cmd = { "pytest" },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Python: ruff check",
				builder = function()
					return {
						cmd = { "ruff", "check", "." },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Python: ruff format",
				builder = function()
					return {
						cmd = { "ruff", "format", "." },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Python: run file",
				builder = function()
					return {
						cmd = { "python3", vim.fn.expand("%:p") },
						cwd = root,
						components = { "default" },
					}
				end,
			},
		}
	end,
	cache_key = function(opts)
		return util.find_root({ "pyproject.toml", "requirements.txt", "setup.py" }, opts.dir or vim.fn.getcwd())
	end,
}
