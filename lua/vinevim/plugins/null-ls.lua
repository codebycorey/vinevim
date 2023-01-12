return {
    "jose-elias-alvarez/null-ls.nvim",
       event= "VeryLazy", 
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local code_actions = null_ls.builtins.code_actions

        null_ls.setup({
            sources = {
                code_actions.eslint,
                formatting.prettier,
                formatting.stylua,
                formatting.eslint,
                diagnostics.eslint,
            },
        })
    end,
}
