local line_ok, lualine = pcall(require, "lualine")
if not line_ok then
    return
end

local settings = {
    options = {
        disabled_filetypes = { "NvimTree" },
    },
}

lualine.setup(settings)
