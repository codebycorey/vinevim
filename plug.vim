call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'               " Git Wrapper
Plug 'tpope/vim-rhubarb'                " Github integration
Plug 'cohama/lexima.vim'                " Auto close parentheses

if has('nvim')
    Plug 'neovim/nvim-lspconfig'        " Quickstart configurations for LSP
    Plug 'glepnir/lspsaga.nvim'         " LSP Display
endif

Plug 'nvim-telescope/telescope.nvim'
Plug 'gruvbox-community/gruvbox'

call plug#end()

