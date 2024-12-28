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
        keys = {},
    },
    {
        "saghen/blink.cmp",
        build = "cargo build --release",
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets",
            {
                "saghen/blink.compat",
                opts = {},
            },
        },

        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            completion = {
                list = {
                    selection = "auto_insert",
                },
            },
            sources = {
                default = { "lazydev", "lsp", "path", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            keymap = {
                preset = "enter",
                ["<C-y>"] = { "select_and_accept" },
                ["Up"] = { "select_prev" },
                ["Down"] = { "select_next" },
                ["<C-p>"] = { "select_prev" },
                ["<C-n>"] = { "select_next" },
            },
        },
        opts_extend = {
            "sources.completion.enable_providers",
            "sources.compact",
            "sources.default",
        },
        config = function(_, opts)
            require("blink.cmp").setup(opts)
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
