---@source "https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua"
---@class MasonLspMap
local masonLspMap = {
    ["bashls"] = "bash-language-server",
    ["cssls"] = "css-lsp",
    ["eslint"] = "eslint-lsp",
    ["html"] = "html-lsp",
    ["jsonls"] = "json-lsp",
    ["lua_ls"] = "lua-language-server",
    ["marksman"] = "marksman",
    ["pyright"] = "pyright",
    ["tailwindcss"] = "tailwindcss-language-server",
    ["ts_ls"] = "typescript-language-server",
    ["vtsls"] = "vtsls",
}

return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", vim.cmd.Mason, desc = "Mason" } },
        opts = function()
            local lsp_servers = require("vinevim.utils").get_lsp_servers()
            local lsp = vim.tbl_map(function(server)
                if masonLspMap[server] then
                    return masonLspMap[server]
                end
            end, lsp_servers)

            local dap = {
                "js-debug-adapter",
            }

            local linters = {
                "eslint_d",
                "cspell",
            }

            local formatters = {
                "prettierd",
                "stylua",
            }

            local install = vim.iter({ lsp, dap, linters, formatters }):flatten():totable()
            return {
                install = install,
            }
        end,
        ---@param opts MasonSettings | {install: string[]}
        config = function(_, opts)
            require("mason").setup()
            local registry = require("mason-registry")
            registry.refresh(function()
                for _, pkg_name in ipairs(opts.install) do
                    local pkg = registry.get_package(pkg_name)
                    if not pkg:is_installed() then
                        pkg:install()
                    end
                end
            end)
        end,
    },
}
