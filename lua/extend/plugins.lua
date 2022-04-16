local fn = vim.fn

-- Automatically install Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Safely require packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

local packerUtil = require("packer.util")

-- Use popup window
packer.init({
    compile_path = packerUtil.join_paths(os.getenv("HOME"), ".nvim", "compiled", "packer_compiled.lua"),
    display = {
        open_fn = function()
            return packerUtil.float({ border = "rounded" })
        end,
    },
})

-- Load plugins
return packer.startup(function(use)
    -- REQUIRED: Packer manages itself
    use("wbthomason/packer.nvim")

    -- Util Plugins
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")

    -- Style
    use("gruvbox-community/gruvbox")
    use("kyazdani42/nvim-web-devicons")
    use("nvim-lualine/lualine.nvim")
    use("akinsho/bufferline.nvim")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")
    use("jose-elias-alvarez/null-ls.nvim")

    -- CMP
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lua")
    use("saadparwaiz1/cmp_luasnip")
    use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

    -- Snippets
    use("L3MON4D3/LuaSnip")

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- Treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/playground")

    -- File Tree
    use("kyazdani42/nvim-tree.lua")

    -- Git
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")

    -- QOL
    -- use 'cohama/lexima.vim' -- Auto close pairs
    use("windwp/nvim-autopairs")
    use("lukas-reineke/indent-blankline.nvim")
    use("numToStr/Comment.nvim") -- Toggle comments
    -- ADD TSXJSX Comments plugin

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
