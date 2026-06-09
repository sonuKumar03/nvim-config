# Neovim Config

Neovim setup for fullstack work, Python practice, and Nx monorepos.

## Install

```bash
git clone https://github.com/sonuKumar03/nvim-config.git ~/.config/nvim
nvim
```

If you already have a local config:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
git clone https://github.com/sonuKumar03/nvim-config.git ~/.config/nvim
nvim
```

## Requirements

- Neovim 0.12+
- `git`
- `rg`
- `fd`
- `node`
- `python3`
- `go`

## Cheatsheets

Need help remembering keys? Check out these detailed references:
- **[Vim Motion Cheatsheet](./cheatsheet_motion.md)**: Standard movements, editing commands, and text objects.
- **[Plugins Cheatsheet](./cheatsheet_plugins.md)**: Interactive commands, custom LSP keymaps, search-and-replace, debugging, and test runners.


## Daily Workflow

### Start Here

- `<leader>?` shows keymaps with which-key
- `<leader>ff` finds files
- `<leader>fg` searches text across the project
- `<leader>e` opens Neo-tree at the project root
- `<leader>E` opens Neo-tree at the current directory

### Files and Buffers

- `<leader>bn` creates a new buffer
- `<leader>bh` and `<leader>bl` move between buffers
- `<leader>bc` closes the current buffer
- `<leader>be` opens the Neo-tree buffers view
- `barbar.nvim` shows open buffers as a tabline
- native tabpage keymaps are not part of this config

### Git

- `<leader>gg` opens Neogit
- `<leader>gf` opens Fugitive status
- `<leader>gB` opens Fugitive blame
- `<leader>gO` opens Diffview
- `<leader>gC` closes Diffview
- `<leader>gF` opens file history
- `<leader>gH` opens current-file history
- `gitsigns` handles hunk staging, reset, preview, blame, and navigation

### Search and Replace

- `<leader>sr` opens Spectre for project-wide replace
- `<leader>sR` opens Spectre for current-file replace
- `<leader>sw` opens Spectre for a visual selection
- `<leader>sA` applies the replacement
- `<leader>sl` resumes the last Spectre search

### Diagnostics

- `<leader>xx` opens workspace diagnostics
- `<leader>xX` opens buffer diagnostics
- `<leader>xe` and `<leader>xE` filter to errors
- `<leader>xq` opens quickfix
- `<leader>xl` opens location list
- `<leader>xs` opens symbols
- `<leader>xr` opens references
- `<leader>xd` opens definitions

### Debug

- `<leader>db` toggles a breakpoint
- `<leader>dB` sets a conditional breakpoint
- `<leader>dc` continues
- `<leader>di` steps into
- `<leader>do` steps over
- `<leader>dO` steps out
- `<leader>dr` opens the REPL
- `<leader>du` toggles the DAP UI
- `<leader>dt` terminates
- `<leader>dl` reruns the last session

### Tests

- `<leader>tr` runs the nearest test
- `<leader>tf` runs the current file
- `<leader>ts` runs the suite
- `<leader>td` debugs the nearest test
- `<leader>tt` stops a running test
- `<leader>to` opens test output
- `<leader>tO` toggles the output panel
- `<leader>tS` toggles the summary panel

### Terminal and Tasks

- `<leader>ot` toggles the terminal
- `toggleterm.nvim` opens a horizontal split by default
- `<leader>oo` opens Overseer
- `<leader>oO` toggles Overseer
- `<leader>or` runs an Overseer task

### LeetCode

- `:LeetCodeScratch` opens a Python scratch buffer
- `:LeetCodeRun` runs the current Python file

## Notes

- `lazy-lock.json` pins plugin versions.
- `nvim.log` is ignored.
- This config is tuned for JS/TS, Python, Go, and Nx work.
