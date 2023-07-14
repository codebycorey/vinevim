return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G" },
    },
    {
        "tpope/vim-rhubarb",
        cmd = { "Git" },
        enable = false,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
        cmd = { "Neogit" },
        keys = {
            {
                "<leader>g",
                function()
                    require("neogit").open({})
                end,
            },
        },
        opts = {
            kind = "split",
            integrations = {
                diffview = true,
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
        },
    },
}
