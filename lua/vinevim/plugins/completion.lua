return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
                "<S-Tab>",
                mode = { "i", "s" },
                function()
                    if require("luasnip").jumpable(-1) then
                        require("luasnip").jump(-1)
                    end
                end,
                silent = true,
            },
            --Next snippet region
            -- {
            --     "<Tab>",
            --     mode = { "i", "s" },
            --     function()
            --         if require("luasnip").jumpable(1) then
            --             require("luasnip").jump(1)
            --         else
            --             return "<tab>"
            --         end
            --     end,
            --     silent = true,
            -- },
            {
                "<tab>",
                mode = { "i", "s" },
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
            },
        },
    },
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
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
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
