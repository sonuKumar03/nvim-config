local M = {}

local uv = vim.uv or vim.loop

function M.find_root(markers, path)
	local found = vim.fs.find(markers, {
		upward = true,
		path = path or vim.fn.getcwd(),
		type = "file",
	})[1]

	if not found then
		return nil
	end

	return vim.fs.dirname(found)
end

function M.read_json(path)
	local ok, lines = pcall(vim.fn.readfile, path)
	if not ok then
		return nil
	end

	local ok_json, data = pcall(vim.json.decode, table.concat(lines, "\n"))
	if not ok_json then
		return nil
	end

	return data
end

function M.exists(path)
	return uv.fs_stat(path) ~= nil
end

function M.package_manager(root)
	if M.exists(root .. "/bun.lockb") then
		return "bun"
	end

	if M.exists(root .. "/yarn.lock") then
		return "yarn"
	end

	if M.exists(root .. "/pnpm-lock.yaml") then
		return "pnpm"
	end

	return "npm"
end

function M.script_cmd(package_manager, script)
	if package_manager == "bun" then
		return { "bun", "run", script }
	end

	if package_manager == "pnpm" then
		return { "pnpm", script }
	end

	if package_manager == "yarn" then
		return { "yarn", script }
	end

	return { "npm", "run", script }
end

function M.has_marker_root(markers, path)
	return M.find_root(markers, path) ~= nil
end

return M
