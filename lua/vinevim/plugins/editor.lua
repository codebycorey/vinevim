return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
        end,
        opts = {
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
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
            "s1n7ax/nvim-window-picker",
            opts = {
                other_win_hl_color = require("vinevim.theme").waveRed,
            },
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
    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        keys = {
            {
                "<leader>xx",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                desc = "Trouble: Document Diagnics (Trouble)",
            },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble Quckfix list (Trouble)" },
        },
    },
    {
        "mbbill/undotree",
        keys = { { "<leader>u", ":UndotreeShow<CR>", desc = "Open Undotree" } },
    },
    {
        "ThePrimeagen/harpoon",
        keys = {
            {
                "<leader>a",
                function()
                    require("harpoon.mark").add_file()
                end,
                desc = "[A]dd to harpoon",
            },
            {
                "<C-e>",
                function()
                    require("harpoon.ui").toggle_quick_menu()
                end,
                desc = "Open floating harpoon",
            },
        },
    },
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        opts = { delay = 200 },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },
    {
        "echasnovski/mini.bufremove",
        -- stylua: ignore
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
        },
    },
}
