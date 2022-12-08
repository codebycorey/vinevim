local M = {}

M.setup = function(servers)
    local mason_ok, mason = pcall(require, "mason")
    local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

    if not mason_ok or not mason_lspconfig_ok then
        return
    end

    local installer_settings = {
        automatic_installation = true,
        ensure_installed = servers,
    }

    mason.setup()
    mason_lspconfig.setup(installer_settings)
end

return M
