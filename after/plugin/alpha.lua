local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then
    return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
    [[         __                           __                ]],
    [[ __  __ /\_\    ___     ___   __  __ /\_\    ___ ___    ]],
    [[/\ \/\ \\/\ \  / _ `\  / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[\ \ \_/ |\ \ \/\ \/\ \/\  __/\ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[ \ \___/  \ \_\ \_\ \_\ \____\\ \___/  \ \_\ \_\ \_\ \_\]],
    [[  \/__/    \/_/\/_/\/_/\/____/ \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {

    dashboard.button("f", "Find file", ":Telescope find_files <CR>"),
    dashboard.button("e", "New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button(
        "p",
        "Find project",
        ":lua require('telescope').extensions.projects.projects()<CR>"
    ),
    dashboard.button("r", "Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "Find text", ":Telescope live_grep <CR>"),
    dashboard.button("s", "Find Session", ":Telescope sessions save_current=false <CR>"),
    dashboard.button("c", "Config", ":e ~/.config/nvim/init.lua <CR>"),
    dashboard.button("q", "Quit", ":qa<CR>"),
}

alpha.setup(dashboard.config)
