local M = {}

local setup_diagnostics = function()
    local icons = require("vinevim.theme.icons")
    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
end

local setup_handlers = function()
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local get_capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
    end
    return capabilities
end

local setup_keymaps = function(bufnr)
    local options = { buffer=bufnr, remap = false, silent = true }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, options)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, options)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, options)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, options)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, options)
    vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, options)
    vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, options)

    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, options)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, options)

    vim.keymap.set("n", "vd", function() vim.diagnostics.open_float() end, options)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, options)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, options)
    vim.keymap.set("n", "gl", function() vim.lsp.diagnostic.show_line_diagnostics() end, options)
end

local disable_formatting = function(client)
    -- TODO: Make this easier to maintain
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    if client.name == "sumneko_lua" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
end

-- local setup_highlighting = function(client)
--     -- TODO: Look into illuminate as alternative
--     -- TODO: Or use lua to create autocmd
--     if client.resolved_capabilities.document_highlight then
--         vim.api.nvim_exec(
--             [[
--               augroup lsp_document_highlight
--                 autocmd! * <buffer>
--                 autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--                 autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--               augroup END
--             ]],
--             false
--         )
--     end
-- end

-- on_attach to LSP server
local on_attach = function(client, bufnr)
    setup_keymaps(bufnr)
    disable_formatting(client)
    -- setup_highlighting(client)
end

local extend_config = function(server, base_config)
    local server_config_module = "vinevim.lsp.configs." .. server

    local ok, server_config = pcall(require, server_config_module)
    if ok then
        return vim.tbl_deep_extend("force", base_config, server_config)
    end

    return base_config
end

local get_config = function(server)
    local base_config = {
        on_attach = on_attach,
        capabilities = get_capabilities(),
    }
    return extend_config(server, base_config)
end

local configure_lsp = function(servers)
    local lspconfig = require("lspconfig")

    -- Loop through list of servers
    for _, server in ipairs(servers) do
        local config = get_config(server)
        lspconfig[server].setup(config)
    end
end

M.setup = function(servers)
    setup_diagnostics()
    setup_handlers()
    configure_lsp(servers)
end

return M
