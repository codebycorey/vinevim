# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is **Vinevim**, a personal Neovim configuration using lazy.nvim for plugin management. The config is organized under `lua/vinevim/` with LSP servers defined separately in `/lsp/`.

## Architecture

```
init.lua                    # Entry point, loads vinevim module
lua/vinevim/
├── init.lua                # Loads options → keymaps → lazy → autocommands
├── options.lua             # Vim settings
├── keymaps.lua             # Global keybindings
├── lazy.lua                # lazy.nvim setup (imports plugins/)
├── autocommands.lua        # Auto commands
├── utils.lua               # LSP helpers, version checking
├── icons.lua               # UI icon definitions
└── plugins/                # Plugin specs (one file per plugin or group)
lsp/                        # LSP server configs (*.lua)
```

## Key Patterns

### Plugin Specifications
Plugins are defined in `lua/vinevim/plugins/` as Lua files returning lazy.nvim spec tables. Each file typically contains one or more related plugin definitions.

### LSP Server Configuration
LSP servers live in `/lsp/*.lua`. Each file returns a `vim.lsp.Config` table. To disable a server, add `-- disable` as the first line of its file. The `utils.get_lsp_servers()` function auto-discovers enabled servers.

### Utils Module
- `utils.set_lsp_keymap(bufnr, mode, lhs, rhs, opts, method)` - Sets keymaps only if the LSP supports the capability
- `utils.get_lsp_servers()` - Returns list of enabled LSP server names from `/lsp/`

## Code Style

Lua formatting via stylua: 4-space indentation, 120 char line width, double quotes preferred.

## Core Plugins

- **blink.cmp** - Completion engine
- **fzf-lua** - Fuzzy finder (files, grep, buffers, LSP)
- **conform.nvim** - Formatting (stylua, prettier, black)
- **nvim-lint** - Linting (eslint_d, cspell)
- **neo-tree.nvim** - File explorer
- **neogit** - Git interface
- **nvim-dap** - Debugger with JS/TS/Python support
- **CodeCompanion** - AI assistant with Copilot adapter
