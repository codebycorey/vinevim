local ok, obsidian = pcall(require, "obsidian")
if not ok then
    return
end

local config = {
    dir = "~/personal/forest/",
    completion = {
        nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
    },
}

obsidian.setup(config)
