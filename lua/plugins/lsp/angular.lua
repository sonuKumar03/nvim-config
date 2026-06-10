local M = {}

function M.find_root(fname)
	if fname == "" or fname == nil then
		return nil
	end
	local marker = vim.fs.find({ "angular.json", "nx.json" }, { path = fname, upward = true })[1]
	return marker and vim.fs.dirname(marker) or nil
end

local function find_project_root(root_dir)
	local node_modules = vim.fs.find("node_modules", { path = root_dir, upward = true })[1]
	return node_modules and vim.fs.dirname(node_modules) or nil
end

local function resolve_mason_angular_lib_path()
	local ok, registry = pcall(require, "mason-registry")
	if ok then
		local ok_package, pkg = pcall(registry.get_package, "angular-language-server")
		if ok_package and pkg:is_installed() then
			return pkg:get_install_path() .. "/node_modules/@angular"
		end
	end
	return vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules/@angular"
end

function M.resolve_ngserver_bin(root_dir)
	local project_root = find_project_root(root_dir)
	if project_root then
		local local_server = project_root .. "/node_modules/@angular/language-server/bin/ngserver"
		if vim.uv.fs_stat(local_server) then
			return local_server
		end
		local bin_server = project_root .. "/node_modules/.bin/ngserver"
		if vim.uv.fs_stat(bin_server) then
			return bin_server
		end
	end

	-- Try Mason package fallback
	local ok, registry = pcall(require, "mason-registry")
	if ok then
		local ok_package, pkg = pcall(registry.get_package, "angular-language-server")
		if ok_package and pkg:is_installed() then
			local mason_server = pkg:get_install_path() .. "/node_modules/@angular/language-server/bin/ngserver"
			if vim.uv.fs_stat(mason_server) then
				return mason_server
			end
		end
	end

	-- Global path fallback
	local global = vim.fn.exepath("ngserver")
	if global ~= "" then
		return global
	end

	-- Final standard path fallback
	return vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules/@angular/language-server/bin/ngserver"
end

function M.resolve_probe_dir(root_dir)
	local project_root = find_project_root(root_dir)
	return project_root and (project_root .. "/node_modules") or resolve_mason_angular_lib_path()
end

function M.resolve_core_version(root_dir)
	local project_root = find_project_root(root_dir)
	if not project_root then
		return ""
	end
	local package_json = project_root .. "/package.json"
	local file = io.open(package_json, "r")
	if not file then
		return ""
	end
	local contents = file:read("*a")
	file:close()

	local ok, json = pcall(vim.json.decode, contents)
	if not ok or type(json) ~= "table" then
		return ""
	end

	local angular_core_version = json.dependencies and json.dependencies["@angular/core"]
		or json.devDependencies and json.devDependencies["@angular/core"]

	return angular_core_version and angular_core_version:match("%d+%.%d+%.%d+") or ""
end

return M
