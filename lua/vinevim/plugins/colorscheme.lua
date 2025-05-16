return {
    {
        "catppuccin/nvim",
        priority = 1000,
        name = "catppuccin",
        opts = {
            flavor = "mocha",
            terminal_colors = true,
            transparent_background = false,
            color_overrides = {
                mocha = {
                    base = "#202020",
                    mantle = "#262626",
                    crust = "#181616",
                },
            },
            integrations = {
                harpoon = true,
                neotree = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                telescope = {
                    enabled = true,
                    style = "nvchad",
                },
                illuminate = true,
                flash = true,
                mason = true,
                gitsigns = true,
                mini = {
                    enabled = true,
                },
            },
        },
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        opts = {
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                            bg = "#202020", -- More gray background
                            bg_dim = "#1c1c1c", -- Darker gray for contrast
                            bg_p1 = "#262626", -- Mid-gray for panels
                            bg_p2 = "#303030", -- Lighter gray for secondary panels
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            vim.cmd.colorscheme("kanagawa")
        end,
    },
}
