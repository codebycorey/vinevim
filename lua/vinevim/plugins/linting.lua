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

            local M = {}

            function M.debounce(ms, fn)
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

            function M.dump(o)
                if type(o) == "table" then
                    local s = "{ "
                    for k, v in pairs(o) do
                        if type(k) ~= "number" then
                            k = '"' .. k .. '"'
                        end
                        s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
                    end
                    return s .. "} "
                else
                    return tostring(o)
                end
            end

            function M.lint()
                -- local bufnr = vim.api.nvim_get_current_buf()
                -- local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
                -- local linters = lint.linters_by_ft[ft]
                -- if linters then
                --     for _, linter in ipairs(linters) do
                -- local names = lint._resolve_linter_by_ft(vim.bo.filetype)
                -- print("linting with", dump(names))
                lint.try_lint()
                --     end
                -- end
            end

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = M.debounce(100, M.lint),
            })

            vim.keymap.set("n", "<leader>bl", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
}
