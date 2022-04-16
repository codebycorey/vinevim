local tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not tree_ok then
    return
end

local options = {
    disable_netrw = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
}

nvim_tree.setup(options)

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", opts)
