return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {
        disable_netrw = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        diagnostics = {
            enable = true,
            icons = {
                hint = "H",
                info = "I",
                warning = "W",
                error = "E",
            },
        },
        git = {
            ignore = false,
        },
        renderer = {
            highlight_git = true,
            icons = {
                show = {
                    git = false,
                },
            },
            indent_markers = {
                enable = true,
            },
            group_empty = true,
        },
        on_attach = function(bufnr)
            local api = require('nvim-tree.api')
            local function opts(desc)
                print("nvim-tree: " .. desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
            vim.keymap.set("n", "<C-e>", '', { buffer = bufnr });
            vim.keymap.del("n", "<C-e>", { buffer = bufnr });
            vim.keymap.set("n", "e", '', { buffer = bufnr });
            vim.keymap.del("n", "e", { buffer = bufnr });

        end,
    },
    keys = {
        -- {
        --     "<leader>e",
        --     function()
        --         vim.cmd.NvimTreeToggle()
        --     end,
        --     desc = "Toggle Nvim Tree",
        -- },
    },
}
