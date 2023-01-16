local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local lsp_group = augroup("Lsp", {})

function M.setup(client, buffer)
    if client.server_capabilities.document_highlight then
        autocmd({ "CursorHold", "CursorHoldI" }, {
            group = lsp_group,
            buffer = buffer,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
        })
        autocmd("CursorMoved", {
            group = lsp_group,
            buffer = buffer,
            callback = function()
                vim.lsp.buf.clear_references()
            end,
        })
    end
end

return M
