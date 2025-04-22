return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        opts = {
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {},
                },
                window = {
                    mappings = {
                        ["<bs>"] = "none",
                    },
                },
            },
            window = {
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<space>"] = "none",
                    ["<bs>"] = "clone_node",
                    ["<cr>"] = "open_with_window_picker",
                },
            },
        },
        dependencies = {
            {
                "s1n7ax/nvim-window-picker",
                opts = {
                    hint = "floating-big-letter",
                },
            },
            { "MunifTanjim/nui.nvim" },
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute({ toggle = true })
                end,
            },
        },
    },
}
