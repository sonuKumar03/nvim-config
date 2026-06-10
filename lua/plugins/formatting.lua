return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				python = { "ruff_format" },
				go = { "goimports", "gofumpt" },
				json = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			notify_on_error = true,
			notify_no_formatters = true,
		},
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
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
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
				"angular-language-server",
			},
			run_on_start = true,
			start_delay = 3000,
			debounce_hours = 24,
		},
	},
}
