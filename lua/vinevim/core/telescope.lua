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

local keymap = require("vinevim.utils.keymap")

keymap("n", "<C-p>", '<Cmd>lua require("telescope.builtin").git_files()<CR>')
keymap("n", "<leader>pf", '<Cmd>lua require("telescope.builtin").find_files()<CR>')
keymap("n", "<leader>pg", '<Cmd>lua require("telescope.builtin").live_grep()<CR>')
keymap("n", "<leader>pb", '<Cmd>lua require("telescope.builtin").buffers()<CR>')
keymap("n", "<leader>ph", '<Cmd>lua require("telescope.builtin").help_tags()<CR>')

keymap("n", "<leader>gc", '<Cmd>lua require("telescope.builtin").git_branches()<CR>')
