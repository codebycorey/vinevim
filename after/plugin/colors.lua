-- vim.o.background = "dark"
-- vim.g.gruvbox_contrast_dark = "hard"
--
-- require("catppuccin").setup({
--     transparent_background = true,
-- })

-- vim.cmd([[colorscheme tokyonight-night]])

-- require("onedark").setup({
--     style = "darker",
--     transparent = true,
-- })

local ok, kanagawa = pcall(require, 'kanagawa')
if not ok then
    return
end

kanagawa.setup({
    transparent = true
})

vim.cmd.colorscheme("kanagawa")

