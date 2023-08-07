return {
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        opts = {
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlight = false,
            },
            indent = {
                enable = true,
            },
            playground = {
                enable = true,
            },
            ensure_installed = {
                "bash",
                "html",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "vim",
                "vimdoc",
                "yaml",
            },
            ignore_install = {},
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            context_commentstring = {
                enable = true,
            },
        },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
}
