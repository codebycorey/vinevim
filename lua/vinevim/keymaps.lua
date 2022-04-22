local keymap = require("vinevim.utils.keymap")

-- Remap space as leader key
keymap("", "<Space>", "<Nop>")
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
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical -2<CR>")
keymap("n", "<C-Right>", ":resize +2<CR>")

-- Navigate Buffers
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")
keymap("n", "<leader>bq", "<Cmd>bp|bd #<CR>")

-- Jump Tmux session
keymap("n", "<C-f>", "<Cmd>:silent !tmux neww tmux-session<CR>")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")
keymap("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>.+1<CR>gv-gv")
keymap("x", "<A-k>", ":move '.-2<CR>gv-gv")

keymap("n", "<C-f>", ":!tmux neww tmux-session<CR>")
keymap("n", "<leader>ow", ":!tmux neww work-tmux<CR>")

keymap("n", "<leader><leader>s", "<Cmd>source %<CR>")
