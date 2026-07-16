local function java_root(fname)
	local start = fname ~= "" and fname or vim.fn.getcwd()
	local marker = vim.fs.find({
		"gradlew",
		"mvnw",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
		"settings.gradle",
		"settings.gradle.kts",
	}, { path = start, upward = true })[1]

	return marker and vim.fs.dirname(marker) or (fname ~= "" and vim.fs.dirname(fname) or vim.fn.getcwd())
end

return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local fname = vim.api.nvim_buf_get_name(0)
			local root_dir = java_root(fname)
			local project_name = vim.fn.fnamemodify(root_dir, ":p:t")
			local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

			require("jdtls").start_or_attach({
				cmd = {
					vim.fn.exepath("jdtls"),
					"-data",
					workspace_dir,
				},
				root_dir = root_dir,
				capabilities = require("blink.cmp").get_lsp_capabilities(),
				settings = {
					java = {
						signatureHelp = {
							enabled = true,
						},
						contentProvider = {
							preferred = "fernflower",
						},
						completion = {
							favoriteStaticMembers = {
								"java.util.Collections.*",
								"java.util.stream.Collectors.*",
							},
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
					},
				},
			})
		end,
	},
}
