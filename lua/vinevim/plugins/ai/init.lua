return {
    {
        "github/copilot.vim",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        lazy = false,
        init = function()
            vim.g.copilot_filetypes = {
                ["typr"] = false,
            }
        end,
    },
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
                                -- default = "claude-3.5-sonnet",
                                default = "o3-mini-2025-01-31",
                            },
                            max_tokens = {
                                default = 8192,
                            },
                        },
                    })
                end,
            },
            display = {
                chat = {
                    intro_message = "What can I help with (Press ? for options)",
                    show_references = true,
                    show_settings = false,
                    show_header_separator = true,
                },
            },
            strategies = {
                chat = {
                    adapter = "copilot",
                    variables = {
                        ["guidelines"] = {
                            callback = require("vinevim.plugins.ai.prompts.generic-guidelines"),
                            description = "Automated",
                            opts = {
                                contains_code = false,
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
            {
                "<leader>aa",
                function()
                    vim.cmd("CodeCompanionActions")
                end,
                desc = "[A]I [A]ctions",
            },
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
