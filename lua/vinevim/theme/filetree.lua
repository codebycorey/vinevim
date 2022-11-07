local tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not tree_ok then
    return
end

local icons = require("vinevim.theme.icons")


-- vim.g.nvim_tree_group_empty = 1
-- vim.g.nvim_tree_git_hl = 1

-- TODO: Consolidate with icons file
local tree_icons = {
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
}

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
    renderer = {
        icons = {
            glyphs = tree_icons,
        },
        group_empty = true,
    }
}
nvim_tree.setup(parameters)

local keymap = require("vinevim.utils.keymap")

keymap("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>")
