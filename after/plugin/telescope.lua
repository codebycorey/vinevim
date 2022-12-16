local tele_ok, telescope = pcall(require, "telescope")
if not tele_ok then
    print("Missing Telescope")
    return
end

local M = {}

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        prompt_prefix = " > ",
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

vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set("n", "<leader>pf", function()
    builtin.find_files({ hidden = true })
end)
vim.keymap.set("n", "<leader>pg", builtin.live_grep)
vim.keymap.set("n", "<leader>pb", builtin.buffers)
vim.keymap.set("n", "<leader>ph", builtin.help_tags)

-- vim.keymap.set("n", "<leader>gc", '<Cmd>lua require("vinevim.core.telescope").git_branches()<CR>')
-- vim.keymap.set("n", "<leader>so", '<Cmd>lua require("vinevim.core.telescope").reload_module()<CR>')

return M
