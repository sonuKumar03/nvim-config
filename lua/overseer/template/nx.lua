local util = require("overseer.template._util")

return {
	generator = function(search)
		local root = util.find_root({ "nx.json", "package.json" }, search.dir or vim.fn.getcwd())
		if not root or not util.exists(root .. "/nx.json") then
			return "No nx.json found"
		end

		return {
			{
				name = "Nx: show projects",
				builder = function()
					return {
						cmd = { "nx", "show", "projects" },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Nx: graph",
				builder = function()
					return {
						cmd = { "nx", "graph" },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Nx: affected test",
				builder = function()
					return {
						cmd = { "nx", "affected", "-t", "test" },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Nx: affected lint",
				builder = function()
					return {
						cmd = { "nx", "affected", "-t", "lint" },
						cwd = root,
						components = { "default" },
					}
				end,
			},
			{
				name = "Nx: affected build",
				builder = function()
					return {
						cmd = { "nx", "affected", "-t", "build" },
						cwd = root,
						components = { "default" },
					}
				end,
			},
		}
	end,
	cache_key = function(opts)
		return util.find_root({ "nx.json", "package.json" }, opts.dir or vim.fn.getcwd())
	end,
}
