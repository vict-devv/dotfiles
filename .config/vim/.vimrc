" <Space> as map leader
let mapleader="\<Space>"
" Remaps ----------------------------
" Basic
inoremap jk <Esc>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader><CR> :nohl<CR>
nnoremap <leader>rn : set rnu!<CR>
" Navigation
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>
" Split windows
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
" Netrw -----------------------------
nnoremap <leader>e :Explore<CR>
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
" Settings --------------------------
set number
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set shiftwidth=4
set tabstop=4
set expandtab
set noshiftround
set nobackup
set scrolloff=10
set mouse=a
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set clipboard=unnamedplus
set encoding=utf-8
set hidden
set isfname+="@-@"