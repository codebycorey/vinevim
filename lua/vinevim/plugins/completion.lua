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
            -- {
            --     "<S-Tab>",
            --     mode = { "i", "s" },
            --     function()
            --         if require("luasnip").jumpable(-1) then
            --             require("luasnip").jump(-1)
            --         end
            --     end,
            --     silent = true,
            -- },
            -- {
            --     "<Tab>",
            --     mode = "i",
            --     function()
            --         if require("luasnip").jumpable(1) then
            --             require("luasnip").jump(1)
            --         else
            --             return "<tab>"
            --         end
            --     end,
            --     expr = true,
            --     silent = true,
            -- },
            -- {
            --     "<tab>",
            --     mode = "s",
            --     function()
            --         return require("luasnip").jump(1)
            --     end,
            --     silent = true,
            -- },
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
            { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
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
                    { name = "lazydev" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = function(entry, item)
                        item.menu = source_map[entry.source.name]
                        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
                    end,
                },
            }
            cmp.setup(options)
        end,
    },
    {
        "github/copilot.vim",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        lazy = false,
    },
}
