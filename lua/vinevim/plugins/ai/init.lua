return {
    {
        "olimorris/codecompanion.nvim",
        cmd = {
            "CodeCompanion",
            "CodeCompanionActions",
            "CodeCompanionChat",
            "CodeCompanionCmd",
        },
        dependencies = {
            "saghen/blink.cmp",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "fidget.nvim",
        },
        opts = {
            adapters = {
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                default = "claude-sonnet-4",
                            },
                            max_tokens = {
                                default = 200000,
                            },
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    slash_commands = {
                        ["buffer"] = {
                            -- Location to the slash command in CodeCompanion
                            callback = "strategies.chat.slash_commands.buffer",
                            description = "Select a buffer using fzf",
                            opts = {
                                provider = "fzf_lua", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                            },
                        },
                        ["file"] = {
                            -- Location to the slash command in CodeCompanion
                            callback = "strategies.chat.slash_commands.file",
                            description = "Select a file using fzf",
                            opts = {
                                provider = "fzf_lua", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                            },
                        },
                    },
                },
            },
        },
        init = function()
            vim.cmd([[cab cc CodeCompanion]])
            local progress = require("fidget.progress")
            local handle = nil

            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "CodeCompanionRequest*",
                group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {}),
                callback = function(request)
                    if request.match == "CodeCompanionRequestStarted" then
                        handle = progress.handle.create({
                            title = "AI requesting",
                            lsp_client = { name = "CodeCompanion" },
                        })
                    elseif request.match == "CodeCompanionRequestFinished" then
                        if handle then
                            handle:finish()
                        end
                    end
                end,
            })
        end,
        keys = {
            {
                "<leader>ac",
                function()
                    vim.cmd("CodeCompanionChat toggle")
                end,
                desc = "[A]I [C]hat",
            },
            {
                "<leader>an",
                function()
                    vim.cmd("CodeCompanionChat")
                end,
                desc = "[A]I [N]ew Chat",
            },
            -- {
            --     "<leader>aa",
            --     function()
            --         vim.cmd("CodeCompanionActions")
            --     end,
            --     desc = "[A]I [A]ctions",
            -- },
            {
                "<leader>aa",
                function()
                    vim.cmd("CodeCompanionChat add")
                end,
                desc = "AI add to chat",
                mode = { "v" },
            },
            {
                "<leader>ae",
                function()
                    vim.cmd("CodeCompanionChat /explain")
                end,
                desc = "[A]I [E]xplain",
                mode = { "v" },
            },
        },
    },
}
