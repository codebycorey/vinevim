return {
    "gruvbox-community/gruvbox",
    "folke/tokyonight.nvim",
    "nyoom-engineering/oxocarbon.nvim",
    {
        "catppuccin/nvim",
        -- lazy = false,
        -- priority = 1000,
        name = "catppuccin",
        opts = {
            flavor = "mocha",
            terminal_colors = true,
            transparent_background = false,
            color_overrides = {
                mocha = {
                    base = "#181616",
                    mantle = "#181616",
                    crust = "#181616",
                },
            },
            integrations = {
                harpoon = true,
                telescope = true,
                neotree = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                illuminate = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            -- vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
    "navarasu/onedark.nvim",
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function(_, opts)
            require("kanagawa").setup(opts)
            -- require("kanagawa").load("dragon")
            require("kanagawa").load()
        end,
    },
}
