local tele_ok, telescope = pcall(require, "telescope")
if not tele_ok then
    print("Missing Telescope")
    return
end

local M = {}

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        prompt_prefix = " > ",
        color_devicons = true,
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
    },
})

telescope.load_extension("fzf")

M.reload_module = function()
    local lua_dirs = vim.fn.glob("./lua/**/*", 0, 1)
    for _, dir in ipairs(lua_dirs) do
        dir = string.gsub(dir, "./lua/", "")
        dir = dir:gsub("%.lua", "")
        dir = dir:gsub("%/", ".")
        dir = dir:gsub("%.init", "")
        pcall(R, dir)
    end
end

M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "<c-d>", actions.git_delete_branch)
            return true
        end,
    })
end

vim.keymap.set("n", "<C-p>", '<Cmd>lua require("telescope.builtin").git_files()<CR>')
vim.keymap.set("n", "<leader>pf", '<Cmd>lua require("telescope.builtin").find_files({ hidden = true })<CR>')
vim.keymap.set("n", "<leader>pg", '<Cmd>lua require("telescope.builtin").live_grep()<CR>')
vim.keymap.set("n", "<leader>pb", '<Cmd>lua require("telescope.builtin").buffers()<CR>')
vim.keymap.set("n", "<leader>ph", '<Cmd>lua require("telescope.builtin").help_tags()<CR>')

vim.keymap.set("n", "<leader>gc", '<Cmd>lua require("vinevim.core.telescope").git_branches()<CR>')
vim.keymap.set("n", "<leader>so", '<Cmd>lua require("vinevim.core.telescope").reload_module()<CR>')

return M
