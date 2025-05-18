let mapleader ="\<space>"
inoremap jk <esc>
nnoremap <leader>e :Explore<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>u :e!<cr>
nnoremap <C-n> :nohl<cr>
nnoremap <leader>j :wincmd j<cr>
nnoremap <leader>k :wincmd k<cr>
nnoremap <leader>h :wincmd h<cr>
nnoremap <leader>l :wincmd l<cr>

syntax on
set nocompatible
set showcmd
set wildmenu
set encoding=utf-8
set showmatch
set clipboard=unnamedplus
set timeoutlen=800
set isfname+="@-@"
set iskeyword+="@_@"

set number
"set relativenumber

set ruler
set nowrap

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

set hlsearch
set incsearch
set ignorecase
set smartcase
set smartindent

let g:netrw_banner=0
let g:netrw_localcopydircmd="cp -r"
