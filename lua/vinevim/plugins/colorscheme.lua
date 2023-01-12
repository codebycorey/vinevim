return {
    "gruvbox-community/gruvbox",
    "folke/tokyonight.nvim",
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
            })
        end,
    },
    "navarasu/onedark.nvim",
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({ transparent = true })

            vim.cmd.colorscheme("kanagawa")
        end,
    },
}

-- vim.o.background = "dark"
-- vim.g.gruvbox_contrast_dark = "hard"
--
-- require("catppuccin").setup({
--     transparent_background = true,
-- })

-- vim.cmd([[colorscheme tokyonight-night]])

-- require("onedark").setup({
--     style = "darker",
--     transparent = true,
-- })
