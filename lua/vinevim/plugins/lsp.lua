local utils = require("vinevim.utils")

---@class LspOpts
---@field servers string[] List of LSP servers to enable
---@field diagnostic vim.diagnostic.Opts Configuration for diagnostics
---@field keys KeyMapping[] List of key mappings for LSP actions

---@type LazySpec
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "b0o/SchemaStore.nvim" },
            { "saghen/blink.cmp" },
            { "folke/neodev.nvim" },
            { "williamboman/mason.nvim" },
            { "ibhagwan/fzf-lua" },
        },
        ---@return LspOpts
        opts = function()
            local fzf = require("fzf-lua")

            local lsp_rename = function()
                local inc_rename = require("inc_rename")
                return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
            end

            local servers = vim.tbl_map(function(path)
                return vim.fs.basename(path):gsub("%.lua$", "")
            end, vim.fn.glob(vim.fn.stdpath("config") .. "/lsp/*.lua", false, true))

            ---@type LspOpts
            return {
                servers = servers,
                diagnostic = {
                    -- virtual_text = { current_line = true, severity = { min = "INFO", max = "WARN" } },
                    -- virtual_lines = { current_line = true, severity = { min = "ERROR" } },
                    virtual_text = false,
                    virtual_lines = { current_line = true },
                    update_in_insert = true,
                    underline = true,
                    severity_sort = true,
                },
                keys = {
                    { "gd", fzf.lsp_definitions, desc = "[G]oto [D]efinition" },
                    { "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
                    { "gi", fzf.lsp_implementations, desc = "[G]oto [I]mplementation" },
                    { "gy", fzf.lsp_typedefs, desc = "[G]oto T[y]pe Definition" },
                    { "gr", fzf.lsp_references, desc = "[G]oto [R]eferences" },
                    { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
                    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
                    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
                    { "gl", vim.diagnostic.open_float, desc = "Float diagnostic information" },
                    { "<leader>ca", vim.lsp.buf.code_action, desc = "[C]ode [A]ction" },
                    { "[d", vim.diagnostic.goto_prev, desc = "Goto previous [D]iagnostic" },
                    { "]d", vim.diagnostic.goto_next, desc = "Goto next [D]iagnostic" },
                    { "<leader>rn", lsp_rename, desc = "[R]ename", expr = true, has = "rename" },
                },
            }
        end,
        ---@param opts LspOpts
        config = function(_, opts)
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            vim.lsp.enable(opts.servers)
            vim.diagnostic.config(opts.diagnostic)

            vim.api.nvim_create_autocmd({ "LspAttach" }, {
                group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client or not args.buf then
                        return
                    end
                    utils.set_lsp_keymap(client, args.buf, opts.keys)
                end,
            })
        end,
    },
}
