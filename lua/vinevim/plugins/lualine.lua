return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                disabled_filetypes = { "NvimTree" },
                globalstatus = true,
                theme = "auto",
            },
        },
    },
}
