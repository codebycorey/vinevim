return {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    keys = {
        {
            "<leader>?",
            function()
                require("telescope.builtin").oldfiles()
            end,
            desc = "[?] Find recently opened files",
        },
        {
            "<leader>sp",
            function()
                require("telescope.builtin").git_files()
            end,
            desc = "[S]earch [G]it files",
        },
        {
            "<leader>sb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "[S]earch [B]uffers",
        },
        {
            "<leader>sf",
            function()
                require("telescope.builtin").find_files({ hidden = true })
            end,
            desc = "[S]earch [F]iles",
        },
        {
            "<leader>sg",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "[S]earch by [G]rep",
        },
        {
            "<leader>sb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "[S]earch [B]uffers",
        },
        {
            "<leader>sd",
            function()
                require("telescope.builtin").diagnostics()
            end,
            desc = "[S]earch [D]iagnostics",
        },

        {
            "<leader>/",
            function()
                require("telescope.builtin").current_buffer_fuzzy_find()
            end,
            desc = "[/] Fuzzy search current buffer",
        },
    },
    opts = {
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
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("fzf")
    end,
}

--
-- telescope.setup({
--     defaults = {
--         prompt_prefix = " > ",
--     },
--     extensions = {
--         fzf = {
--             fuzzy = true, -- false will only do exact matching
--             override_generic_sorter = true, -- override the generic sorter
--             override_file_sorter = true, -- override the file sorter
--             case_mode = "smart_case", -- or "ignore_case" or "respect_case"
--         },
--     },
-- })
--
-- telescope.load_extension("fzf")
--
-- M.reload_module = function()
--     local lua_dirs = vim.fn.glob("./lua/**/*", 0, 1)
--     for _, dir in ipairs(lua_dirs) do
--         dir = string.gsub(dir, "./lua/", "")
--         dir = dir:gsub("%.lua", "")
--         dir = dir:gsub("%/", ".")
--         dir = dir:gsub("%.init", "")
--         pcall(R, dir)
--     end
-- end
--
-- M.git_branches = function()
--     require("telescope.builtin").git_branches({
--         attach_mappings = function(_, map)
--             map("i", "<c-d>", actions.git_delete_branch)
--             map("n", "<c-d>", actions.git_delete_branch)
--             return true
--         end,
--     })
-- end
--
--
-- -- vim.keymap.set("n", "<leader>gc", '<Cmd>lua require("vinevim.core.telescope").git_branches()<CR>')
-- -- vim.keymap.set("n", "<leader>so", '<Cmd>lua require("vinevim.core.telescope").reload_module()<CR>')
--
-- return M
--
