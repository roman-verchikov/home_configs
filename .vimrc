syntax on
filetype plugin indent on

set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'davidhalter/jedi-vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/unite.vim'
Bundle 'Rip-Rip/clang_complete'
Bundle 'derekwyatt/vim-scala'
Bundle 'ervandew/supertab'

set nocompatible
set expandtab
set hlsearch
set incsearch
set laststatus=2
set tabstop=4
set shiftwidth=4
set number
set ignorecase
set background=dark
set modeline
" allows for filename autocompletion when path starts after '=' sign, e.g.
" when assigning a path to a variable in bash script
set isfname-==

let g:clang_use_library = 1

" disable docstring jedi-vim autocomplete
autocmd FileType python setlocal completeopt-=preview
autocmd BufNewFile,BufRead *.scala setlocal ft=scala
autocmd FileType scala setlocal shiftwidth=2 tabstop=2
