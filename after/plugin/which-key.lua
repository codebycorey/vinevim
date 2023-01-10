local ok, which_key = pcall(require, "which-key")
if not ok then
    return
end
print("hello")
local options = { prefix = "<leader>" }
local keymap_config = {
    mode = { "n", "v" },
    ["g"] = { name = "+goto" },
    ["]"] = { name = "+next" },
    ["["] = { name = "+prev" },
    ["<leader>b"] = { name = "+buffer" },
    ["<leader>c"] = { name = "+code" },
    ["<leader>f"] = { name = "+file" },
    ["<leader>g"] = { name = "+git" },
    ["<leader>h"] = { name = "+help" },
    ["<leader>n"] = { name = "+noice" },
    ["<leader>o"] = { name = "+open" },
    ["<leader>q"] = { name = "+quit/session" },
    ["<leader>s"] = { name = "+search" },
    ["<leader>t"] = { name = "+toggle" },
    ["<leader>x"] = { name = "+diagnostics/quickfix" },
    ["<leader>w"] = { name = "+windows" },
    ["<leader><tab>"] = { name = "+tabs" },
}

which_key.register(keymap_config, options)
