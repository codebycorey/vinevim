local tree_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not tree_ok then
    return
end
-- ignore_install is only because m1 chip
treesitter.setup({
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
