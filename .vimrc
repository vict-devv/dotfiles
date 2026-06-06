" Leader Key ======================================================================================
let mapleader="\<Space>"

" Remaps ==========================================================================================
" Misc
inoremap jk <Esc>
nnoremap <Esc> :nohl<CR><Esc>
nnoremap n nzz
nnoremap N Nzz
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>rn : set rnu!<CR>
" Navigation
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>
" Split
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
" Explorer
nnoremap <leader>e :Explore<CR>
" FZF
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
" ALE
nmap <silent> ]d <Plug>(ale_next_wrap)
nmap <silent> [d <Plug>(ale_previous_wrap)
nnoremap <leader>a :ALEDetail<CR>
" Git
nnoremap <silent> <leader>gs :LazyGit<CR>
nnoremap <leader>gb :Git blame<CR>

" Netrw ===========================================================================================
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4

" Settings " ======================================================================================
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
set incsearch
set ignorecase
set smartcase
set wrap
set textwidth=100
set formatoptions+=t
set ruler
set colorcolumn=100
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set clipboard=unnamedplus
set encoding=utf-8
set hidden
set isfname+="@-@"

" Plugins =========================================================================================
call plug#begin('~/.vim/plugged')

" Everforest theme
Plug 'sainnhe/everforest'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kdheepak/lazygit.nvim'

" Navigation & Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'

" Languages/Tools Support + LSP
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'hashivim/vim-terraform'
Plug 'pearofducks/ansible-vim'

" Misc
Plug 'machakann/vim-highlightedyank'

call plug#end()

" Setting Theme ===================================================================================
if(has("termguicolors"))
    set termguicolors
endif

let g:everforest_background='medium'
let g:everforest_enable_italic=1
let g:everforest_better_performance=1
let g:everforest_transparent_background=1

set background=dark
colorscheme everforest

" ALE Configuration ===============================================================================
let g:ale_linters = {
\   'sh': ['shellcheck'],
\   'dockerfile': ['hadolint'],
\   'terraform': ['tflint'],
\   'yaml': ['ansible-lint'],
\}
" Fix files automatically on save
let g:ale_fixers = {
\   'terraform': ['terraform_fmt'],
\}
let g:ale_fix_on_save = 1

" Tweaks ==========================================================================================
" Forcing cursor to behave properly between Vim modes
if &term =~ 'alacritty'
    let &t_SI = "\e[6 q" " Insert mode: vertical bar
    let &t_EI = "\e[2 q" " Normal mode: solid block
endif
