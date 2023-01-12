
--vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
--    if luasnip.jumpable(-1) then luasnip.jump(-1) end
-- end, { silent = true })

-- Next snippet region
-- vim.keymap.set({ "i", "s" }, "<Tab>", function()
--    if luasnip.jumpable(1) then luasnip.jump(1) end
-- end, { silent = true })

-- -- Cycle "choices" for current snippet region
-- vim.keymap.set({ "i", "s" }, "<C-l>", function()
--     if ls.choice_active() then ls.change_choice(1) end
-- end)

return {
            "L3MON4D3/LuaSnip" ,
}
