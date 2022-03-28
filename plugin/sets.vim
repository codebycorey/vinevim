" Sourc .vimrc at project root
" se exrc

"  Line Numbers
set number
set relativenumber

" Tabs and Indents
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Turn off Search Highlight when done
set nohlsearch
set incsearch

" Keep buffers open
set hidden

" Turn off error bells
set noerrorbells

" Text display
set nowrap

" Histroy
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Scrolling
set scrolloff=8

" Linting and Length Column
set signcolumn=yes
set colorcolumn=80

" TODO: Look up these
set noshowmode
set completeopt=menuone,noinsert,noselect

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor UX
set updatetime=50

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

set guicursor=
set termguicolors
