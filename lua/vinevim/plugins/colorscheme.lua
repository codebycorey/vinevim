return {
    "gruvbox-community/gruvbox",
    "folke/tokyonight.nvim",
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            transparent_background = true,
        },
    },
    "navarasu/onedark.nvim",
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = { transparent = true },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            require("kanagawa").load()
        end,
    },
}
