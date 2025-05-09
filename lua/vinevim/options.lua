-- setup leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line Numbers
vim.opt.number = true
-- vim.opt.relativenumber = true

-- Tabs and Indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.showtabline = 4

-- show whitespace
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("tab:>-")
vim.opt.listchars:append("eol:↴")

-- Turn off Search Highlight
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- Turn off error bells
vim.opt.errorbells = false

-- Text Display
vim.opt.wrap = false

-- history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.writebackup = false

vim.o.mousescroll = "ver:3,hor:0"

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.cursorline = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.showmode = false

vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.updatetime = 50

vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.opt.completeopt = "menuone,noselect,noinsert"

vim.opt.mouse = "a"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.shortmess:append("c")

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.g.netrw_liststyle=3

vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
