return {
    "folke/snacks.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        indent = { enabled = true },
        explorer = { enabled = true },
        -- picker = {
        --     sources = {
        --         explorer = {
        --             git_status = true,
        --         },
        --     },
        -- },
    },
    keys = {
        -- {
        --     "<leader>e",
        --     function()
        --         Snacks.explorer()
        --     end,
        --     desc = "File [E]xplorer",
        -- },
        -- ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
    },
    config = function(_, opts)
        require("snacks").setup(opts)
    end,
}
