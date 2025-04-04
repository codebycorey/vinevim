---@class KeyMapping
---@field [1] string The keybinding
---@field [2] function The command to execute
---@field desc string Description of the keybinding
---@field mode? string|string[] Optional mode for the mapping (e.g., "i" for insert mode)
---@field expr? boolean Optional flag to indicate if it's an expression mapping
---@field has? string Optional capability requirement

local M = {}

---@param client vim.lsp.Client The LSP client
---@param bufnr number The buffer number
---@param keys KeyMapping[] The key mappings to set
function M.set_lsp_keymap(client, bufnr, keys)
    for _, key in ipairs(keys) do
        if not key.has or client.server_capabilities[key.has .. "Provider"] then
            local opts = {
                buffer = bufnr,
                remap = false,
                silent = true,
                desc = "Lsp: " .. (key.desc or ""),
                expr = key.expr or nil,
            }
            vim.keymap.set(key.mode or "n", key[1], key[2], opts)
        end
    end
end

return M
