local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- local horticoder_group = augroup("horticoder", {})
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})
