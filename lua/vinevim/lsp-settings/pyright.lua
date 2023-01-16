local util = require("lspconfig/util")

local path = util.path

local function get_python_path(workspace)
    -- Find and use virtualenv via poetry in workspace directory.
    local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
    if match ~= "" then
        local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
        return path.join(venv, "bin", "python")
    end

    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Find and use virtualenv from pipenv in workspace directory.
    local match = vim.fn.glob(path.join(workspace, "Pipfile"))
    if match ~= "" then
        local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
        return path.join(venv, "bin", "python")
    end

    -- Fallback to system Python.
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
end

local settings = {
    python = {
        analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
        },
    },
}

return {
    on_init = on_init,
    settings = settings,
}
