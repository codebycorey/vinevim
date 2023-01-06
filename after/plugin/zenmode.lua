local ok, zenmode = pcall(require, "zen-mode")
if not ok then
    return
end

local config = {
    window = {
        width = 90,
        options = {
            number = true,
            relativenumber = true,
        },
    },
}

zenmode.setup(config)

vim.keymap.set("n", "<leader>zz", zenmode.toggle)
