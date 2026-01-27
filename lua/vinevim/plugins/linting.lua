return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            linters = {
                eslint_d = {
                    args = {
                        "--ignore", -- <-- this is the key argument
                        "--format",
                        "json",
                        "--stdin",
                        "--stdin-filename",
                        function()
                            return vim.api.nvim_buf_get_name(0)
                        end,
                    },
                },
            },
            linters_by_ft = {
                python = { "mypy", "ruff", "flake8" },
                typescript = { "eslint_d" },
                javascript = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                javascriptreact = { "eslint_d" },
            },
        },
        config = function(_, opts)
            local lint = require("lint")

            for name, linter in pairs(opts.linters) do
                if type(linter) == "table" and type(lint.linters[name]) == "table" then
                    lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
                else
                    lint.linters[name] = linter
                end
            end
            lint.linters_by_ft = opts.linters_by_ft

            local function debounce(ms, fn)
                local timer = vim.uv.new_timer()
                return function(...)
                    local argv = { ... }
                    if timer ~= nil then
                        timer:start(ms, 0, function()
                            timer:stop()
                            vim.schedule_wrap(fn)(unpack(argv))
                        end)
                    end
                end
            end

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = debounce(100, function()
                    lint.try_lint()
                end),
            })

            vim.keymap.set("n", "<leader>bl", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
}
