" Load Pathogen
execute pathogen#infect()

" Colors
syntax enable
" color dracula
colorscheme deus

set nocompatible              " be iMproved, required
filetype off                  " required
" Make Vim more useful
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
"set clipboard=unnamedplus
" Enhance command-line completion¬
set wildmenu
" Enable line numbers
set number
" Display syntax
syntax on
" Highlight current line
set cursorline
" Turn indent plugin
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Respect modeline in files
set modeline
set modelines=4
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Make backspace work like most other apps
set backspace=indent,eol,start 

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif
" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Set default encoding
set encoding=utf-8

" KEYS MAPPINGS
" Set comma as a leader
let mapleader=","
" Move to the next buffer
nmap <leader>] :bn<cr>
" Move to the previous buffer
nmap <leader>[ :bp<cr>
" Close current buffer with NERDTree bug
noremap <leader>w :bp<cr>:bd #<cr>

" Spell check
set spelllang=en
set spell

" Status line configuration
set statusline=  
set statusline+=%-10.3n\                     " buffer number  
set statusline+=%f\                          " filename   
set statusline+=%h%m%r%w                     " status flags  
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type  
set statusline+=%=                           " right align remainder  
set statusline+=0x%-8B                       " character value  
set statusline+=%-14(%l,%c%V%)               " line, character  
set statusline+=%<%P                         " file position 

" Languages configuration

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
" Display extra column for Ale
" let g:ale_sign_column_always = 1

" PLUGINS configuration

" Set smart tab for airline
let g:airline#extensions#tabline#enabled = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled=1
" Show just a filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Turn on Ale for air line
let g:airline#extensions#ale#enabled = 1

" Idents display
let g:indent_guides_enable_on_vim_startup = 1

au BufReadPost BUCK set syntax=python

" NERDtree config
map <C-n> :NERDTreeToggle<CR>
" Open NERDTree and jump to the file
map <C-j> :NERDTreeFind<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1

