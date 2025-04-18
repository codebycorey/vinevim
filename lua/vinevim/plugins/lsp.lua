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

            local servers = vim.iter(ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)))
                :map(function(_, filepath)
                    local name = vim.fs.basename(filepath):gsub("%.lua$", "")
                    return name ~= "*" and name or nil
                end)
                :totable()

            ---@type LspOpts
            return {
                servers = servers,
                diagnostic = {
                    virtual_text = true,
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
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        cmd = "LazyDev",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "LazyVim", words = { "LazyVim" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        },
    },
}
