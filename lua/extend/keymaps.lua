local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical -2<CR>", opts)
keymap("n", "<C-Right>", ":resize +2<CR>", opts)

-- Navigate Buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bq", "<Cmd>bp|bd #<CR>", opts)

-- Source NVIM config without restarting Neovim
keymap("n", "<leader>so", "<Cmd>so ~/.config/nvim/init.lua<CR>", opts)
keymap("n", "<leader>mm", "<Cmd>Telescope find_files<CR>", opts)

-- Jump Tmux session
keymap("n", "<C-f>", "<Cmd>:silent !tmux neww tmux-session<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>.+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '.-2<CR>gv-gv", opts)

