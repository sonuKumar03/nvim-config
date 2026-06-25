-- Silence deprecation warnings (mostly from third-party plugins during startup)
vim.deprecate = function() end

require("config.options")

-- Setup lazy.nvim
require("config.lazy")

require("config.keymaps")

require("config.autocmds")
