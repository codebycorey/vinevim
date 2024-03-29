-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")

-- Navigate Buffers
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Go to previous buffer" })

-- Jump Tmux session
vim.keymap.set("n", "<C-f>", "<Cmd>:silent !tmux neww tmux-manager<CR>", { desc = "Switch tmux session" })

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent and keep active select" })
vim.keymap.set("v", ">", ">gv", { desc = "Remove Indent and keep active select" })

vim.keymap.set("n", "<leader><leader>s", "<Cmd>source %<CR>", { desc = "Source current file" })

-- Pane management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "make split windows equal width & height" })
vim.keymap.set("n", "<leader>q", ":close<CR>", { desc = "close current split window" })
-- Resize with arrows
vim.keymap.set("n", "<leader><Up>", ":resize -10<CR>", { desc = "resize window up" })
vim.keymap.set("n", "<leader><Down>", ":resize +10<CR>", { desc = "resize window down" })
vim.keymap.set("n", "<leader><Left>", ":vertical resize +10<CR>", { desc = "resize window left" })
vim.keymap.set("n", "<leader><Right>", ":vertical resize -10<CR>", { desc = "resize window right" })

-- Move blocks of code
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "move highlighted lines down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "move highlighted lines up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page jumping down with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page jumping up with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Search term jumping down with cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search term  jumping up with cursor centered" })

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>l", vim.cmd.Lazy, { desc = "[L]azy" })
