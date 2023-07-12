return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "lua" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            {
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                            },
                            telemetry = { enabled = false },
                        },
                    },
                },
            },
        },
    },
}
