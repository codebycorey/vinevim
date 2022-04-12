local tree_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not tree_ok then
  return
end

treesitter.setup({
  highlight = {
    enable = true,
    disable = {},
  },
  index = {
    enable = true,
    disable = {},
  },
  autopairs = {
    enable = true
  },
  sync_install = false,
  playground = {
    enable = true
  },
  ensure_installed = true,
  ignore_installed = { 'phpdoc' }
})

