return {
    "folke/snacks.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ---@type snacks.Config
    opts = {
        indent = { enabled = true },
    },
    config = function(_, opts)
        require("snacks").setup(opts)
    end,
}
