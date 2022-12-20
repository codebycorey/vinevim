local tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not tree_ok then
    return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
            hint = "H",
            info = "I",
            warning = "W",
            error = "E",
        },
    },
    git = {
        ignore = false,
    },
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                folder = false,
                git = false,
            },
        },
        group_empty = true,
    },
    view = {
        mappings = {
            list = {
                { key = "<C-e>", action = "" },
                { key = "e", action = "" },
                { key = "r", action = "full_rename" },
            },
        },
    },
}
nvim_tree.setup(parameters)

vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
