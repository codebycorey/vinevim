local M = {}

function M.setup(client, buffer)
    -- Set keymap for buffer
    local set = function(lhs, rhs, opts)
        local lsp_set_opts = { buffer = buffer, remap = false, silent = true }
        local desc_opts = { desc = "Lsp: " .. (opts.desc or "") }
        local options = vim.tbl_deep_extend("force", lsp_set_opts, opts, desc_opts)
        local mode = opts.has or "n"

        vim.keymap.set(mode, lhs, rhs, options)
    end

    local telescope = require("telescope.builtin")
    set("gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
    set("gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
    set("gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
    set("gr", function()
        telescope.lsp_references()
    end, { desc = "[G]oto [R]eferences" })
    set("K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
    set("gl", vim.diagnostic.open_float, { desc = "Float diagnostic information" })
    set("<leader>bf", function()
        vim.lsp.buf.format({ async = true })
    end, { desc = "[B]uffer [F]ormat" })
    set("<leader>li", function()
        vim.cmd("LspInfo")
    end, { desc = "[I]nformation" })
    set("<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
    set("[d", vim.diagnostic.goto_prev, { desc = "Goto previous [D]iagnostic" })
    set("]d", vim.diagnostic.goto_next, { desc = "Goto next [D]iagnostic" })
end

return M
