local tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not tree_ok then
    return
end

local icons = require("vinevim.theme.icons")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.g.nvim_tree_group_empty = 1
-- vim.g.nvim_tree_git_hl = 1

local parameters = {
    disable_netrw = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = icons.diagnostics.Hint,
            info = icons.diagnostics.Information,
            warning = icons.diagnostics.Warning,
            error = icons.diagnostics.Error,
        },
    },
    git = {
        ignore = false,
    },
    renderer = {
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            },
        },
        group_empty = true,
    },
}
nvim_tree.setup(parameters)

vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>")
