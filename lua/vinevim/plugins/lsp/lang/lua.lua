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
        "williamboman/mason-lspconfig.nvim",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "lua_ls" })
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
                            workspace = {
                                checkThirdParty = false,
                            },
                            telemetry = { enabled = false },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                            },
                        },
                    },
                },
            },
        },
    },
}
