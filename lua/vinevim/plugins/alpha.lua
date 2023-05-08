local headers = {
    ANSI_SHADOW_VINEVIM = {
        [[██╗   ██╗██╗███╗   ██╗███████╗██╗   ██╗██╗███╗   ███╗]],
        [[██║   ██║██║████╗  ██║██╔════╝██║   ██║██║████╗ ████║]],
        [[██║   ██║██║██╔██╗ ██║█████╗  ██║   ██║██║██╔████╔██║]],
        [[╚██╗ ██╔╝██║██║╚██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[ ╚████╔╝ ██║██║ ╚████║███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[  ╚═══╝  ╚═╝╚═╝  ╚═══╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    },
    ANSI_3D_VINEVIM = {
        [[         __                           __                ]],
        [[ __  __ /\_\    ___     ___   __  __ /\_\    ___ ___    ]],
        [[/\ \/\ \\/\ \  / __`\  / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[\ \ \_/ |\ \ \/\ \/\ \/\  __/\ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[ \ \___/  \ \_\ \_\ \_\ \____\\ \___/  \ \_\ \_\ \_\ \_\]],
        [[  \/__/    \/_/\/_/\/_/\/____/ \/__/    \/_/\/_/\/_/\/_/]],
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

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local alpha_group = augroup("alpha", {})

return {
    "goolord/alpha-nvim",
    -- event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

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
            group = alpha_group,
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
