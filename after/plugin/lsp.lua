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

local lsp_keymaps = {
    { lhs = "gd", rhs = vim.lsp.buf.definition, desc = "[G]o to [D]efinition" },
    { lhs = "gD", rhs = vim.lsp.buf.declaration, desc = "[G]o to [D]eclaration" },
    { lhs = "gi", rhs = vim.lsp.buf.implementation, desc = "[G]o to [I]mplementation" },
    { lhs = "gr", rhs = vim.lsp.buf.references, desc = "[G]o to [R]eferences" },
    { lhs = "K", rhs = vim.lsp.buf.hover, desc = "Open floating buffer information" },
    { lhs = "gl", rhs = vim.diagnostic.open_float, desc = "Open floating diagnostic information" },
    {
        lhs = "<leader>lf",
        rhs = function()
            vim.lsp.buf.format({ async = true })
        end,
        desc = "[L]sp [F]ormat",
    },
    {
        lhs = "<leader>li",
        rhs = function()
            vim.cmd("LspInfo")
        end,
        desc = "[L]sp [I]nformation",
    },
    {
        lhs = "<leader>lI",
        rhs = function()
            vim.cmd("LspInstallInfo")
        end,
        desc = "[L]sp [I]nstall information",
    },
    { lhs = "<leader>la", rhs = vim.lsp.buf.code_action, desc = "[L]sp C]ode action" },
    { lhs = "[d", rhs = vim.diagnostic.goto_prev, desc = "Go to previous [D]iagnostic" },
    { lhs = "]d", rhs = vim.diagnostic.goto_next, desc = "Go to next [D]iagnostic" },
}

local on_attach = function(client, bufnr)
    local options = { buffer = bufnr, remap = false, silent = true }

    for _, keymap in ipairs(lsp_keymaps) do
        local opts = vim.tbl_deep_extend("force", options, {
            desc = keymap.desc,
        })
        vim.keymap.set("n", keymap.lhs, keymap.rhs, opts)
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
    float = true,
})


lsp.setup()
