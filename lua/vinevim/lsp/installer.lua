local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
    return
end

local server_config = require("vinevim.lsp.config")

local handle_server_ready = function(server)
    local options = {
        on_attach = server_config.on_attach,
        capabilities = server_config.capabilities,
    }

    if server.name == "sumneko_lua" then
        local sumneko_options = require("vinevim.lsp.settings.sumneko_lua")
        options = vim.tbl_deep_extend("force", sumneko_options, options)
    end

    server:setup(options)
end

lsp_installer.on_server_ready(handle_server_ready)
