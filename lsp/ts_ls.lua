---@type vim.lsp.Config
return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
    },
    root_markers = {
        ".git",
        "package.json",
        "tsconfig.json",
        "jsconfig.json",
    },
    single_file_support = true,
    init_options = {
        hostInfo = "neovim",
    },
}
