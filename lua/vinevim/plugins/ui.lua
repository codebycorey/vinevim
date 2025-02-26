return {
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                close_command = function(n)
                    require("mini.bufremove").delete(n, false)
                end,
                right_mouse_command = function(n)
                    require("mini.bufremove").delete(n, false)
                end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true,
                        text_align = "left",
                    },
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        -- separator = true,
                        text_align = "left",
                    },
                    {
                        filetype = "snacks_picker_list",
                        text = "File Explorer",
                        highlight = "Directory",
                        -- separator = true,
                        text_align = "left",
                    },
                },
                show_close_icon = false,
            },
            highlights = require("catppuccin.groups.integrations.bufferline").get(),
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                disabled_filetypes = { "NvimTree" },
                globalstatus = true,
                theme = "auto",
            },
        },
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        disable = true,
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss all Notifications",
            },
        },
        opts = {
            timeout = 3000,
        },
        init = function()
            vim.notify = require("notify")
        end,
    },
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            local augroup = vim.api.nvim_create_augroup
            local autocmd = vim.api.nvim_create_autocmd

            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            local headers = {
                ANSI_SHADOW_VINEVIM = {
                    [[██╗   ██╗██╗███╗   ██╗███████╗██╗   ██╗██╗███╗   ███╗]],
                    [[██║   ██║██║████╗  ██║██╔════╝██║   ██║██║████╗ ████║]],
                    [[██║   ██║██║██╔██╗ ██║█████╗  ██║   ██║██║██╔████╔██║]],
                    [[╚██╗ ██╔╝██║██║╚██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║]],
                    [[ ╚████╔╝ ██║██║ ╚████║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║]],
                    [[  ╚═══╝  ╚═╝╚═╝  ╚═══╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                },
                ANSI_SHADOW_NEOVIM = {
                    [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
                    [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
                    [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
                    [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
                    [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
                    [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                },
            }

            dashboard.section.header.val = headers.ANSI_SHADOW_NEOVIM
            dashboard.section.buttons.val = {
                dashboard.button("<leader>sf", "[S]earch [F]iles"),
                dashboard.button("<leader>sp", "[S]earch git [P]roject files"),
                dashboard.button("<leader>sg", "[S]earch by [G]rep"),
                dashboard.button("<leader>?", "[?] Search recently opened files"),
                dashboard.button("<leader>e", "[E]xplore file tree"),
                dashboard.button("c", "Config", ":e ~/.config/nvim/init.lua <CR>"),
                dashboard.button("q", "Quit", ":qa<CR>"),
            }

            alpha.setup(dashboard.config)

            autocmd("User", {
                group = augroup("alpha", {}),
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },
    { "MunifTanjim/nui.nvim", lazy = true },
    {
        "stevearc/dressing.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
}
