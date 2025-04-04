local M = {}

M.keys = {
    {
        "gd",
        function()
            require("fzf-lua").lsp_definitions()
        end,
        desc = "[G]oto [D]efinition",
    },
    { "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
    {
        "gi",
        function()
            require("fzf-lua").lsp_implemenations()
        end,
        desc = "[G]oto [I]mplementation",
    },
    {
        "gy",
        function()
            require("fzf-lua").lsp_typedefs()
        end,
        desc = "[G]oto T[y]pe Definition",
    },
    {
        "gr",
        function()
            require("fzf-lua").lsp_references()
        end,
        desc = "[G]oto [R]eferences",
    },
    { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    { "gl", vim.diagnostic.open_float, desc = "Float diagnostic information" },
    -- {
    --     "<leader>bf",
    --     function()
    --         require("vinevim.plugins.lsp.format").format({ notify = true })
    --     end,
    --     desc = "[B]uffer [F]ormat",
    -- },
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
            local inc_rename = require("inc_rename")
            return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        desc = "[R]ename",
        expr = true,
        has = "rename",
    },
}

function M.set_keys(client, buffer)
    for _, keys in ipairs(M.keys) do
        if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
            local opts = {
                buffer = buffer,
                remap = false,
                silent = true,
                desc = "Lsp: " .. (keys.desc or ""),
                expr = keys.expr or nil,
            }
            vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
        end
    end
end

function M.setup()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then
                return
            end
            M.set_keys(client, args.buf)
        end,
    })
end

return M
