local packer_bootstrap = require("vinevim.packer.installer").setup()

-- Safely require packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

local packerUtil = require("packer.util")

-- Load plugins
return packer.startup({
    function(use)
        -- REQUIRED: Packer manages itself
        use("wbthomason/packer.nvim")

        -- Util Plugins
        use("nvim-lua/popup.nvim")
        use("nvim-lua/plenary.nvim")

        -- LSP
        use({
            "VonHeikemen/lsp-zero.nvim",
            requires = {
                -- LSP
                { "neovim/nvim-lspconfig" },
                { "williamboman/mason.nvim" },
                { "williamboman/mason-lspconfig.nvim" },

                -- CMP
                { "hrsh7th/nvim-cmp" },
                { "hrsh7th/cmp-buffer" },
                { "hrsh7th/cmp-path" },
                { "saadparwaiz1/cmp_luasnip" },
                { "hrsh7th/cmp-nvim-lsp" },
                { "hrsh7th/cmp-nvim-lua" },

                -- Snippets
                { "L3MON4D3/LuaSnip" },
                { "rafamadriz/friendly-snippets" },
            },
        })
        use("jose-elias-alvarez/null-ls.nvim")
        use("ray-x/lsp_signature.nvim")
        use("b0o/schemastore.nvim")

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

        -- Theme and Layout
        -- colorschemes
        use("gruvbox-community/gruvbox")
        use("folke/tokyonight.nvim")
        use({ "catppuccin/nvim", as = "catppuccin" })
        use("navarasu/onedark.nvim")

        use("kyazdani42/nvim-web-devicons")
        use("nvim-lualine/lualine.nvim")
        use("akinsho/bufferline.nvim")

        -- QOL
        use("windwp/nvim-autopairs")
        use("lukas-reineke/indent-blankline.nvim")
        use("numToStr/Comment.nvim") -- Toggle comments
        use("akinsho/toggleterm.nvim")
        use("mbbill/undotree")
        use("ThePrimeagen/harpoon")

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        compile_path = packerUtil.join_paths(os.getenv("HOME"), ".nvim", "compiled", "packer_compiled.lua"),
    },
})
