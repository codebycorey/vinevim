return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
            -- Misc
            {
                "nvim-telescope/telescope.nvim",
            },
            { "b0o/SchemaStore.nvim" },
        },
        opts = {
            diagnostic = {
                virtual_text = true,
                update_in_insert = true,
                underline = true,
                severity_sort = true,
            },
        },
        config = function(_, opts)
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local nvim_capabilities = vim.lsp.protocol.make_client_capabilities()
            local capabilities = cmp_nvim_lsp.default_capabilities(nvim_capabilities)

            local installed_servers = require("mason-lspconfig").get_installed_servers()

            local on_attach = function(client, buffer)
                require("vinevim.plugins.lsp.keymaps").setup(client, buffer)
                require("vinevim.plugins.lsp.format").setup(client, buffer)
                require("vinevim.plugins.lsp.highlight").setup(client, buffer)
            end

            -- setup all servers installed
            for _, server_name in ipairs(installed_servers) do
                local lsp_options = require("vinevim.plugins.lsp.settings").get_server_settings(server_name)
                lsp_options.capabilities = capabilities
                lsp_options.on_attach = on_attach

                require("lspconfig")[server_name].setup(lsp_options)
            end

            vim.diagnostic.config(opts.diagnostic)
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", vim.cmd.Mason, desc = "Mason" } },
        opts = {
            ensure_installed = {
                "spellcheck",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },
    {
        {
            "williamboman/mason-lspconfig.nvim",
            dependencies = { "williamboman/mason.nvim" },
            opts = {
                ensure_installed = {
                    "sumneko_lua",
                    "jsonls",
                    "pyright",
                    "tsserver",
                    "rust_analyzer",
                    "gopls",
                    "bashls",
                    "svelte",
                    "marksman",
                },
                automatic_installation = true,
            },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        config = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local code_actions = null_ls.builtins.code_actions

            null_ls.setup({
                sources = {
                    code_actions.eslint,
                    formatting.prettier,
                    formatting.stylua,
                    formatting.eslint,
                    diagnostics.eslint,
                },
            })
        end,
    },
}
