local M = {}

M.keys = {
    {
        "gd",
        function()
            require("telescope.builtin").lsp_definitions()
        end,
        desc = "[G]oto [D]efinition",
    },
    { "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
    {
        "gi",
        function()
            require("telescope.builtin").lsp_implementations()
        end,
        desc = "[G]oto [I]mplementation",
    },
    {
        "gr",
        function()
            require("telescope.builtin").lsp_references()
        end,
        desc = "[G]oto [R]eferences",
    },
    { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    {
        "<c-k>",
        vim.lsp.buf.signature_help,
        mode = "i",
        desc = "Signature Help",
        has = "signatureHelp",
    },

    { "gl", vim.diagnostic.open_float, desc = "Float diagnostic information" },
    {
        "<leader>bf",
        function()
            vim.lsp.buf.format({ async = true })
        end,
        desc = "[B]uffer [F]ormat",
    },
    {
        "<leader>li",
        function()
            vim.cmd("LspInfo")
        end,
        desc = "[I]nformation",
    },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "[C]ode [A]ction" },
    { "[d", vim.diagnostic.goto_prev, desc = "Goto previous [D]iagnostic" },
    { "]d", vim.diagnostic.goto_next, desc = "Goto next [D]iagnostic" },
    {
        "<leader>rn",
        function()
            return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        desc = "[R]ename",
    },
}

function M.setup(client, buffer)
    for _, keys in ipairs(M.keys) do
        if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
            local opts = {
                buffer = buffer,
                remap = false,
                silent = true,
                desc = "Lsp: " .. (keys.desc or ""),
            }

            vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
        end
    end
end

return M
