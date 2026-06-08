local util = require("overseer.template._util")

return {
	generator = function(search)
		local root = util.find_root({ "package.json" }, search.dir or vim.fn.getcwd())
		if not root then
			return "No package.json found"
		end

		local package_json = util.read_json(root .. "/package.json")
		if not package_json or not package_json.scripts then
			return "No package scripts found"
		end

		local pm = util.package_manager(root)
		local tasks = {}
		local scripts = { "dev", "test", "lint", "build", "start" }

		for _, script in ipairs(scripts) do
			if package_json.scripts[script] then
				table.insert(tasks, {
					name = "JS/TS: " .. script,
					builder = function()
						return {
							cmd = util.script_cmd(pm, script),
							cwd = root,
							components = { "default" },
						}
					end,
				})
			end
		end

		if #tasks == 0 then
			return "No common JS/TS scripts found"
		end

		return tasks
	end,
	cache_key = function(opts)
		return util.find_root({ "package.json" }, opts.dir or vim.fn.getcwd())
	end,
}
