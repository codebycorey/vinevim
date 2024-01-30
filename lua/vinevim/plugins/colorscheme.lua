return {
    "gruvbox-community/gruvbox",
    "folke/tokyonight.nvim",
    "nyoom-engineering/oxocarbon.nvim",
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        name = "catppuccin",
        opts = {
            flavor = "mocha",
            terminal_colors = true,
            transparent_background = false,
            color_overrides = {
                mocha = {
                    base = "#121212",
                    mantle = "#181818",
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
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
    "navarasu/onedark.nvim",
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            overrides = function(colors)
                local theme = colors.theme
                return {
                    -- TelescopeTitle = { fg = theme.ui.special, bold = true },
                    -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                    -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                }
            end,
        },
        config = function(_, opts)
            -- require("kanagawa").setup(opts)
            -- require("kanagawa").load("dragon")
            -- require("kanagawa").load()
        end,
    },
}
