return {
    "lukas-reineke/indent-blankline.nvim",
    event = 'VeryLazy',
    opts = {
        show_current_context = true,
        show_current_context_start = true,
        show_end_of_line = false,
        space_char_blankline = " ",
    },
    config = function(_, opts)
        -- vim.opt.list = true
        -- vim.opt.listchars:append("space:⋅")
        -- vim.opt.listchars:append("tab:>-")
        -- vim.opt.listchars:append('eol:↴')
        require("indent_blankline").setup(opts)
    end,
}
