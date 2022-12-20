local pair_ok, autopairs = pcall(require, "nvim-autopairs")
if not pair_ok then
    return
end

autopairs.setup({
    check_ts = true,
})

