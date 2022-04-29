vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    nested = true,
    callback = function()
        -- if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif,
        print("test")
        end
})

-- vim.api.nvim_create_autocmd({"TextYankPost"}, {
--   callback = function() vim.highlight.on_yank({higroup = 'Visual', timeout = 200}) end,  -- Or myvimfun
-- })
