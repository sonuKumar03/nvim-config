return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			-- Helper function to detect local project-level Prettier configurations
			local function has_prettier_config(ctx)
				local config_files = {
					".prettierrc",
					".prettierrc.json",
					".prettierrc.yml",
					".prettierrc.yaml",
					".prettierrc.json5",
					".prettierrc.js",
					".prettierrc.cjs",
					".prettierrc.mjs",
					"prettier.config.js",
					"prettier.config.cjs",
					"prettier.config.mjs",
				}
				if vim.fs.find(config_files, { path = ctx.filename, upward = true })[1] then
					return true
				end
				local package_json = vim.fs.find("package.json", { path = ctx.filename, upward = true })[1]
				if package_json then
					local file = io.open(package_json, "r")
					if file then
						local content = file:read("*a")
						file:close()
						local ok, data = pcall(vim.json.decode, content)
						if ok and data and data.prettier then
							return true
						end
					end
				end
				return false
			end

			local global_config = vim.fn.stdpath("config") .. "/prettier.config.js"
			local has_global_config = vim.uv.fs_stat(global_config) ~= nil

			-- prettier: pass the global config only when the project has none
			local function get_prettier_args(self, ctx)
				if has_global_config and not has_prettier_config(ctx) then
					return { "--config", global_config }
				end
				return {}
			end

			-- prettierd (daemon, faster) is tried first; prettier is the fallback if it's missing
			local prettier = { "prettierd", "prettier", stop_after_first = true }

			return {
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = prettier,
					javascriptreact = prettier,
					typescript = prettier,
					typescriptreact = prettier,
					go = { "goimports", "gofumpt" },
					python = { "ruff_organize_imports", "ruff_format" },
					json = prettier,
					yaml = prettier,
					markdown = prettier,
					html = prettier,
					css = prettier,
					scss = prettier,
				},
				default_format_opts = {
					lsp_format = "fallback",
				},
				format_on_save = function(bufnr)
					return {
						timeout_ms = 1000,
						lsp_format = "fallback",
					}
				end,
				notify_on_error = true,
				notify_no_formatters = true,
				formatters = {
					prettier = {
						prepend_args = get_prettier_args,
					},
					prettierd = {
						-- prettierd ignores --config; it only uses this when the project has no config
						env = has_global_config and { PRETTIERD_DEFAULT_CONFIG = global_config } or nil,
					},
				},
			}
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				go = { "golangcilint" },
			}

			local lint_group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = lint_group,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
				"prettier",
				"eslint_d",
				"goimports",
				"gofumpt",
				"golangci-lint",
				-- ruff and angular-language-server are installed by mason-lspconfig (mason.lua)
				"json-lsp",
				"dockerfile-language-server",
				"yaml-language-server",
				"marksman",
				"html-lsp",
				"css-lsp",
			},
			run_on_start = true,
			start_delay = 3000,
			debounce_hours = 24,
		},
	},
}
