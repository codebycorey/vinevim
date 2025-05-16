return {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
        {
            "<leader>sg",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "[S]earch by [G]rep",
        },
        {
            "<leader>sf",
            function()
                require("fzf-lua").files()
            end,
            desc = "[S]earch [F]iles",
        },
        {
            "<leader>sp",
            function()
                require("fzf-lua").git_files()
            end,
            desc = "[S]earch Git [P]roject files",
        },
        {
            "<leader>sb",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "[S]earch [B]uffers",
        },
        {
            "<leader>sd",
            function()
                require("fzf-lua").diagnostics()
            end,
            desc = "[S]earch [D]iagnostics",
        },
        {
            "<leader>/",
            function()
                require("fzf-lua").blines()
            end,
            desc = "[/] Fuzzy search current buffer",
        },
        {
            "<leader>,",
            function()
                require("fzf-lua").resume()
            end,
        },
    },
    opts = {
        { "default-prompt" },
        fzf_colors = true,
        winopts = {
            border = "none",
            width = 0.8,
            height = 0.8,
            row = 0.5,
            col = 0.5,
            preview = {
                border = "none",
            },
        },
    },
    config = function(_, opts)
        -- calling `setup` is optional for customization
        local fzf_lua = require("fzf-lua")
        fzf_lua.setup(opts)
        fzf_lua.register_ui_select()
    end,
}
