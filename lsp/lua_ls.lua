---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
            },
            telemetry = {
                enabled = false, -- Disable telemetry
            },
            -- hint = {
            --     enable = true,
            --     setType = false,
            --     paramType = true,
            --     paramName = "Disable",
            -- },
        },
    },
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
}
