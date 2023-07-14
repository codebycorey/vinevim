return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
            end
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "pyright" })
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {
                    on_init = function(client)
                        local path = require("plenary.path")

                        local workspace = client.config.root_dir
                        local poetry_lock = path:new(workspace, "poetry.lock")
                        local pipfile = path:new(workspace, "Pipfile")
                        local python_path = nil

                        if poetry_lock:exists() then
                            python_path = path:new(vim.trim(vim.fn.system("poetry env info -p")), "bin", "python")
                                :absolute()
                        elseif vim.env.VIRTUAL_ENV then
                            python_path = path:new(vim.env.VIRTUAL_ENV, "bin", "python"):absolute()
                        elseif pipfile:exists() then
                            python_path = path
                                :new(
                                    vim.trim(vim.fn.system("PIPENV_PIPFILE=" .. pipfile.filename .. " pipenv --venv")),
                                    "bin",
                                    "python"
                                )
                                :absolute()
                        else
                            python_path = vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
                        end

                        client.config.settings.python.pythonPath = python_path
                    end,
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "workspace",
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },
                ruff_lsp = {},
            },
        },
    },
}
