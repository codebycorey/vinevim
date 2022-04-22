local lsp_ok, _ = pcall(require, "lspconfig")
if not lsp_ok then
    return
end

require("vinevim.lsp.config").setup()
require("vinevim.lsp.installer")

require("vinevim.lsp.null-ls")
