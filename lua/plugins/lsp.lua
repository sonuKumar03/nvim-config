return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local function setup(server, opts)
				vim.lsp.config(
					server,
					vim.tbl_deep_extend("force", {
						capabilities = capabilities,
					}, opts or {})
				)
			end

			local function angular_root_dir(fname)
				if fname == "" or fname == nil then
					return nil
				end

				local marker = vim.fs.find({ "angular.json", "nx.json" }, { path = fname, upward = true })[1]
				return marker and vim.fs.dirname(marker) or nil
			end

			setup("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			setup("pyright", {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
			})

			setup("gopls", {
				settings = {
					gopls = {
						gofumpt = true,
						completeUnimported = true,
						usePlaceholders = true,
						staticcheck = true,
						analyses = {
							unusedparams = true,
							unusedwrite = true,
						},
					},
				},
			})

			setup("ts_ls", {
				root_dir = function(bufnr, on_dir)
					local fname = vim.api.nvim_buf_get_name(bufnr)
					local marker = vim.fs.find({ "tsconfig.json", "package.json", "jsconfig.json", ".git" }, { path = fname, upward = true })[1]
					local root = marker and vim.fs.dirname(marker) or nil
					if root then
						on_dir(root)
					end
				end,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			})

			setup("texlab", {})

			local function angular_library_path()
				local ok, registry = pcall(require, "mason-registry")
				if ok then
					local ok_package, pkg = pcall(registry.get_package, "angular-language-server")
					if ok_package and pkg:is_installed() then
						return pkg:get_install_path() .. "/node_modules/@angular"
					end
				end

				return vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules/@angular"
			end

			local function get_project_root(root_dir)
				local node_modules = vim.fs.find("node_modules", { path = root_dir, upward = true })[1]
				return node_modules and vim.fs.dirname(node_modules) or nil
			end

			local function get_ngserver(root_dir)
				local project_root = get_project_root(root_dir)
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

				return vim.fn.exepath("ngserver")
			end

			local function get_probe_dir(root_dir)
				local project_root = get_project_root(root_dir)
				return project_root and (project_root .. "/node_modules") or angular_library_path()
			end

			local function get_angular_core_version(root_dir)
				local project_root = get_project_root(root_dir)
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

			setup("angularls", {
				root_dir = function(bufnr, on_dir)
					local fname = vim.api.nvim_buf_get_name(bufnr)
					local root = angular_root_dir(fname)
					if root then
						on_dir(root)
					end
				end,
				cmd = {
					get_ngserver(vim.fn.getcwd()),
					"--stdio",
					"--tsProbeLocations",
					get_probe_dir(vim.fn.getcwd()),
					"--ngProbeLocations",
					get_probe_dir(vim.fn.getcwd()),
					"--angularCoreVersion",
					get_angular_core_version(vim.fn.getcwd()),
				},
				on_new_config = function(new_config, new_root_dir)
					local probe_dir = get_probe_dir(new_root_dir)
					local angular_core_version = get_angular_core_version(new_root_dir)

					new_config.cmd = {
						get_ngserver(new_root_dir),
						"--stdio",
						"--tsProbeLocations",
						probe_dir,
						"--ngProbeLocations",
						probe_dir,
						"--angularCoreVersion",
						angular_core_version,
					}
				end,
			})
			vim.lsp.enable({ "angularls", "lua_ls", "pyright", "gopls", "ts_ls", "texlab" })
		end,
	},
}
