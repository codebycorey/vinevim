local lsp_ok, _ = pcall(require, "lspconfig")
if not lsp_ok then
    return
end

-- List of language servers to be installed and configured
local language_servers = {
    "sumneko_lua",
    "tsserver",
    "jsonls",
    "rust_analyzer",
    "gopls",
    "pyright",
    "bashls",
    "svelte",
    "marksman",
}

local missing_installer_language_servers = {
    -- "stylua",
}

-- Core configurations
require("vinevim.lsp.installer").setup(language_servers)
require("vinevim.lsp.configs").setup(language_servers)
require("vinevim.lsp.configs").setup(missing_installer_language_servers)

-- Extra plugins
-- require("vinevim.lsp.signature")
require("vinevim.lsp.null-ls")
