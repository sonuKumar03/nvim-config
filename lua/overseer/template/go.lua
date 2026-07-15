local util = require("overseer.template._util")

return {
	generator = function(search)
		local root = util.find_root({ "go.mod" }, search.dir or vim.fn.getcwd())
		if not root then
			return "No go.mod found"
		end

		return {
			{
				name = "Go: test all",
				builder = function()
					return {
						cmd = { "go", "test", "./..." },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Go: test package",
				builder = function()
					return {
						cmd = { "go", "test", "." },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Go: test all (race)",
				builder = function()
					return {
						cmd = { "go", "test", "-race", "./..." },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Go: test all (coverage)",
				builder = function()
					return {
						cmd = { "go", "test", "-coverprofile=coverage.out", "./..." },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Go: vet all",
				builder = function()
					return {
						cmd = { "go", "vet", "./..." },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Go: build all",
				builder = function()
					return {
						cmd = { "go", "build", "./..." },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Go: run file",
				builder = function()
					return {
						cmd = { "go", "run", vim.fn.expand("%:p") },
						cwd = root,
						components = { "default" },
					}
				end,
			},
		}
	end,
	cache_key = function(opts)
		return util.find_root({ "go.mod" }, opts.dir or vim.fn.getcwd())
	end,
}
