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
        {
            "<leader>,",
            function()
                require("telescope.builtin").resume()
            end,
        },
    },
    opts = {
        defaults = {
            prompt_prefix = " > ",
            selection_caret = "  ",
            sorting_strategy = "ascending",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            winblend = 0,
            border = {},
            color_devicons = true,
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
            },
        },
        pickers = {
            live_grep = {
                additional_args = { "--hidden" },
            },
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("fzf")
    end,
}
