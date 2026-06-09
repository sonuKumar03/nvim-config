vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("latex-keymaps", { clear = true }),
	pattern = { "tex", "plaintex" },
	callback = function(event)
		local map = function(keys, cmd, desc)
			vim.keymap.set("n", keys, cmd, { buffer = event.buf, desc = "LaTeX: " .. desc })
		end

		map("<leader>ltc", "<cmd>VimtexCompile<cr>", "Compile")
		map("<leader>ltv", "<cmd>VimtexView<cr>", "View PDF")
		map("<leader>ltl", "<cmd>VimtexClean<cr>", "Clean Aux Files")
	end,
})
