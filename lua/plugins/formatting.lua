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

			local function get_prettier_args(self, ctx)
				if not has_prettier_config(ctx) then
					local global_config = vim.fn.stdpath("config") .. "/prettier.config.js"
					if vim.uv.fs_stat(global_config) then
						return { "--config", global_config }
					end
				end
				return {}
			end

			local function prettier_or_fallback(bufnr)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				if has_prettier_config({ filename = fname }) then
					return { "prettierd", "prettier", stop_after_first = true }
				else
					return { "prettier" }
				end
			end

			return {
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = prettier_or_fallback,
					javascriptreact = prettier_or_fallback,
					java = {},
					typescript = prettier_or_fallback,
					typescriptreact = prettier_or_fallback,
					python = { "ruff_format" },
					go = { "goimports", "gofumpt" },
					json = prettier_or_fallback,
					markdown = prettier_or_fallback,
					html = prettier_or_fallback,
					css = prettier_or_fallback,
					scss = prettier_or_fallback,
				},
				default_format_opts = {
					lsp_format = "fallback",
				},
				format_on_save = function(bufnr)
					if vim.bo[bufnr].filetype == "java" then
						-- Keep Java save lightweight for LeetCode scratch files; use manual LSP formatting when needed.
						return nil
					end
					return {
						timeout_ms = 500,
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
						prepend_args = get_prettier_args,
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
				python = { "ruff" },
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
				"ruff",
				"goimports",
				"gofumpt",
				"golangci-lint",
				"texlab",
				"json-lsp",
				"marksman",
				"html-lsp",
				"css-lsp",
				{ "angular-language-server", version = "20.3.0" },
			},
			run_on_start = false,
			start_delay = 3000,
			debounce_hours = 24,
		},
	},
}
