-- Set leader keys before any plugins load to ensure correct keymap bindings
vim.g.mapleader = " "
vim.g.maplocalleader = ""

local opt = vim.opt

-- =============================================================================
-- Core UI Options
-- =============================================================================
opt.number = true           -- Show absolute line number for the current line
opt.relativenumber = true   -- Show relative line numbers for vertical navigation movements
opt.cursorline = true       -- Highlight the text line under the cursor
opt.termguicolors = true    -- Enable 24-bit RGB colors (required by Catppuccin)
opt.signcolumn = "yes"      -- Always show signcolumn to prevent screen jitter/shifting on diagnostics
opt.showmode = false        -- Don't show mode (e.g. -- INSERT --) since Lualine statusline handles it

-- =============================================================================
-- Navigation & Layout Options
-- =============================================================================
opt.scrolloff = 8           -- Keep minimum 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8       -- Keep minimum 8 columns left/right of cursor when scrolling
opt.splitright = true       -- Open vertical splits to the right of the current window
opt.splitbelow = true       -- Open horizontal splits below the current window
opt.wrap = false            -- Disable line wrapping by default

-- =============================================================================
-- Indentation & Formatting
-- =============================================================================
opt.tabstop = 2             -- Number of spaces that a <Tab> character stands for
opt.shiftwidth = 2          -- Number of spaces to use for each step of (auto)indent
opt.expandtab = true        -- Convert tab characters to spaces automatically
opt.smartindent = true      -- Insert indents automatically in response to code syntax

-- =============================================================================
-- Search
-- =============================================================================
opt.ignorecase = true       -- Case-insensitive searching
opt.smartcase = true        -- Override ignorecase if search query contains uppercase letters
opt.hlsearch = false        -- Disable persistent search highlights (cleared on ESC via keymaps)

-- =============================================================================
-- Performance & System Integrations
-- =============================================================================
opt.updatetime = 250        -- Faster update time (defaults to 4000ms) for diagnostics/hover triggers
opt.timeoutlen = 300        -- Timeout in milliseconds to wait for a mapped sequence to complete
opt.confirm = true          -- Confirm to save changes before exiting modified buffer instead of failing
opt.undofile = true         -- Enable persistent undo across editor restarts (default path created by Neovim)

-- Incremental command preview (shows substitute/search-replace effects live in a split buffer)
opt.inccommand = "split"    

-- Performance: Defer clipboard setup. Querying system clipboards (pbcopy, xclip, etc.) 
-- blocks the main thread. Postponing this reduces Neovim's initial startup time.
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

-- =============================================================================
-- Diagnostic Styles & Overrides
-- =============================================================================
vim.diagnostic.config({
	update_in_insert = false,  -- Don't update diagnostics while typing to prevent layout jitter
	severity_sort = true,      -- Sort diagnostics by severity for consistent UI ordering
	float = { border = "rounded", source = "if_many" }, -- Use rounded borders for popups
	underline = { severity = { min = vim.diagnostic.severity.WARN } }, -- Underline Warnings and Errors

	virtual_text = true,       -- Render inline diagnostics text on the active line
	virtual_lines = false,     -- Disable virtual lines span under the text (useful layout preference)

	-- Automatically trigger floating window popup when jumping to a diagnostic item
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})
