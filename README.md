# Neovim Config

Personal Neovim setup for fullstack work, Python practice, and Nx monorepos.

## Features

- lazy.nvim plugin management
- LSP for Lua, JavaScript/TypeScript, Python, and Go
- formatting with conform.nvim
- linting with nvim-lint
- debugging with nvim-dap, dap-ui, dap-python, and dap-vscode-js
- test runner integration with neotest
- Git workflow with gitsigns, diffview, neogit, and fugitive
- project search/replace with nvim-spectre
- diagnostics UI with Trouble
- terminal split with toggleterm.nvim
- buffer tabs with barbar.nvim
- LeetCode Python scratch/run workflow
- task runner support with overseer.nvim

## Requirements

- Neovim 0.12+
- `git`
- `rg`
- `fd`
- `node`
- `python3`
- `go`
- `gh` if you want to create or clone the repo from GitHub

## Install

Clone into the standard Neovim config path:

```bash
gh repo clone sonuKumar03/nvim-config ~/.config/nvim
```

Or with plain git:

```bash
git clone git@github.com:sonuKumar03/nvim-config.git ~/.config/nvim
```

Start Neovim once to bootstrap plugins:

```bash
nvim
```

## Second Machine

To set this up on another machine:

```bash
gh repo clone sonuKumar03/nvim-config ~/.config/nvim
nvim
```

If you already have a local config and want to replace it, back it up first:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
gh repo clone sonuKumar03/nvim-config ~/.config/nvim
nvim
```

## Main Keys

### Navigation

- `<leader>e` toggle Neo-tree at project root
- `<leader>E` toggle Neo-tree at current directory
- `<leader>ge` Neo-tree git status
- `<leader>be` Neo-tree buffers
- `<leader>ff` find files
- `<leader>fg` live grep
- `<leader>fb` buffers
- `<leader>fh` help tags

### Buffers

- `<leader>bn` new buffer
- `<leader>bh` previous buffer
- `<leader>bl` next buffer
- `<leader>bc` close buffer

### Git

- `<leader>gg` Neogit
- `<leader>gf` Fugitive status
- `<leader>gB` Fugitive blame
- `<leader>ga` or `<leader>gO` open Diffview
- `<leader>gA` or `<leader>gC` close Diffview
- `<leader>gF` file history
- `<leader>gL` or `<leader>gH` current file history
- `<leader>gs`, `<leader>gr`, `<leader>gS`, `<leader>gR`, `<leader>gu`, `<leader>gp`, `<leader>gP`, `<leader>gb`, `<leader>gd`
  - gitsigns hunk actions

### Search / Replace

- `<leader>sr` project search/replace
- `<leader>sR` current file search/replace
- `<leader>sw` visual selection search/replace
- `<leader>sA` apply Spectre replacement
- `<leader>sl` resume last Spectre search

### Diagnostics

- `<leader>xx` workspace diagnostics
- `<leader>xX` buffer diagnostics
- `<leader>xe` workspace errors
- `<leader>xE` buffer errors
- `<leader>xq` quickfix
- `<leader>xl` location list
- `<leader>xs` symbols
- `<leader>xr` references
- `<leader>xd` definitions

### Debug

- `<leader>db` toggle breakpoint
- `<leader>dB` conditional breakpoint
- `<leader>dc` continue
- `<leader>di` step into
- `<leader>do` step over
- `<leader>dO` step out
- `<leader>dr` open REPL
- `<leader>du` toggle DAP UI
- `<leader>dt` terminate
- `<leader>dl` run last

### Tests

- `<leader>tr` run nearest
- `<leader>tf` run file
- `<leader>ts` run suite
- `<leader>td` debug nearest
- `<leader>tt` stop
- `<leader>to` output
- `<leader>tO` output panel
- `<leader>tS` summary

### Terminal / Tasks

- `<leader>ot` toggle terminal
- `<leader>oo` open Overseer
- `<leader>oO` toggle Overseer
- `<leader>or` run Overseer task

### Tabs / Buffers

- `<leader>tn` new tab
- `<leader>th` previous tab
- `<leader>tl` next tab
- `<leader>tc` close tab
- `<leader>?` show keymaps with which-key

## Notes

- `lazy-lock.json` is committed so plugin versions stay pinned.
- `nvim.log` is ignored.
- This repo is configured for a fullstack workflow with JS/TS, Python, and Go support.
