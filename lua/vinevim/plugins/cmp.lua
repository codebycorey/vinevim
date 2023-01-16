return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
        },
        config = function()
            local cmp = require("cmp")
            local select = { behavior = cmp.SelectBehavior.Select }
            local replace = { behavior = cmp.SelectBehavior.Replace, select = false }
            local mappings = {
                ["<Down>"] = cmp.mapping.select_next_item(select),
                ["<Up>"] = cmp.mapping.select_prev_item(select),
                ["<C-p>"] = cmp.mapping.select_prev_item(select),
                ["<C-n>"] = cmp.mapping.select_next_item(select),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-y>"] = cmp.mapping.confirm(replace),
                ["<CR>"] = cmp.mapping.confirm(replace),
            }
            local source_map = {
                cmp_tabnine = "[TN]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                buffer = "[Buffer]",
                path = "[Path]",
            }
            local options = {
                completion = {},
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = mappings,
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        -- vim_item.kind = symbol_map[vim_item.kind]
                        vim_item.menu = source_map[entry.source.name]
                        return vim_item
                    end,
                },
            }

            cmp.setup(options)
        end,
    },
}
