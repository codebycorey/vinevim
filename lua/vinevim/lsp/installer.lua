local M = {}

M.setup = function(servers)
    local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
    if not lsp_installer_ok then
        return
    end

    local installer_settings = {
        automatic_installation = true,
        ensure_installed = servers,
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗",
            },
        },
    }

    lsp_installer.setup(installer_settings)
end

return M
