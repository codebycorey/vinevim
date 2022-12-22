local harpoon_ok = pcall(require, "harpoon")
if not harpoon_ok then
    return
end

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", function()
    harpoon_mark.add_file()
end, { desc = "[A]dd to harpoon" })
vim.keymap.set("n", "<C-e>", function()
    harpoon_ui.toggle_quick_menu()
end, { desc = "Open floating harpoon" })
