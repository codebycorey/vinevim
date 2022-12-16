-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")
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
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical -2<CR>")
vim.keymap.set("n", "<C-Right>", ":resize +2<CR>")

-- Navigate Buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>bq", "<Cmd>bp|bd #<CR>", { desc = "Close buffer and switch to previous" })

-- Jump Tmux session
vim.keymap.set("n", "<C-f>", "<Cmd>:silent !tmux neww tmux-session<CR>", { desc = "Switch tmux session" })

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent and keep active select" })
vim.keymap.set("v", ">", ">gv", { desc = "Remove Indent and keep active select" })

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "<A-j>", ":move '>.+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '.-2<CR>gv-gv")

vim.keymap.set("n", "<leader><leader>s", "<Cmd>source %<CR>", { desc = "Source current file" })

vim.keymap.set("n", "<leader>u", ":UndotreeShow<CR>", { desc = "Open Undotree" })
