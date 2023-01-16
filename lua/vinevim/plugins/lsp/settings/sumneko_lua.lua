return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "require" }
            },
            -- workspace = { library = vim.api.nvim_get_runtime("", true)},
            telemetry = { enabled = false }
        }
    }
}
