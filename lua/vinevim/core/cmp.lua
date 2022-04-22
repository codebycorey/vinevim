local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

local snip_ok, luasnip = pcall(require, "luasnip")
if not snip_ok then
    return
end

local tn_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not tn_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local source_map = {
    cmp_tabnine = "[TN]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    buffer = "[Buffer]",
    path = "[Path]",
}

local symbol_map = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

vim.opt.completeopt = "menuone,noinsert,noselect,preview"
vim.opt.pumheight = 10

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {},
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = symbol_map[vim_item.kind]
            vim_item.menu = source_map[entry.source.name]
            return vim_item
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "cmp_tabnine" },
        { name = "luasnip" },
        { name = "path" },
    }, {
        { name = "buffer" },
    }),
    experimental = {
        ghost_text = true,
    },
})

tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
})
