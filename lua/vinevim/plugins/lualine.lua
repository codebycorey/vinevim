return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            disabled_filetypes = { "NvimTree" },
            globalstatus = true,
            theme = "auto",
        },
    },
    config = function(_, opts)
        print("Hello!!")
        require("lualine").setup(opts)
    end,
}
