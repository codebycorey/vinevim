return {
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- ignore_install is only because m1 chip
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlight = true,
                },
                index = {
                    enable = true,
                    disable = {},
                },
                autopairs = {
                    enable = true,
                },
                sync_install = false,
                playground = {
                    enable = true,
                },
                ensure_installed = "all",
                ignore_install = { "phpdoc", "swift" },
            })
        end,
    },
}
