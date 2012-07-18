set nocp
" ^ As the help says 'Make vim behave in a more useful way"

" The default 20 isn't nearly enough
set history=1000

" Show the numbers on the left of the screen
set number

" Pretty colors are fun, yayyy
syntax on

" Automatically detect the file based on the extension
filetype on

" Load the indent.vim file for the given filetype
filetype plugin indent on

" Show the matching when doing a search
set showmatch

" Allows the backspace to delete indenting, end of lines, and over the start
" of insert
set backspace=indent,eol,start

" Enabled spell checking for English
set spl=en_us

" Ignore case when doing a search as well as highlight it
set ic scs
set hlsearch

" Don't show any startup message
set shm=I

" Show the current command at the bottom
set showcmd

" Disable beeping and flashing.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Theme
set background=dark
colorscheme moria 

" Better controls while in insert mode by better I mean more like emacs,
" hahaha
imap <C-F> <RIGHT>
imap <C-B> <LEFT>
imap <M-BS> <Esc>vBc
imap <C-P> <UP>
imap <C-N> <DOWN>

" Use smart indenting
set si

" Use autoindenting
set ai

" The tabstop look best at 4 spacing
set tabstop=4
set softtabstop=4
set shiftwidth=4

" I have been converted to the dark side, I will use spaces to indent code
" from here on out
set expandtab

" Spacing is the chosen one when it comes to Python indentation
"autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" The comma makes a great leader of men, heh heh
let mapleader = ","

" Create a new tab with nicer shortcut
nm ,T :tabnew<cr>

" Split the window using some nice shortcuts
nm ,N :vsplit<cr>
nm ,n :split<cr>

" Smarter completion in C
au FileType c set omnifunc=ccomplete#Complete

" Toggle a NERDTree
nm ,b :NERDTreeTabsToggle<cr>

" Pathogen is a god among plugins
call pathogen#infect()

" Autoclose Plugin options
let g:AutoClosePairs = "() {} [] \" ' `"
au FileType html,php,xhtml,xml let g:AutoClosePairs_del = "<>"

" JSLint Plugin options
nm ,J :JSLintToggle<cr>
let g:JSLintHighlightErrorLine = 0

" flake8 Plugin
autocmd BufWritePost *.py call Flake8()

" Arduino
au BufNewFile,BufRead *.pde setf arduino

" Java and Eclim options
autocmd FileType java nn ,R :cal BuildJavaFile()<cr>
nn ,I :JavaImport<cr>

" Fugitive mapping
nm ,gc :Gcommit<cr>
nm ,gd :Gdiff<cr>
nm ,gs :Gstatus<cr>
nm ,gb :Gbrowse<cr>
nm ,gg :Ggrep 
nm ,gl :Glog<cr>
nm ,gp :Git pull<cr>
nm ,gP :Git push<cr>

" My own special flavoring to running programs
au FileType asm,c,objc,scheme,sh,python,perl,javascript nn ,R :!~/Scripts/deepThought.sh '%:p'<CR>
