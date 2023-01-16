return {
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPost",
        build = ":TSUpdate",
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlight = true,
            },
            indent = {
                enable = true,
            },
            autopairs = {
                enable = true,
            },
            sync_install = false,
            playground = {
                enable = true,
            },
            ensure_installed = "all",
            ignore_install = {},
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
