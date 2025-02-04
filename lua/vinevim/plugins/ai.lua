return {
    {
        "github/copilot.vim",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        lazy = false,
    },
    {
        "olimorris/codecompanion.nvim",
        cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionToggle" },
        dependencies = {
            "saghen/blink.cmp",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            adapters = {
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                default = "claude-3.5-sonnet",
                            },
                        },
                    })
                end,
            },
            display = {
                chat = {
                    show_references = true,
                    show_settings = true,
                },
            },
            strategies = {
                chat = {
                    adapter = "copilot",
                },
            },
        },
        keys = {
            {
                "<leader>ac",
                function()
                    vim.cmd("CodeCompanionChat toggle")
                end,
                desc = "[A]I [C]hat",
            },
            {
                "<leader>aa",
                function()
                    vim.cmd("CodeCompanionActions")
                end,
                desc = "[A]I [A]ctions",
            },
            {
                "<leader>aa",
                function()
                    vim.cmd("CodeCompanionChat add")
                end,
                desc = "AI add to chat",
                mode = { "v" },
            },
        },
    },
}
