---@type vim.lsp.Config
return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    single_file_support = true,
    on_init = function(client)
        local path = require("plenary.path")

        local workspace = client.config.root_dir
        local poetry_lock = path:new(workspace, "poetry.lock")
        local pipfile = path:new(workspace, "Pipfile")
        local python_path = nil

        if poetry_lock:exists() then
            python_path = path:new(vim.trim(vim.fn.system("poetry env info -p")), "bin", "python"):absolute()
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
        pyright = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
        },
    },
}
