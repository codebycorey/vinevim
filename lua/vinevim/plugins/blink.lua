return {
    {
        "saghen/blink.cmp",
        version = "1.*",
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
                accept = {
                    dot_repeat = false,
                },
                list = {
                    selection = { auto_insert = true, preselect = false },
                },
                documentation = { auto_show = true },
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
                per_filetype = {
                    codecompanion = { "codecompanion" },
                },
            },
            enabled = function()
                return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
            end,
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
}
