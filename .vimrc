set nocp
" General Settings
set history=100
set number
syntax on
filetype on
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
set background=dark
colorscheme moria 
"set cul

" Window Size
"set lines=58
"set columns=150

" Better controls while in insert mode
imap <C-F> <RIGHT>
imap <C-B> <LEFT>
imap <M-BS> <Esc>vBc
" Only with Supertab installed
imap <C-P> <UP>
imap <C-N> <DOWN>

" Indentation
set smartindent
set autoindent
set ts=4
set shiftwidth=4

autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" The comma makes a great leader of men, heh heh
let mapleader = ","

" Leader shortcuts
nm ,k k
nm ,h h
nm ,j j
nm ,l l
nm ,T :tabnew<cr>
nm ,N :vsplit<cr>
nm ,n :split<cr>
" Plugin mapping
nm ,b :NERDTreeTabsToggle<cr>
nm ,v :TagbarToggle<cr>

" Taken from here: http://stackoverflow.com/questions/597687/changing-variable-names-in-vim
" For global & local replace
nnoremap ,r gd[{V%:s/<C-R>///gc<left><left><left>
nnoremap ,R gD:%s/<C-R>///gc<left><left><left>

" Pathogen is a god.
call pathogen#infect()

" Autoclose options
let g:AutoClosePairs = "() {} [] \" ' `"

au FileType html,php,xhtml,xml let g:AutoClosePairs_del = "<>"

" JSLint Plugin
let g:JSLintHighlightErrorLine = 0

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

