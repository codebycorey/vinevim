local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local lsp_group = augroup("Lsp", {})

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        event = "VeryLazy",
        dependencies = {
            -- LSP
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- CMP
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
            {
                "nvim-telescope/telescope.nvim",
            },
            { "b0o/SchemaStore.nvim" },
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")

            -- List of language servers to be installed and configured
            local language_servers = {
                "sumneko_lua",
                "tsserver",
                "jsonls",
                "rust_analyzer",
                "gopls",
                "pyright",
                "bashls",
                "svelte",
                "marksman",
            }
            lsp.ensure_installed(language_servers)

            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_replace = { behavior = cmp.SelectBehavior.Replace, select = false }
            local cmp_mappings = {
                ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
                ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-y>"] = cmp.mapping.confirm(cmp_replace),
                ["<CR>"] = cmp.mapping.confirm(cmp_replace),
            }

            lsp.setup_nvim_cmp({
                mapping = cmp_mappings,
            })

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
                lsp_keymap_set("<leader>lI", function()
                    vim.cmd("LspInstallInfo")
                end, { desc = "[I]nstall information" })
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

            lsp.on_attach(on_attach)

            for _, lsp_name in ipairs(language_servers) do
                pcall(function()
                    local lsp_config = require("vinevim.lsp-configs." .. lsp_name)
                    lsp.configure(lsp_name, lsp_config)
                end)
            end

            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = "E",
                    warn = "W",
                    hint = "H",
                    info = "I",
                },
            })

            lsp.setup()

            -- Must be after lsp.setup()
            vim.diagnostic.config({
                virtual_text = true,
                update_in_insert = true,
                underline = true,
                severity_sort = true,
            })

            local setup_highlighting = function(client) end
        end,
    },
}
