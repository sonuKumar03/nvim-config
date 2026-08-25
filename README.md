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

- `<space><space>` or `<leader>P` or `<C-p>` opens the VS Code Command Palette (`legendary.nvim`)
- `<leader>?` shows keymaps with which-key
- `<leader>ff` finds files (Telescope)
- `<leader>fg` searches text across the project (Live Grep)
- `<leader>e` opens Neo-tree at the project root

### Editing & Navigation

- `]r` and `[r` jump to next/previous occurrence of the symbol under cursor (`vim-illuminate`)
- `gcc` comments or uncomments the current line
- `gbc` block comments the current line
- `gc` (in Visual mode) comments or uncomments the selection
- `gb` (in Visual mode) block comments the selection

### Files and Buffers

- `<Tab>` and `<S-Tab>` jump to next/previous open buffer
- `<leader>bp` interactively picks a buffer by overlay label
- `<leader>bn` creates a new buffer
- `<leader>bh` and `<leader>bl` move to previous/next buffers
- `<leader>bc` closes the current buffer
- `<leader>be` opens the Neo-tree buffers view

### Git

- `<leader>gg` opens LazyGit
- `<leader>gv` opens Diffview
- `<leader>gC` closes Diffview
- `<leader>gF` opens file history
- `<leader>gH` opens current-file history
- `<leader>gb` toggles inline current-line Git blame
- `gitsigns` handles hunk staging, reset, preview, blame, and navigation (`]h` / `[h`)

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

### LeetCode

- `:LCP [name]` opens a Python scratch file
- `:LCPR` runs the current Python file

## Notes

- `lazy-lock.json` pins plugin versions.
- `nvim.log` is ignored.
- This config is tuned for JS/TS, Python, Go, and Nx work.
- Includes `wilder.nvim` (floating command palette) and `schemastore.nvim` (JSON/YAML schema validation).
