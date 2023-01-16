local M = {}

function M.get_server_settings(server_name)
    local server_config_module = "vinevim.plugins.lsp.settings." .. server_name

    local ok, server_config = pcall(require, server_config_module)
    if ok then
        return server_config
    end

    return {}
end

return M
