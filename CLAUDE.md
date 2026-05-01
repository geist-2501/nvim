# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. Written in Lua.

## Structure

- `init.lua` — entry point; loads `lua/blair/`
- `lua/blair/` — core config (keymaps, settings, lazy bootstrap)
  - `remap.lua` — global keymaps (leader = `<Space>`)
  - `set.lua` — vim options
  - `lazy.lua` — bootstraps lazy.nvim and imports `lua/plugins/`
- `lua/plugins/` — one file per plugin or plugin group, each returning a lazy.nvim plugin spec
- `.luarc.json` — lua-language-server workspace config pointing at nvim runtime and lazy.nvim

## Plugin overview

| File | Plugin(s) | Purpose |
|------|-----------|---------|
| `lsp.lua` | mason, mason-lspconfig, nvim-lspconfig, blink.cmp, roslyn.nvim | LSP, completion, C# support |
| `telescope.lua` | telescope.nvim | Fuzzy finder |
| `treesitter.lua` | nvim-treesitter | Syntax highlighting & indentation |
| `conform.lua` | conform.nvim | Formatting (prettier for JS/TS) |
| `lazygit.lua` | lazygit.nvim | Git UI |

## LSP servers

Enabled via `vim.lsp.enable()`: `lua_ls`, `hls` (Haskell), `vtsls` (TypeScript/JS), `eslint_lsp`, `denols`. C# uses `roslyn.nvim` separately.

## Theme persistence

`theme.lua` persists dark/light state to `vim.fn.stdpath("data") .. "/theme_state"`. State is read on startup and applied immediately.

## Adding a plugin

Create a new file in `lua/plugins/` returning a valid lazy.nvim spec. It is auto-imported by `lazy.lua`.
