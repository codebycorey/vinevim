return {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {
            [[         __                           __                ]],
            [[ __  __ /\_\    ___     ___   __  __ /\_\    ___ ___    ]],
            [[/\ \/\ \\/\ \  / __`\  / __`\/\ \/\ \\/\ \  / __` __`\  ]],
            [[\ \ \_/ |\ \ \/\ \/\ \/\  __/\ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[ \ \___/  \ \_\ \_\ \_\ \____\\ \___/  \ \_\ \_\ \_\ \_\]],
            [[  \/__/    \/_/\/_/\/_/\/____/ \/__/    \/_/\/_/\/_/\/_/]],
        }
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
    end,
}
