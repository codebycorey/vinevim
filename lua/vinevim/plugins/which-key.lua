return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { prefix = "<leader>" },
    config = function(_, opts)
        local which_key = require("which-key")
        which_key.setup(opts)
        which_key.register({
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
        })
    end,
}
