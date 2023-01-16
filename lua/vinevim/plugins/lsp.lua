local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local lsp_group = augroup("Lsp", {})

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
        config = function()
            -- List of language servers to be installed and configured
            local opts = {
                ensure_installed = {
                    sumneko_lua = require("vinevim.lsp-settings.sumneko_lua"),
                    tsserver = {},
                    jsonls = require("vinevim.lsp-settings.jsonls"),
                    rust_analyzer = {},
                    gopls = {},
                    pyright = require("vinevim.lsp-settings.pyright"),
                    bashls = {},
                    svelte = {},
                    marksman = {},
                },
                automatic_installation = true,
            }

            local on_attach = function(client, bufnr)
                local lsp_keymap_set = function(lhs, rhs, override_opts)
                    local lsp_set_opts = { buffer = bufnr, remap = false, silent = true }
                    local desc_opts = { desc = "Lsp: " .. (override_opts.desc or "") }
                    local options = vim.tbl_deep_extend("force", lsp_set_opts, override_opts, desc_opts)
                    vim.keymap.set("n", lhs, rhs, options)
                end

                local telescope = require("telescope.builtin")
                lsp_keymap_set("gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
                lsp_keymap_set("gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
                lsp_keymap_set("gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
                lsp_keymap_set("gr", function()
                    telescope.lsp_references()
                end, { desc = "[G]oto [R]eferences" })
                lsp_keymap_set("K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
                lsp_keymap_set("gl", vim.diagnostic.open_float, { desc = "Float diagnostic information" })
                lsp_keymap_set("<leader>bf", function()
                    vim.lsp.buf.format({ async = true })
                end, { desc = "[B]uffer [F]ormat" })
                lsp_keymap_set("<leader>li", function()
                    vim.cmd("LspInfo")
                end, { desc = "[I]nformation" })
                lsp_keymap_set("<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
                lsp_keymap_set("[d", vim.diagnostic.goto_prev, { desc = "Goto previous [D]iagnostic" })
                lsp_keymap_set("]d", vim.diagnostic.goto_next, { desc = "Goto next [D]iagnostic" })

                -- Disable formatting
                if client.name == "tsserver" then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end

                if client.name == "sumneko_lua" then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end

                if client.resolved_capabilities.document_highlight then
                    autocmd({ "CursorHold", "CursorHoldI" }, {
                        group = lsp_group,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.document_highlight()
                        end,
                    })
                    autocmd("CursorMoved", {
                        group = lsp_group,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.clear_references()
                        end,
                    })
                end
            end

            local nvim_capabilities = vim.lsp.protocol.make_client_capabilities()
            local capabilities = require("cmp_nvim_lsp").default_capabilities(nvim_capabilities)

            require("mason-lspconfig").setup(opts)

            local get_servers = require("mason-lspconfig").get_installed_servers

            for _, server_name in ipairs(get_servers()) do
                local lsp_options = opts.ensure_installed[server_name] or {}
                lsp_options.capabilities = capabilities
                lsp_options.on_attach = on_attach
                require("lspconfig")[server_name].setup(lsp_options)
            end

            vim.diagnostic.config({
                virtual_text = true,
                update_in_insert = true,
                underline = true,
                severity_sort = true,
            })
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
}
