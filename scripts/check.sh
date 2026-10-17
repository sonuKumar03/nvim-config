#!/usr/bin/env bash
# Headless health check for this Neovim config.
# Checks startup, plugin loading, keymaps, LSP/treesitter/formatters for TS, Lua and Python,
# and deprecated API use. Exits non-zero if any check fails.
#
# Usage: scripts/check.sh   (run it after :Lazy update)

set -u

if ! command -v nvim >/dev/null 2>&1; then
	echo "FAIL  nvim not found on PATH"
	exit 1
fi

script_dir="$(cd "$(dirname "$0")" && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

NVIM_CHECK_TMP="$tmp" nvim --headless --cmd "luafile $script_dir/check.lua" 2>/dev/null
