# Neovim Config

Neovim setup for fullstack work, Python practice, and Nx monorepos.

## Install

```bash
gh repo clone sonuKumar03/nvim-config ~/.config/nvim
nvim
```

If you already have a local config:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
gh repo clone sonuKumar03/nvim-config ~/.config/nvim
nvim
```

## Requires

- Neovim 0.12+
- `git`
- `rg`
- `fd`
- `node`
- `python3`
- `go`
- `gh`

## Main Keys

- `<leader>e` / `<leader>E` Neo-tree
- `<leader>ff` / `<leader>fg` / `<leader>fb` / `<leader>fh` Telescope
- `<leader>bn` / `<leader>bh` / `<leader>bl` / `<leader>bc` Buffers
- `<leader>gg` / `<leader>gf` / `<leader>gB` Git
- `<leader>ga` / `<leader>gO` / `<leader>gA` / `<leader>gC` / `<leader>gF` / `<leader>gL` / `<leader>gH` Diffview
- `<leader>sr` / `<leader>sR` / `<leader>sw` / `<leader>sA` / `<leader>sl` Spectre
- `<leader>xx` / `<leader>xX` / `<leader>xe` / `<leader>xE` / `<leader>xq` / `<leader>xl` / `<leader>xs` / `<leader>xr` / `<leader>xd` Trouble
- `<leader>db` / `<leader>dB` / `<leader>dc` / `<leader>di` / `<leader>do` / `<leader>dO` / `<leader>dr` / `<leader>du` / `<leader>dt` / `<leader>dl` DAP
- `<leader>tr` / `<leader>tf` / `<leader>ts` / `<leader>td` / `<leader>tt` / `<leader>to` / `<leader>tO` / `<leader>tS` Tests
- `<leader>ot` ToggleTerm
- `<leader>oo` / `<leader>oO` / `<leader>or` Overseer
- `<leader>lc` / `<leader>lr` LeetCode
- `<leader>tn` / `<leader>th` / `<leader>tl` / `<leader>tc` Tabs
- `<leader>?` which-key

## Notes

- `lazy-lock.json` is committed to pin plugin versions.
- `nvim.log` is ignored.

