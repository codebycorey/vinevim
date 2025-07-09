return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
        opts = {
            code = {
                border = "thin",
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
