-- Headless health check for this config. Run it through scripts/check.sh.
-- Loaded with --cmd (before init.lua) so deprecations during startup are recorded too.

local config_dir = vim.fn.stdpath("config")
local runtime_dir = vim.env.VIMRUNTIME
local tmp = vim.env.NVIM_CHECK_TMP
local fails = 0

local function out(line)
	io.stdout:write(line .. "\n")
end
local function pass(name, detail)
	out(("PASS  %s%s"):format(name, detail and ("  (" .. detail .. ")") or ""))
end
local function fail(name, detail)
	fails = fails + 1
	out(("FAIL  %s  -> %s"):format(name, detail))
end
local function warn(name, detail)
	out(("WARN  %s  -> %s"):format(name, detail))
end

-- Record every vim.deprecate call with the first caller outside Neovim's runtime
local deprecations = {}
local orig_deprecate = vim.deprecate
vim.deprecate = function(name, ...)
	for level = 2, 40 do
		local info = debug.getinfo(level, "Sl")
		if not info then
			break
		end
		local src = info.source
		-- skip Neovim's own frames: runtime files and embedded modules (@vim/...)
		if src:sub(1, 1) == "@" and not vim.startswith(src:sub(2), runtime_dir) and not src:match("^@vim/") then
			table.insert(deprecations, { name = name, src = src:sub(2), line = info.currentline })
			break
		end
	end
	return orig_deprecate(name, ...)
end

local function messages()
	return vim.api.nvim_exec2("messages", { output = true }).output
end

local function error_lines(text)
	local found = {}
	for line in text:gmatch("[^\n]+") do
		if line:match("E%d+:") or line:match("[Ee]rror") or line:match("Failed") then
			table.insert(found, line)
		end
	end
	return found
end

local function write_file(path, lines)
	vim.fn.mkdir(vim.fs.dirname(path), "p")
	vim.fn.writefile(lines, path)
end

local function check_startup()
	local msgs = vim.trim(messages())
	if msgs == "" and vim.v.errmsg == "" then
		pass("startup", "no messages or errors")
	else
		fail("startup", (msgs ~= "" and msgs or vim.v.errmsg):sub(1, 300))
	end
end

local function check_plugins()
	vim.cmd("messages clear")
	local lazy = require("lazy")
	local names, not_loaded = {}, {}
	for _, p in ipairs(lazy.plugins()) do
		table.insert(names, p.name)
	end
	lazy.load({ plugins = names })
	vim.wait(1000)
	for _, p in ipairs(lazy.plugins()) do
		if not p._.loaded then
			table.insert(not_loaded, p.name)
		end
	end
	local errs = error_lines(messages())
	if #not_loaded > 0 then
		fail("plugins load", "not loaded: " .. table.concat(not_loaded, ", "))
	elseif #errs > 0 then
		fail("plugins load", table.concat(errs, " | "):sub(1, 300))
	else
		pass("plugins load", #names .. " plugins")
	end
end

local function check_keymaps()
	local bad, total = {}, 0
	for _, mode in ipairs({ "n", "x", "v", "o", "i", "t" }) do
		for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
			local cmd = m.rhs and m.rhs:match("^<[Cc][Mm][Dd]>(.-)<[Cc][Rr]>$")
			local name = cmd and cmd:gsub("^<C%-U>", ""):match("^(%u%w+)")
			if name then
				total = total + 1
				if vim.fn.exists(":" .. name) ~= 2 then
					table.insert(bad, ("%s %s -> :%s"):format(mode, vim.fn.keytrans(m.lhs), name))
				end
			end
		end
	end
	if #bad > 0 then
		fail("keymaps", "missing commands: " .. table.concat(bad, ", "))
	else
		pass("keymaps", total .. " <cmd> maps point to existing commands")
	end
end

local function client_names(buf)
	local names = {}
	for _, c in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
		names[c.name] = true
	end
	return names
end

-- Open a file and check LSP clients, treesitter highlighting and formatters
local function check_filetype(label, path, expected_clients)
	vim.cmd("edit " .. vim.fn.fnameescape(path))
	local buf = vim.api.nvim_get_current_buf()
	local ok = vim.wait(30000, function()
		local names = client_names(buf)
		for _, want in ipairs(expected_clients) do
			if not names[want] then
				return false
			end
		end
		return true
	end, 200)
	local names = vim.tbl_keys(client_names(buf))
	table.sort(names)
	if ok then
		pass(label .. " lsp", table.concat(names, ", "))
	else
		fail(label .. " lsp", ("expected %s, got %s"):format(
			table.concat(expected_clients, ", "),
			#names > 0 and table.concat(names, ", ") or "none"
		))
	end

	if vim.treesitter.highlighter.active[buf] then
		pass(label .. " treesitter")
	else
		fail(label .. " treesitter", "no treesitter highlighter on " .. vim.bo[buf].filetype)
	end

	local formatters, lsp_fallback = require("conform").list_formatters_to_run(buf)
	if #formatters > 0 then
		pass(label .. " formatter", table.concat(vim.tbl_map(function(f) return f.name end, formatters), ", "))
	elseif lsp_fallback then
		pass(label .. " formatter", "LSP fallback")
	else
		fail(label .. " formatter", "no formatter available")
	end
	return buf
end

local function check_definition(buf)
	vim.api.nvim_set_current_buf(buf)
	vim.api.nvim_win_set_cursor(0, { 3, 21 }) -- on `add` in `add(1, 2)`
	local client = vim.lsp.get_clients({ bufnr = buf, method = "textDocument/definition" })[1]
	if not client then
		fail("ts go-to-definition", "no client supports textDocument/definition")
		return
	end
	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
	-- the server may still be loading the project right after attach, so retry
	local found = vim.wait(30000, function()
		local resp = vim.lsp.buf_request_sync(buf, "textDocument/definition", params, 5000) or {}
		for _, r in pairs(resp) do
			local result = r.result and (vim.islist(r.result) and r.result[1] or r.result)
			local uri = result and (result.uri or result.targetUri)
			if uri and uri:match("a%.ts$") then
				return true
			end
		end
		return false
	end, 1000)
	if found then
		pass("ts go-to-definition", "b.ts -> a.ts")
	else
		fail("ts go-to-definition", "no location in a.ts returned within 30s")
	end
end

local function check_deprecations()
	local own, plugins = {}, {}
	for _, d in ipairs(deprecations) do
		if vim.startswith(d.src, config_dir) and not d.src:match("/scripts/") then
			own[("%s:%d %s"):format(d.src:sub(#config_dir + 2), d.line, d.name)] = true
		else
			plugins[(d.src:match("/lazy/([^/]+)/") or d.src) .. ": " .. d.name] = true
		end
	end
	local own_list = vim.tbl_keys(own)
	if #own_list > 0 then
		table.sort(own_list)
		fail("deprecations (config)", table.concat(own_list, "; "))
	else
		pass("deprecations (config)", "none from your files")
	end
	for _, line in ipairs(vim.tbl_keys(plugins)) do
		warn("deprecation (plugin)", line)
	end
end

local function run()
	out("Neovim " .. tostring(vim.version()) .. " | config: " .. config_dir)
	check_startup()
	check_plugins()
	check_keymaps()

	write_file(tmp .. "/ts/package.json", { '{ "name": "check" }' })
	write_file(tmp .. "/ts/tsconfig.json", { '{ "compilerOptions": { "strict": true } }' })
	write_file(tmp .. "/ts/a.ts", { "export function add(a: number, b: number): number {", "  return a + b;", "}" })
	write_file(tmp .. "/ts/b.ts", { 'import { add } from "./a";', "", "export const total = add(1, 2);" })
	write_file(tmp .. "/py/pyproject.toml", { "[project]", 'name = "check"' })
	write_file(tmp .. "/py/main.py", { "def add(a: int, b: int) -> int:", "    return a + b" })

	local ts_buf = check_filetype("ts", tmp .. "/ts/b.ts", { "vtsls" })
	check_definition(ts_buf)
	check_filetype("lua", config_dir .. "/lua/config/options.lua", { "lua_ls" })
	check_filetype("python", tmp .. "/py/main.py", { "pyright", "ruff" })

	check_deprecations()

	out(fails == 0 and "\nAll checks passed." or ("\n%d check(s) failed."):format(fails))
	vim.cmd(fails == 0 and "qa!" or "cquit 1")
end

-- Hard stop so a hung server can't block the script forever
vim.defer_fn(function()
	fail("watchdog", "checks did not finish within 180s")
	vim.cmd("cquit 2")
end, 180000)

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			local ok, err = pcall(run)
			if not ok then
				fail("check script", tostring(err))
				vim.cmd("cquit 2")
			end
		end)
	end,
})
