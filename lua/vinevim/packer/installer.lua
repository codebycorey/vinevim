local m = {}

function m.setup()
    -- Automatically install Packer
    local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    local packer_bootstrap = nil
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        packer_bootstrap = vim.fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
    end

    return packer_bootstrap
end

return m
