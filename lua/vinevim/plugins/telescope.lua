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
            function ()
                require("telescope.builtin").resume()
            end
        }
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
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
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

        local palette = require("vinevim.theme")

        local TelescopeColor = {
            TelescopeMatching = { fg = palette.oniViolet },
            TelescopeSelection = { bg = palette.sumiInk2 },

            TelescopeResultsNormal = { bg = palette.sumiInk0 },
            TelescopeResultsTitle = { bg = palette.sumiInk0, fg = palette.sumiInk0 },

            TelescopePromptBorder = { bg = palette.sumiInk2, fg = palette.sumiInk2 },
            TelescopePromptNormal = { bg = palette.sumiInk2 },
            TelescopePromptPrefix = { fg = palette.waveRed, bg = palette.sumiInk2 },
            TelescopePromptTitle = { bg = palette.waveRed, fg = palette.sumniInk0 },

            TelescopeResultsBorder = { bg = palette.sumiInk0, fg = palette.sumiInk0 },
            TelescopePreviewBorder = { bg = palette.sumiInk0, fg = palette.sumiInk0 },
            TelescopePreviewNormal = { bg = palette.sumiInk0 },
            TelescopePreviewTitle = { bg = palette.waveAqua2, fg = palette.sumniInk0 },
        }
        for hl, col in pairs(TelescopeColor) do
            vim.api.nvim_set_hl(0, hl, col)
        end
    end,
}
