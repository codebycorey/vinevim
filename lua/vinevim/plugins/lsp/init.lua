---@type LazySpec
return {
    {
        "lsp",
        virtual = true,
        dependencies = {
            { "b0o/SchemaStore.nvim" },
            { "saghen/blink.cmp" },
            { "folke/neodev.nvim" },
            { "williamboman/mason.nvim" },
        },
        opts = function()
            local servers = vim.iter(ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)))
                :map(function(_, filepath)
                    local name = vim.fs.basename(filepath):gsub("%.lua$", "")
                    return name ~= "*" and name or nil
                end)
                :totable()

            return {
                servers = servers,
                diagnostic = {
                    virtual_text = true,
                    update_in_insert = true,
                    underline = true,
                    severity_sort = true,
                },
            }
        end,
        config = function(_, opts)
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            vim.lsp.enable(opts.servers)
            vim.diagnostic.config(opts.diagnostic)

            require("vinevim.plugins.lsp.keymaps").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", vim.cmd.Mason, desc = "Mason" } },
        opts = {
            ensure_installed = {
                "stylua",
                "prettierd",
                "eslint_d",
                "cspell",

                "js-debug-adapter",

                "pyright", -- Python LSP

                -- "lua_ls",
                -- "tsserver", "svelte"
                -- jsonls
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local registry = require("mason-registry")
            registry.refresh(function()
                for _, pkg_name in ipairs(opts.ensure_installed) do
                    local pkg = registry.get_package(pkg_name)
                    if not pkg:is_installed() then
                        pkg:install()
                    end
                end
            end)
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
