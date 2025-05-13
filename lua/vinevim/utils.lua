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

---@return string[] List of LSP server names (excluding disabled ones)
function M.get_lsp_servers()
    local servers = {}
    local lsp_path = vim.fn.stdpath("config") .. "/lsp/"
    local lsp_files = vim.fn.globpath(lsp_path, "*.lua", false, true)

    for _, file in ipairs(lsp_files) do
        -- Use pcall to safely read the first line
        local ok, first_line = pcall(function()
            return vim.fn.readfile(file, "", 1)[1] or ""
        end)

        -- Only process if we could read the file
        if ok and not first_line:match("^%-%- disable") then
            local server_name = vim.fs.basename(file):gsub("%.lua$", "")
            table.insert(servers, server_name)
        end
    end

    return servers
end

---@param version string The minimum required version to check against (e.g., "0.11")
---@return boolean Whether the current Neovim version meets the requirement
function M.version_check(version)
    local current = vim.version()

    -- Parse the required version string
    local parts = vim.split(version, ".", { plain = true })
    local req_major = tonumber(parts[1]) or 0
    local req_minor = tonumber(parts[2]) or 0

    -- Compare major version first
    if current.major > req_major then
        return true
    elseif current.major < req_major then
        return false
    end

    -- If major versions are equal, compare minor versions
    return current.minor >= req_minor
end

return M
