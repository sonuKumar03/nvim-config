return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"mason-org/mason.nvim",
			"b0o/schemastore.nvim",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local angular = require("plugins.lsp.angular")
			local function is_ts_filetype(bufnr)
				local ft = vim.bo[bufnr].filetype
				return ft == "typescript" or ft == "typescriptreact"
			end

			local angular_disabled_ts_methods = {
				["textDocument/declaration"] = true,
				["textDocument/definition"] = true,
				["textDocument/implementation"] = true,
				["textDocument/references"] = true,
				["textDocument/typeDefinition"] = true,
			}

			-- Server configurations table
			local servers = {
				lua_ls = {
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
				},
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = true, -- Handled by ruff
						},
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},
				ruff = {
					root_dir = function(bufnr, on_dir)
						local fname = vim.api.nvim_buf_get_name(bufnr)
						local marker = vim.fs.find(
							{ "pyproject.toml", "ruff.toml", ".ruff.toml", "requirements.txt", "setup.py", ".git" },
							{ path = fname, upward = true }
						)[1]
						local root = (marker and vim.fs.dirname(marker))
							or (fname ~= "" and vim.fs.dirname(fname))
							or vim.fn.getcwd()
						if root then
							on_dir(root)
						end
					end,
				},
				gopls = {
					settings = {
						gopls = {
							gofumpt = true,
							completeUnimported = true,
							usePlaceholders = true,
							staticcheck = true,
							codelenses = {
								generate = true,
								gc_details = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
							},
							analyses = {
								nilness = true,
								shadow = true,
								unusedparams = true,
								unusedwrite = true,
							},
						},
					},
				},
				vtsls = {
					root_dir = function(bufnr, on_dir)
						local fname = vim.api.nvim_buf_get_name(bufnr)
						local root = angular.find_root(fname)
						if not root then
							local marker = vim.fs.find(
								{ "tsconfig.json", "package.json", "jsconfig.json", ".git" },
								{ path = fname, upward = true }
							)[1]
							root = marker and vim.fs.dirname(marker) or nil
						end
						if root then
							on_dir(root)
						end
					end,
					settings = {
						typescript = {
							tsserver = {
								maxTsServerMemory = 8192,
							},
							referencesCodeLens = {
								enabled = true,
								showOnAllFunctions = false,
							},
							implementationsCodeLens = {
								enabled = true,
								showOnAllClassMethods = false,
								showOnInterfaceMethods = true,
							},
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
							suggest = {
								completeFunctionCalls = true,
								autoImports = true,
								paths = true,
							},
							preferences = {
								importModuleSpecifier = "non-relative",
								importModuleSpecifierEnding = "minimal",
								includePackageJsonAutoImports = "on",
								preferTypeOnlyAutoImports = true,
								autoImportFileExcludePatterns = {
									"**/dist/**",
									"**/.nx/**",
									"**/.angular/**",
									"**/coverage/**",
									"**/tmp/**",
								},
							},
						},
						javascript = {
							referencesCodeLens = {
								enabled = true,
								showOnAllFunctions = false,
							},
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
							suggest = {
								completeFunctionCalls = true,
								autoImports = true,
								paths = true,
							},
							preferences = {
								importModuleSpecifier = "non-relative",
								importModuleSpecifierEnding = "minimal",
								includePackageJsonAutoImports = "on",
								autoImportFileExcludePatterns = {
									"**/dist/**",
									"**/.nx/**",
									"**/.angular/**",
									"**/coverage/**",
									"**/tmp/**",
								},
							},
						},
						vtsls = {
							autoUseWorkspaceTsdk = true,
							watchOptions = {
								excludeDirectories = {
									"**/node_modules",
									"**/dist",
									"**/.angular",
									"**/.nx",
									"**/coverage",
									"**/tmp",
								},
							},
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = true,
									entriesLimit = 200,
								},
								enableProjectDiagnostics = false,
							},
						},
					},
				},
				angularls = {
					filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
					root_dir = function(bufnr, on_dir)
						local fname = vim.api.nvim_buf_get_name(bufnr)
						local root = angular.find_root(fname)
						if root then
							on_dir(root)
						end
					end,
					cmd = function(dispatchers)
						local fname = vim.api.nvim_buf_get_name(0)
						local marker = vim.fs.find(
							{ "tsconfig.json", "package.json", "jsconfig.json", ".git" },
							{ path = fname, upward = true }
						)[1]
						local root_dir = marker and vim.fs.dirname(marker) or vim.fn.getcwd()
						local ts_probe = angular.resolve_ts_probe_locations(root_dir)
						local ng_probe = angular.resolve_ng_probe_locations(root_dir)
						local angular_core_version = angular.resolve_core_version(root_dir)
						local cmd = {
							vim.fn.exepath("node"),
							"--max-old-space-size=4096",
							angular.resolve_ngserver_bin(root_dir),
							"--stdio",
							"--tsProbeLocations",
							ts_probe,
							"--ngProbeLocations",
							ng_probe,
							"--angularCoreVersion",
							angular_core_version,
						}
						return vim.lsp.rpc.start(cmd, dispatchers)
					end,
				},
				jsonls = {
					on_new_config = function(new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
					end,
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				dockerls = {},
				yamlls = {
					on_new_config = function(new_config)
						new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
						vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
					end,
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
				marksman = {},
				html = {
					-- Prevent collision: If in an Angular project, angularls handles HTML templates
					root_dir = function(bufnr, on_dir)
						local fname = vim.api.nvim_buf_get_name(bufnr)
						if angular.find_root(fname) then
							return nil
						end
						local marker = vim.fs.find({ "package.json", ".git" }, { path = fname, upward = true })[1]
						local root = marker and vim.fs.dirname(marker) or nil
						if root then
							on_dir(root)
						end
					end,
				},
				cssls = {},
			}

			-- Setup and enable all servers in one place
			local server_names = {}
			for name, opts in pairs(servers) do
				vim.lsp.config(
					name,
					vim.tbl_deep_extend("force", {
						capabilities = capabilities,
					}, opts)
				)
				table.insert(server_names, name)
			end

			vim.lsp.enable(server_names)

			-- LSP Keymaps on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client and client.name == "angularls" then
						if not client._supports_method_overridden then
							client._supports_method_overridden = true
							local orig_supports_method = client.supports_method
							client.supports_method = function(self, method, bufnr)
								if type(bufnr) == "table" then
									bufnr = bufnr.bufnr
								end
								bufnr = bufnr or 0
								if angular_disabled_ts_methods[method] and is_ts_filetype(bufnr) then
									return false
								end
								return orig_supports_method(self, method, bufnr)
							end
						end
					end

					-- Toggle inlay hints in insert mode to eliminate typing lag
					if client and client:supports_method("textDocument/inlayHint", ev.buf) then
						vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
						vim.api.nvim_create_autocmd("InsertEnter", {
							buffer = ev.buf,
							callback = function()
								vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
							end,
						})
						vim.api.nvim_create_autocmd("InsertLeave", {
							buffer = ev.buf,
							callback = function()
								vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
							end,
						})
					end

					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end

					map("gd", vim.lsp.buf.definition, "Goto Definition")
					map("gD", vim.lsp.buf.declaration, "Goto Declaration") -- handled by vtsls
					map("gr", function()
						vim.lsp.buf.references(nil, {
							on_list = function(options)
								local filtered = {}
								for _, item in ipairs(options.items) do
									if not string.find(item.filename, "node_modules", 1, true) then
										table.insert(filtered, item)
									end
								end
								if #filtered == 0 then
									vim.notify("No references found outside node_modules", vim.log.levels.INFO)
									return
								end
								vim.fn.setqflist({}, " ", { title = options.title, items = filtered })
								vim.api.nvim_command("copen")
							end,
						})
					end, "Goto References")
					map("gI", vim.lsp.buf.implementation, "Goto Implementation") -- handled by vtsls
					map("gy", vim.lsp.buf.type_definition, "Type Definition")

					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>lk", vim.lsp.buf.signature_help, "Signature Help")
					vim.keymap.set("n", "<leader>rn", function()
						return ":IncRename " .. vim.fn.expand("<cword>")
					end, { expr = true, buffer = ev.buf, desc = "LSP: Rename Symbol (Incremental)" })
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
					map("[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Previous Diagnostic")
					map("]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next Diagnostic")

					-- Telescope LSP bindings
					map("grr", function()
						require("telescope.builtin").lsp_references({
							file_ignore_patterns = { "node_modules" },
						})
					end, "Goto References (Telescope)")
					map("gri", function()
						require("telescope.builtin").lsp_implementations()
					end, "Goto Implementation (Telescope)")
					map("grd", function()
						require("telescope.builtin").lsp_definitions()
					end, "Goto Definition (Telescope)")
					map("gO", function()
						require("telescope.builtin").lsp_document_symbols()
					end, "Open Document Symbols (Telescope)")
					map("gW", function()
						require("telescope.builtin").lsp_dynamic_workspace_symbols({
							file_ignore_patterns = { "node_modules" },
						})
					end, "Open Workspace Symbols (Telescope)")
					map("grt", function()
						require("telescope.builtin").lsp_type_definitions()
					end, "Goto Type Definition (Telescope)")
				end,
			})
		end,
	},
}
