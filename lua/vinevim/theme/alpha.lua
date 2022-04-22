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
    dashboard.button("f", "Find File", ":Telescope find_files<CR>"),
}

alpha.setup(dashboard.opts)
