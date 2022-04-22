-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and Indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.showtabline = 4

-- Turn off Search Highlight
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- Keep Buffers Open
vim.opt.hidden = true

-- Turn off error bells
vim.opt.errorbells = false

-- Text Display
vim.opt.wrap = false

-- history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
--undodir = '$HOME/.vim/undodir'
vim.opt.writebackup = false

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.cursorline = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.showmode = false
--completeopt = { "menuone" "noselect" }, -- "noinsert"

vim.opt.cmdheight = 1
vim.opt.updatetime = 300 -- 50

vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.opt.mouse = "a"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.guicursor = ""

vim.opt.shortmess:append("c")
