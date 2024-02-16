return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>bf",
                function()
                    require("conform").format({ lsp_fallback = true })
                end,
                desc = "[B]uffer [F]ormat",
            },
        },
        opts = {
            format = {
                timeout_ms = 3000,
                async = false,
                quiet = false,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                typescript = { "prettierd" },
                javascript = { "prettierd" },
                typescriptreact = { "prettierd" },
                javascriptreact = { "prettierd" },
            },
            format_on_save = { timeout_ms = 3000, lsp_fallback = true },
        },
    },
}
