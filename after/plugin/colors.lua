-- vim.o.background = "dark"
-- vim.g.gruvbox_contrast_dark = "hard"
--
require("catppuccin").setup({
    transparent_background = true,
})

-- vim.cmd([[colorscheme tokyonight-night]])

require("onedark").setup({
    style = "darker",
    transparent = true,
})

require("kanagawa").setup({
    transparent = true
})

vim.cmd.colorscheme("kanagawa")

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--
