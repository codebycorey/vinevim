 local m = {}

 m.keymap = function (mode, lhs, rhs)
    local options = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
 return m;
