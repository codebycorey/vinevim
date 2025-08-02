local M = {}
function M.open_progress_notif(title, msg)
    return require("fidget.progress").handle.create({
        title = title,
        -- message = msg,
        -- lsp_client = { name = ">>" }, -- the fake lsp client name
        percentage = nil, -- skip percentage field
    })
end

return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim", "fidget.nvim" },
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>bf",
                function()
                    local progress_notif = M.open_progress_notif("Conform", "Formatting buffer...")
                    require("conform").format({ lsp_fallback = true }, function(err)
                        progress_notif:finish()
                        if err then
                            local fmt_info = "Conform"
                            vim.notify(err, vim.log.levels.WARN, { title = fmt_info })
                        end
                    end)
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
                typescript = { "prettierd", "prettier", stop_after_first = true },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = { timeout_ms = 3000, lsp_fallback = true },
        },
    },
}
