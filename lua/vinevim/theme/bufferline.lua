local bline_ok, bufferline = pcall(require, "bufferline")
if not bline_ok then
    return
end

local options = {
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
}

bufferline.setup({ options = options })
