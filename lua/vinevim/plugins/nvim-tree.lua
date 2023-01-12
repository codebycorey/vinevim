return {
    "nvim-tree/nvim-tree.lua",
    opts = {
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
                    git = false,
                },
            },
            indent_markers = {
                enable = true,
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
    },
    keys = {
        { "<leader>e", function() vim.cmd.NvimTreeToggle() end, desc = "Toggle Nvim Tree" },
    }
}
