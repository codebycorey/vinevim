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
                    -- Main backgrounds
                    base = "#1e1e1e", -- Main editor background (dark grey)
                    mantle = "#181818", -- Sidebar background (darker grey)
                    crust = "#0f0f0f", -- Status line background (near black)

                    -- Surface colors for UI elements
                    surface0 = "#2a2a2a", -- Slightly lighter grey for panels
                    surface1 = "#3a3a3a", -- For hover states
                    surface2 = "#4a4a4a", -- For selected items

                    -- Keep text colors for good contrast
                    text = "#cdd6f4", -- Main text (light blue-white)
                    subtext1 = "#bac2de", -- Secondary text
                    subtext0 = "#a6adc8", -- Tertiary text

                    -- Optional: slightly muted overlay for better integration
                    overlay0 = "#6c7086", -- Comments and disabled text
                    overlay1 = "#7f849c", -- Line numbers
                    overlay2 = "#9399b2", -- Brackets and operators
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
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
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
            overrides = function(colors)
                return {
                    -- Cool to Warm Gradient for Markdown Headers
                    RenderMarkdownH1Bg = { bg = colors.palette.springBlue, fg = colors.palette.sumiInk0 },
                    RenderMarkdownH2Bg = { bg = colors.palette.waveAqua2, fg = colors.palette.sumiInk0 },
                    RenderMarkdownH3Bg = { bg = colors.palette.autumnGreen, fg = colors.palette.sumiInk0 },
                    RenderMarkdownH4Bg = { bg = colors.palette.autumnYellow, fg = colors.palette.sumiInk0 },
                    RenderMarkdownH5Bg = { bg = colors.palette.autumnRed, fg = colors.palette.oldWhite },
                    RenderMarkdownH6Bg = { bg = colors.palette.winterRed, fg = colors.palette.oldWhite },
                }
            end,
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            -- vim.cmd.colorscheme("kanagawa")
        end,
    },
    {
        "neanias/everforest-nvim",
        name = "everforest",
        priority = 1000,
        opts = {},
    },
}
