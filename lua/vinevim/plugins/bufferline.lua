return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function()
        local options = {
            offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        }
        require("bufferline").setup({ options = options })
    end,
}
