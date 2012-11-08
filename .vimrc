"
" Global Settings
"

" As the help says 'Make vim behave in a more useful way'
set nocp

" The default 20 isn't nearly enough
set history=1000

" Show the numbers on the left of the screen
set number

" Pretty colors are fun, yayyy
syntax on

" Required by Vundle
filetype off

" Show the matching when doing a search
set showmatch

" Allows the backspace to delete indenting, end of lines, and over the start
" of insert
set backspace=indent,eol,start

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

" Turn on persistent undo
" Thanks, Mr Wadsten: github.com/mikewadsten/dotfiles/
set undodir=~/.vim/undo
set undofile

" The comma makes a great leader of men, heh heh
let mapleader = ","

" Show two lines for the status line
set laststatus=2

" UTF-8 THIS SHITTTTTT
set encoding=utf-8

"
" Global Bindings
"

" Create a new tab with nicer shortcut
nm <leader>T :tabnew<cr>

" Split the window using some nice shortcuts
nm <leader>N :vsplit<cr>
nm <leader>n :split<cr>

" Better controls while in insert mode by better I mean more like emacs,
" hahaha
imap <C-F> <RIGHT>
imap <C-B> <LEFT>
imap <M-BS> <Esc>vBc
imap <C-P> <UP>
imap <C-N> <DOWN>

"
" Custom Settings
"

" Set on textwidth when in markdown files
au FileType markdown set textwidth=80

" Smarter completion in C
au FileType c set omnifunc=ccomplete#Complete

" My own special flavoring to running programs
au FileType asm,c,objc,scheme,sh,python,perl,javascript nn ,R :!~/Scripts/deepThought.sh '%:p'<CR>

" Highlight trailing whitespace obnoxiously
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"
" Custom Functions
"

" Switch between paste/nopaste
fu! PasteToggle()
    if &paste
        set nopaste
    else
        set paste
    endif
endfu

"
" Custom Bindings
"

" Bind PasteToggle to something quick and easy
nm <leader>P :cal PasteToggle()<cr>

" Bind :sort to something easy, don't press enter, allow for options (eg -u,
" n, sorting in reverse [sort!])
nm <leader>s :sort

"
" Bundle Settings/Bindings
"

" Toggle a NERDTree
nm <leader>b :NERDTreeTabsToggle<cr>

" Show CtrlP
nn <leader>p :CtrlP<cr>

" Autoclose Plugin options
let g:AutoClosePairs = "() {} [] \" ' `"
au FileType html,php,xhtml,xml let g:AutoClosePairs_del = "<>"

" flake8 Plugin
autocmd BufWritePost *.py call Flake8()

" Arduino
au BufNewFile,BufRead *.pde setf arduino

" Java and Eclim options
autocmd FileType java nn ,R :cal BuildJavaFile()<cr>
nn ,I :JavaImport<cr>

" Powerline options
let g:Powerline_symbols = 'fancy'

" Fugitive mapping
nm <leader>gc :Gcommit<cr>
nm <leader>gd :Gdiff<cr>
nm <leader>gs :Gstatus<cr>
nm <leader>gb :Gbrowse<cr>
nm <leader>gg :Ggrep
nm <leader>gl :Glog<cr>
nm <leader>gp :Git pull<cr>
nm <leader>gP :Git push<cr>

" Vundle mapping
nm <leader>vl :BundleList<cr>
nm <leader>vi :BundleInstall<cr>
nm <leader>vI :BundleInstall!<cr>
nm <leader>vc :BundleClean<cr>
nm <leader>vC :BundleClean!<cr>

"
" Vundle Bundles
"

" Vundle is the new god among plugins, load it
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Required for Vundle
Bundle 'gmarik/vundle'

" Updated Vim-Git runtime files
Bundle 'tpope/vim-git'

" For file browsing
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

" For the best snippet functionality
Bundle 'garbas/vim-snipmate'
Bundle 'honza/snipmate-snippets'

" Required for snipMate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

" For tab completion
Bundle 'ervandew/supertab'

" Various commenting capabilities
Bundle 'scrooloose/nerdcommenter'

" Autocloses characters
Bundle 'Townk/vim-autoclose'

" For checking the syntax of any file
Bundle 'scrooloose/syntastic'

" For fuzzyfinding
Bundle 'kien/ctrlp.vim'

" Better JavaScript support
Bundle 'pangloss/vim-javascript'

" Vim and Git, sayyyy whatttt
Bundle 'tpope/vim-fugitive'

" Easily surround things
Bundle 'tpope/vim-surround'

" Pyflake as well as PEP8 within VIM
Bundle 'nvie/vim-flake8'

" For CoffeeScript, YAY!
Bundle 'kchmck/vim-coffee-script'

" For LESS
Bundle 'groenewege/vim-less'

" Ack Plugin
Bundle 'mileszs/ack.vim'

" For better status lines
Bundle 'Lokaltog/vim-powerline'

"
" Misc
"

" Load plugins and indent for the filtype:
filetype plugin indent on
