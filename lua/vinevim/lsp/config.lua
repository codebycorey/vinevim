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

local setup_capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
    end
    return capabilities
end

local setup_keymaps = function(bufnr)
    local options = { noremap = true, silent = true }
    local keymap = function(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
    end

    keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
    keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
    keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
    keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>")
    keymap("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
    keymap("n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>")
    keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>")
    keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
    keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
    keymap("n", "gl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
end

local setup_formatting = function(client)
    -- TODO: Make this easier to maintain
    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end

    if client.name == "sumneko_lua" then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end
end

local setup_highlighting = function(client)
    -- TODO: Look into illuminate as alternative
    -- TODO: Or use lua to create autocmd
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
              augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
              augroup END
            ]],
            false
        )
    end
end

M.setup = function()
    setup_diagnostics()
    setup_handlers()
end

-- on_attach to LSP server
M.on_attach = function(client, bufnr)
    setup_keymaps(bufnr)
    setup_formatting(client)
    setup_highlighting(client)
end

-- capabilities to LSP server
M.capabilities = setup_capabilities()

return M
