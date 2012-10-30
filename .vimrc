set nocp
" ^ As the help says 'Make vim behave in a more useful way"

"
" Global Settings
"

" The default 20 isn't nearly enough
set history=1000

" Show the numbers on the left of the screen
set number

" Pretty colors are fun, yayyy
syntax on

" Required by Vundle
filetype off

" Load plugins and indent for the filtype
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

" The comma makes a great leader of men, heh heh
let mapleader = ","

"
" Global Bindings
"

" Create a new tab with nicer shortcut
nm ,t :tabnew<cr>

" Split the window using some nice shortcuts
nm ,N :vsplit<cr>
nm ,n :split<cr>

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
nm ,P :cal PasteToggle()<cr>

"
" Bundle Settings/Bindings
"

" Vundle is the new god among plugins, load it
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Toggle a NERDTree
nm ,b :NERDTreeTabsToggle<cr>

" Show CommandT
nn ,T :CommandT<cr>

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

" Fugitive mapping
nm ,gc :Gcommit<cr>
nm ,gd :Gdiff<cr>
nm ,gs :Gstatus<cr>
nm ,gb :Gbrowse<cr>
nm ,gg :Ggrep
nm ,gl :Glog<cr>
nm ,gp :Git pull<cr>
nm ,gP :Git push<cr>

" Vundle mapping
nm ,vl :BundleList<cr>
nm ,vi :BundleInstall<cr>
nm ,vI :BundleInstall!<cr>
nm ,vc :BundleClean<cr>
nm ,vC :BundleClean!<cr>

"
" Vundle Bundles
"

" Required for Vundle
Bundle 'gmarik/vundle'

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
Bundle 'wincent/Command-T'

" For JavaScript checking
Bundle 'hallettj/jslint.vim'

" Vim and Git, sayyyy whatttt
Bundle 'tpope/vim-fugitive'

" Pyflake as well as PEP8 within VIM
Bundle 'nvie/vim-flake8'

" For CoffeeScript, YAY!
Bundle 'kchmck/vim-coffee-script'

" For LESS
Bundle 'groenewege/vim-less'

" Conque allows a shell within Vim
Bundle 'lrvick/Conque-Shell'

" Ack Plugin
Bundle 'mileszs/ack.vim'
