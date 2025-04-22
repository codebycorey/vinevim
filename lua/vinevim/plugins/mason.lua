---@source "https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua"
---@class MasonLspMap
local masonLspMap = {
    ["bashls"] = "bash-language-server",
    ["cssls"] = "css-lsp",
    ["html"] = "html-lsp",
    ["jsonls"] = "json-lsp",
    ["lua_ls"] = "lua-language-server",
    ["marksman"] = "marksman",
    ["pyright"] = "pyright",
    ["tailwindcss"] = "tailwindcss-language-server",
    ["ts_ls"] = "typescript-language-server",
}

---@type LazySpec
return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", vim.cmd.Mason, desc = "Mason" } },
        opts = function()
            local lsp = vim.tbl_map(function(path)
                local name = vim.fs.basename(path):gsub("%.lua$", "")
                if masonLspMap[name] then
                    return masonLspMap[name]
                end
            end, vim.fn.glob(vim.fn.stdpath("config") .. "/lsp/*.lua", false, true))

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
