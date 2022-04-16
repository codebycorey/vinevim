local tele_ok, telescope = pcall(require, "telescope")
if not tele_ok then
    print("Missing Telescope")
    return
end

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

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>f", '<Cmd>lua require("telescope.builtin").find_files()<CR>', opts)
keymap("n", "<leader>g", '<Cmd>lua require("telescope.builtin").live_grep()<CR>', opts)
keymap("n", "<leader>b", '<Cmd>lua require("telescope.builtin").buffers()<CR>', opts)
keymap("n", "<leader>h", '<Cmd>lua require("telescope.builtin").help_tags()<CR>', opts)

keymap("n", "<leader>gc", '<Cmd>lua require("telescope.builtin").git_branches()<CR>', opts)
