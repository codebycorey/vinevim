local lsp_ok, lsp = pcall(require, "lsp-zero")
if not lsp_ok then
    return
end

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

local ts_ok = pcall(require, "telescope")
if not ts_ok then
    return
end

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

local telescope = require("telescope.builtin")
local lsp_keymaps = {
    { lhs = "gd", rhs = vim.lsp.buf.definition, desc = "[G]oto [D]efinition" },
    { lhs = "gD", rhs = vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
    { lhs = "gi", rhs = vim.lsp.buf.implementation, desc = "[G]oto [I]mplementation" },
    {
        lhs = "gr",
        rhs = function()
            telescope.lsp_references()
        end,
        desc = "[G]oto [R]eferences",
    },
    { lhs = "K", rhs = vim.lsp.buf.hover, desc = "Hover Documentation" },
    { lhs = "gl", rhs = vim.diagnostic.open_float, desc = "Float diagnostic information" },
    {
        lhs = "<leader>bf",
        rhs = function()
            vim.lsp.buf.format({ async = true })
        end,
        desc = "[B]uffer [F]ormat",
    },
    {
        lhs = "<leader>li",
        rhs = function()
            vim.cmd("LspInfo")
        end,
        desc = "[I]nformation",
    },
    {
        lhs = "<leader>lI",
        rhs = function()
            vim.cmd("LspInstallInfo")
        end,
        desc = "[I]nstall information",
    },
    { lhs = "<leader>ca", rhs = vim.lsp.buf.code_action, desc = "[C]ode [A]ction" },
    { lhs = "[d", rhs = vim.diagnostic.goto_prev, desc = "Goto previous [D]iagnostic" },
    { lhs = "]d", rhs = vim.diagnostic.goto_next, desc = "Goto next [D]iagnostic" },
}

local on_attach = function(client, bufnr)
    local lsp_keymap_set = function(lhs, rhs, desc)
        local options = { buffer = bufnr, remap = false, silent = true, desc = "Lsp: " .. desc }
        vim.keymap.set("n", lhs, rhs, options)
    end

    for _, keymap in ipairs(lsp_keymaps) do
        lsp_keymap_set(keymap.lhs, keymap.rhs, keymap.desc)
    end

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

local lsp_with_configs = {
    "sumneko_lua",
    "jsonls",
    "pyright",
}

for _, lsp_name in ipairs(lsp_with_configs) do
    local lsp_config_module = "vinevim.lsp.configs." .. lsp_name

    local ok, lsp_config = pcall(require, lsp_config_module)
    if ok then
        lsp.configure(lsp_name, lsp_config)
    end
end

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
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
})

lsp.setup()
