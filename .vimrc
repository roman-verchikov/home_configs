syntax on
filetype plugin indent on

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'davidhalter/jedi-vim'
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

" disable docstring jedi-vim autocomplete
autocmd FileType python setlocal completeopt-=preview
autocmd BufNewFile,BufRead *.scala setlocal ft=scala
