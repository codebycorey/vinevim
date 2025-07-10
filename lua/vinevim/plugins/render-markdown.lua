return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ft = { "markdown", "codecompanion", "norg", "org" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            completions = {
                lsp = { enabled = true },
                blink = { enabled = true },
            },
            code = {
                border = "thin",
            },
            heading = {
                icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
            },
            overrides = {
                buftype = {
                    nofile = {
                        render_modes = { "n", "c", "v" },
                    },
                },
            },
        },
    },
}
