return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        opts = {
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = {
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
        },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                pattern = { "*.mdx" },
                callback = function()
                    local buf = vim.api.nvim_get_current_buf()
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
    -- Automatically add closing tags for HTML and JSX
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
}
