local sig_ok, signature = pcall(require, 'lsp_signature')
if not sig_ok then
    return
end

local config = {}

signature.setup(config)
signature.on_attach(config)
