local lsp_ok, lsp = pcall(require, "lsp-zero")
if not lsp_ok then
    return
end

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

local schemas_ok, schemastore = pcall(require, "schemastore")
if not schemas_ok then
    return {}
end

print("Hello World")

lsp.preset("recommended")

-- List of language servers to be installed and configured
local language_servers = {
    "sumneko_lua",
    "tsserver",
    "jsonls",
    "rust_analyzer",
    "gopls",
    "pyright",
    "bashls",
    "svelte",
    "marksman",
}

lsp.ensure_installed(language_servers)

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_replace = { behavior = cmp.SelectBehavior.Replace, select = false }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
    ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-y>"] = cmp.mapping.confirm(cmp_replace),
    ["<CR>"] = cmp.mapping.confirm(cmp_replace),
    ["<Tab>"] = nil,
    ["<S-Tab>"] = nil,
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
})

local on_attach = function(client, bufnr)
    local options = { buffer = bufnr, remap = false, silent = true }
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, options)
    vim.keymap.set("n", "gD", function()
        vim.lsp.buf.declaration()
    end, options)
    vim.keymap.set("n", "gi", function()
        vim.lsp.buf.implementation()
    end, options)
    vim.keymap.set("n", "gr", function()
        vim.lsp.buf.references()
    end, options)
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, options)
    vim.keymap.set("n", "<C-k>", function()
        vim.lsp.buf.signature_help()
    end, options)
    vim.keymap.set("i", "<C-k>", function()
        vim.lsp.buf.signature_help()
    end, options)

    vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end, options)
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
    end, options)

    vim.keymap.set("n", "vd", function()
        vim.diagnostics.open_float()
    end, options)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev()
    end, options)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next()
    end, options)
    vim.keymap.set("n", "gl", function()
        vim.lsp.diagnostic.show_line_diagnostics()
    end, options)

    -- Disable formatting
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end

    if client.name == "sumneko_lua" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
end

lsp.on_attach(on_attach)

lsp.configure("sumneko_lua", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "require" },
            },
            -- workspace = { library = vim.api.nvim_get_runtime("", true)},
            telemetry = { enabled = false },
        },
    },
})

lsp.configure("jsonls", {
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
        },
    },
})

local util = require("lspconfig/util")
local path = util.path

local function get_python_path(workspace)
    -- Find and use virtualenv via poetry in workspace directory.
    local lock_match = vim.fn.glob(path.join(workspace, "poetry.lock"))
    if lock_match ~= "" then
        local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
        return path.join(venv, "bin", "python")
    end

    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Find and use virtualenv from pipenv in workspace directory.
    local pip_match = vim.fn.glob(path.join(workspace, "Pipfile"))
    if pip_match ~= "" then
        local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. pip_match .. " pipenv --venv"))
        return path.join(venv, "bin", "python")
    end

    -- Fallback to system Python.
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
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

lsp.configure("pyright", {
    on_init = function(client)
        client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
    end,
    settings = settings,
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    },
})

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    underline = true,
})

lsp.setup()
