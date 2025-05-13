return {
    {
        "akinsho/bufferline.nvim",
        opts = function()
            return {
                options = {
                    close_command = function(bufnr)
                        require("mini.bufremove").delete(bufnr, false)
                    end,
                    right_mouse_command = function(bufner)
                        require("mini.bufremove").delete(bufner, false)
                    end,
                    diagnostics = "nvim_lsp",
                    always_show_bufferline = false,
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = true,
                            text_align = "left",
                        },
                    },
                },
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
            }
        end,
    },
}
