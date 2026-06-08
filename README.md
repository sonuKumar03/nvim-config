# Neovim Config

Neovim setup for fullstack work, Python practice, and Nx monorepos.

## Install

```bash
gh repo clone sonuKumar03/nvim-config ~/.config/nvim
nvim
```

If you already have a local config, back it up first:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
gh repo clone sonuKumar03/nvim-config ~/.config/nvim
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
- `gh`

## Reference

| Area | Keys | Description |
| --- | --- | --- |
| Files | `<leader>e`, `<leader>E` | Neo-tree root and current-directory views |
| Search | `<leader>ff`, `<leader>fg`, `<leader>fb`, `<leader>fh` | Telescope file, grep, buffer, and help pickers |
| Buffers | `<leader>bn`, `<leader>bh`, `<leader>bl`, `<leader>bc` | Create, move, and close buffers |
| Git | `<leader>gg`, `<leader>gf`, `<leader>gB` | Neogit, Fugitive status, and Fugitive blame |
| Diff | `<leader>ga`, `<leader>gO`, `<leader>gA`, `<leader>gC`, `<leader>gF`, `<leader>gL`, `<leader>gH` | Diffview open/close and file history |
| Replace | `<leader>sr`, `<leader>sR`, `<leader>sw`, `<leader>sA`, `<leader>sl` | Spectre project/file/visual replace |
| Diagnostics | `<leader>xx`, `<leader>xX`, `<leader>xe`, `<leader>xE`, `<leader>xq`, `<leader>xl`, `<leader>xs`, `<leader>xr`, `<leader>xd` | Trouble diagnostics, quickfix, symbols, refs, defs |
| Debug | `<leader>db`, `<leader>dB`, `<leader>dc`, `<leader>di`, `<leader>do`, `<leader>dO`, `<leader>dr`, `<leader>du`, `<leader>dt`, `<leader>dl` | DAP breakpoints, stepping, REPL, UI, last run |
| Tests | `<leader>tr`, `<leader>tf`, `<leader>ts`, `<leader>td`, `<leader>tt`, `<leader>to`, `<leader>tO`, `<leader>tS` | Neotest run, debug, stop, output, summary |
| Terminal | `<leader>ot` | ToggleTerm |
| Tasks | `<leader>oo`, `<leader>oO`, `<leader>or` | Overseer open, toggle, run |
| LeetCode | `<leader>lc`, `<leader>lr` | Open scratch buffer and run current Python file |
| Tabs | `<leader>tn`, `<leader>th`, `<leader>tl`, `<leader>tc` | Tab open, previous, next, close |
| Help | `<leader>?` | which-key |

## Notes

- `lazy-lock.json` is committed to pin plugin versions.
- `nvim.log` is ignored.
