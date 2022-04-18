local indent_ok, indent_blankline = pcall(require, "indent_blankline")
if not indent_ok then
    return
end

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("tab:>-")
-- vim.opt.listchars:append('eol:↴')

indent_blankline.setup({
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = false,
    space_char_blankline = " ",
})
