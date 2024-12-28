return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "saghen/blink.cmp" },

            { "williamboman/mason-lspconfig" },

            -- Misc
            {
                "nvim-telescope/telescope.nvim",
            },
            { "b0o/SchemaStore.nvim" },
            { "folke/neodev.nvim" },
        },
        --@class PluginLspOpts
        opts = {
            diagnostic = {
                virtual_text = true,
                update_in_insert = true,
                underline = true,
                severity_sort = true,
            },
            servers = {
                rust_analyzer = {},
                gopls = {},
                bashls = {},
                marksman = {},
                cssls = {},
                tailwindcss = {},
                mdx_analyzer = {},
                -- sqls = {},
            },
        },
        --@param opts PluginLspOpts
        config = function(_, opts)
            local blink_cmp = require("blink.cmp")
            local capabilities = blink_cmp.get_lsp_capabilities()

            local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

            --@param server string
            local setup = function(server)
                local lsp_options = opts.servers[server] or {}
                lsp_options.capabilities = capabilities
                lsp_options.on_attach = function(client, buffer)
                    require("vinevim.plugins.lsp.keymaps").setup(client, buffer)
                end

                require("lspconfig")[server].setup(lsp_options)
            end

            local ensure_installed = {} -- @type string[]
            for server in pairs(opts.servers) do
                if not vim.tbl_contains(all_mslp_servers, server) then
                    setup(server)
                else
                    ensure_installed[#ensure_installed + 1] = server
                end
            end

            require("mason-lspconfig").setup({ ensure_installed = ensure_installed, handlers = { setup } })

            vim.diagnostic.config(opts.diagnostic)
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
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                -- { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
}
