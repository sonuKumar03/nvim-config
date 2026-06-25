return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"mason-org/mason.nvim",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local angular = require("plugins.lsp.angular")
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
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
							},
						},
					},
				},
				gopls = {
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
				},
				vtsls = {
					root_dir = function(bufnr, on_dir)
						local fname = vim.api.nvim_buf_get_name(bufnr)
						local marker = vim.fs.find(
							{ "tsconfig.json", "package.json", "jsconfig.json", ".git" },
							{ path = fname, upward = true }
						)[1]
						local root = marker and vim.fs.dirname(marker) or nil
						if root then
							on_dir(root)
						end
					end,
					settings = {
						typescript = {
							tsserver = {
								maxTsServerMemory = 4096,
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
									"**/coverage/**",
									"**/tmp/**",
								},
							},
						},
						vtsls = {
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
				texlab = {},
				angularls = {
					filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
					root_dir = function(bufnr, on_dir)
						local fname = vim.api.nvim_buf_get_name(bufnr)
						local marker = vim.fs.find(
							{ "tsconfig.json", "package.json", "jsconfig.json", ".git" },
							{ path = fname, upward = true }
						)[1]
						local root = marker and vim.fs.dirname(marker) or nil
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
						local probe_dir = angular.resolve_probe_dir(root_dir)
						local angular_core_version = angular.resolve_core_version(root_dir)
						local cmd = {
							vim.fn.exepath("node"),
							"--max-old-space-size=4096",
							angular.resolve_ngserver_bin(root_dir),
							"--stdio",
							"--tsProbeLocations",
							probe_dir,
							"--ngProbeLocations",
							probe_dir,
							"--angularCoreVersion",
							angular_core_version,
						}
						return vim.lsp.rpc.start(cmd, dispatchers)
					end,
				},
				jsonls = {},
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
							client.supports_method = function(method, opts)
								if method == "textDocument/definition" then
									local bufnr = opts and opts.bufnr or 0
									local ft = vim.bo[bufnr].filetype
									if ft == "typescript" or ft == "typescriptreact" or ft == "typescript.tsx" then
										return false
									end
								end
								return orig_supports_method(method, opts)
							end
						end
					end

					-- Toggle inlay hints in insert mode to eliminate typing lag
					if client and client.supports_method("textDocument/inlayHint") then
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
					map("gr", vim.lsp.buf.references, "Goto References")
					map("gI", vim.lsp.buf.implementation, "Goto Implementation") -- handled by vtsls
					map("gy", vim.lsp.buf.type_definition, "Type Definition")

					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
					map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
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
						require("telescope.builtin").lsp_references()
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
						require("telescope.builtin").lsp_dynamic_workspace_symbols()
					end, "Open Workspace Symbols (Telescope)")
					map("grt", function()
						require("telescope.builtin").lsp_type_definitions()
					end, "Goto Type Definition (Telescope)")
				end,
			})
		end,
	},
}
