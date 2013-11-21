syntax on
filetype plugin indent on

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'davidhalter/jedi-vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/unite.vim'
Bundle 'Rip-Rip/clang_complete'
Bundle 'derekwyatt/vim-scala'

set nocompatible
set expandtab
set hlsearch
set incsearch
set laststatus=2
set nu
set ignorecase
set background=dark
set modeline
" allows for filename autocompletion when path starts after '=' sign, e.g.
" when assigning a path to a variable in bash script
set isfname-==

" disable docstring jedi-vim autocomplete
autocmd FileType python setlocal completeopt-=preview
autocmd BufNewFile,BufRead *.scala setlocal ft=scala

