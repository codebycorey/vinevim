return {
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = function()
            return {
                options = {
                    close_command = function(n)
                        require("mini.bufremove").delete(n, false)
                    end,
                    right_mouse_command = function(n)
                        require("mini.bufremove").delete(n, false)
                    end,
                    diagnostics = "nvim_lsp",
                    always_show_bufferline = false,
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = true,
                            text_align = "left",
                        },
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            highlight = "Directory",
                            -- separator = true,
                            text_align = "left",
                        },
                        {
                            filetype = "snacks_picker_list",
                            text = "File Explorer",
                            highlight = "Directory",
                            -- separator = true,
                            text_align = "left",
                        },
                    },
                },
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
            }
        end,
    },
}
