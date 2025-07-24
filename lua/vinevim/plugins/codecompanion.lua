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
            "ravitemer/codecompanion-history.nvim",
        },
        opts = {
            display = {
                chat = {
                    show_settings = true,
                    show_token_count = true,
                },
            },
            adapters = {
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                default = "gpt-4.1",
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
            extensions = {
                history = {
                    enabled = true,
                    opts = {
                        keymap = "gh",
                        picker = "fzf_lua",
                    },
                },
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        -- MCP Tools
                        make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
                        show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
                        add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
                        show_result_in_chat = true, -- Show tool results directly in chat buffer
                        format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
                        -- MCP Resources
                        make_vars = true, -- Convert MCP resources to #variables for prompts
                        -- MCP Prompts
                        make_slash_commands = true, -- Add MCP prompts as /slash commands
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
