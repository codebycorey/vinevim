local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end

local kind_ok, lspkind = pcall(require, 'lspkind')
if not kind_ok then
  return
end

local snip_ok, luasnip = pcall(require, 'luasnip')
if not snip_ok then
  return
end

local tn_ok, tabnine = pcall(require, 'cmp_tabnine.config')
if not tn_ok then
  return
end

require('luasnip/loaders/from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expend = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mappings = {
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
    })
  },
  sources = {
    { name = 'cmp_tabnine' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer'},
    { name = 'path' }
  },
  documentation = true,
})

tabnine:setup({
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = '..'
})

