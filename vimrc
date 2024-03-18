"
" Setup vim-plug
"
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'rust-lang/rust.vim', { 'for': ['rust', 'toml'] }
Plug 'sheerun/vim-polyglot'
Plug 'lifepillar/vim-solarized8'

" Ale
Plug 'dense-analysis/ale', { 'for': 'typescript' }
call plug#end()

"
" Basic Configuration
"
filetype plugin indent on
syntax on

let mapleader=","
let maplocalleader="\\"

set nocompatible
set modelines=0
set expandtab
set showmode
set showcmd
set hidden
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=81
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set showmatch
set ignorecase
set smartcase
set smarttab
set scrolloff=4
set hlsearch
set incsearch
set gdefault
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set list
set mouse=
set shortmess+=I
set clipboard=unnamed
set autoread
set undofile
set encoding=utf-8
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set laststatus=2
set notimeout
set ttimeout
set foldmethod=indent
set foldlevel=99
set suffixes='.bak,~,.o,.info,swp,obj,.yy.c,.tab.c,.tab.h'
set wildignore+=*.pyc,*/__pycache__/*
set wildignore+=*.class
set wildignore+=*/build/*
set wildignore+=*/node_modules/*

"
" Set Backup
"
if !has('nvim')
  set undodir=~/.vim/tmp/undo//
endif
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

"
" Plugin: vim-plug
"
nnoremap <leader>p :PlugStatus<cr>

"
" Plugin: NERDTree
"
nnoremap <leader>n :NERDTreeToggle<cr>

"
" Plugin: rust.vim
"
nnoremap <leader>f :RustFmt<cr>

set background=dark
colorscheme solarized8

"
" Plugin: ale
"
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let b:ale_fixers = ['eslint']
