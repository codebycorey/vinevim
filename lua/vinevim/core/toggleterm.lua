local term_ok, toggleTerm = pcall(require, "toggleTerm")
if not term_ok then
    return
end

local config = {
    direction = "float"
}

toggleTerm.setup(config)

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local keymap = require("vinevim.utils.keymap")

keymap("n", "<leader>g", "<CMD>lua _LAZYGIT_TOGGLE()<CR>")
