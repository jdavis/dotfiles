set nocp
" General Settings
set history=100
set number
syntax on
filetype plugin indent on
"set guifont=Monaco:h11
set showmatch
set backspace=indent,eol,start
set spl=en_us
set ic scs
set hlsearch
set shm=I

" Disable beeping and flashing.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Theme
"set background=dark
colorscheme desert 
"set cul

" Window Size
"set lines=58
"set columns=150

" Better controls while in insert mode
imap <C-F> <RIGHT>
imap <C-B> <LEFT>
imap <C-P> <UP>
imap <C-N> <DOWN>
imap <M-BS> <Esc>vBc

" Indentation
set smartindent
set autoindent
set ts=4
set shiftwidth=4

" The comma makes a great leader of men, heh heh
let mapleader = ","

" Leader shortcuts
nm ,b :NERDTreeTabsToggle<cr>
nm ,k k
nm ,h h
nm ,j j
nm ,l l
nm ,T :tabnew<cr>
nm ,N :vsplit<cr>
nm ,n :split<cr>

" Pathogen is a god.
call pathogen#infect()

" Autoclose options
let g:AutoClosePairs = "() {} [] <> \" ' `"

au FileType html,php,xhtml,xml let g:AutoClosePairs_del = "<>"

au FileType c set omnifunc=ccomplete#Complete
au FileType asm,c,objc,scheme,sh,python,perl,javascript nn ,R :!~/Programming/ShellScripts/deepThought.sh '%:p'<CR>

" Scheme
"autocmd FileType scheme inoremap ( ()<LEFT>

" Arduino
au BufNewFile,BufRead *.pde setf arduino

" Python
autocmd FileType python nmap <F4> i#!/usr/bin/env python 
au FileType python map <D-r> :!python %:p<CR>

" Java
autocmd FileType java nn ,R :cal BuildJavaFile()<cr>
nn ,I :JavaImport<cr>

