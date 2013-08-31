" Author:        Josh Davis
" Description:   This is the personal .vimrc file of Josh Davis. I've tried to document
"                every option and item. Feel free to use it to learn more about configuring Vim.
"
"                Also, I encourage you to pick out the parts that you use and understand rather
"                than blindly using it.
"
"                You can find me on Github: http://github.com/jdavis
"                Or my personal site: http://joshldavis.com

" As the help says 'Make vim behave in a more useful way'
" **Must be first uncommented line**
set nocompatible

"
" Custom Functions
"

" Switch between paste/nopaste
function! PasteToggle()
    if &paste
        set nopaste
    else
        set paste
    endif
endfunction

" Remove trailing whitespace
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        %s/\s\+$//e
        normal 'yz<CR>
        normal `z
    endif
endfunction

" Check if a colorscheme exists
" http://stackoverflow.com/a/5703164
function! HasColorScheme(scheme)
    let path = '~/.vim/bundle/vim-colorschemes/colors/' . a:scheme . '.vim'
    return filereadable(expand(path))
endfunction

"
" Global Settings
"

" The default 20 isn't nearly enough
set history=9999

" Show the numbers on the left of the screen
set number

" Show the column/row
set ruler

" Pretty colors are fun, yayyy
syntax on

" Show the matching when doing a search
set showmatch

" Allows the backspace to delete indenting, end of lines, and over the start
" of insert
set backspace=indent,eol,start

" Ignore case when doing a search as well as highlight it as it is typed
set ignorecase smartcase
set hlsearch
set incsearch

" Don't show the startup message
set shortmess=I

" Show the current command at the bottom
set showcmd

" Disable beeping and flashing.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Use smarter defaults
set smartindent
set smarttab

" Use autoindenting
set autoindent

" The tabstop look best at 4 spacing
set tabstop=4
set softtabstop=4
set shiftwidth=4

" I have been converted to the dark side, I will use spaces to indent code
" from here on out
set expandtab

" Turn on persistent undo
" Thanks, Mr Wadsten: github.com/mikewadsten/dotfiles/
if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" The comma makes a great leader of men, heh heh
let mapleader = ","

" Show two lines for the status line
set laststatus=2

" Always show the last line
set display+=lastline

" UTF-8 THIS SHITTTTTT
set encoding=utf-8

" Enable spellcheck for Markdown files
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us

" Enhanced mode for command-line completion
set wildmenu

" Automatically re-read the file if it has changed
set autoread

"
" Global Bindings
"

" Create a new tab with nicer shortcut
nm <leader>T :tabnew<cr>

" Split the window using some nice shortcuts
nm <leader>s<bar> :vsplit<cr>
nm <leader>s- :split<cr>

" Unhighlight the last search pattern on Enter
nn <silent> <CR> :nohlsearch<CR><CR>

" Remove trailing whitespace
nm <leader>tW :cal StripTrailingWhitespace()<CR>

" Control enhancements in insert mode
imap <C-F> <RIGHT>
imap <C-B> <LEFT>
imap <M-BS> <ESC>vBc
imap <C-P> <UP>
imap <C-N> <DOWN>

" No more colons
nnoremap ; :

" When pushing j/k on a line that is wrapped, it navigates to the same line,
" just to the expected location rather than to the next line
nnoremap j gj
nnoremap k gk

" Arrow key users won't survive in this environment
map <UP> <NOP>
map <DOWN> <NOP>
map <LEFT> <NOP>
map <RIGHT> <NOP>

" Map Ctrl+V to paste in Insert mode
imap <C-V> <C-R>*

" Map Ctrl+C to copy in Visual mode
vmap <C-C> "+y

" Add paste shortcut
nmap <leader>P "+p

" GVim Settings
if has('gui_running')
    " Who uses a GUI in GVim anyways? Let's be serious.
    set guioptions=aegirLt

    " Let's make the fonts look nice
    let os=substitute(system('uname'), '\n', '', '')
    if os == 'Darwin' || os == 'Mac'
        set guifont=Droid\ Sans\ Mono\ for\ Powerline:h11
    elseif os == 'Linux'
        set guifont=Inconsolata\ for\ Powerline:h11
    endif
endif

"
" Custom Settings
"

" Set on textwidth when in markdown files
au FileType markdown set textwidth=80

" Smarter completion in C
au FileType c set omnifunc=ccomplete#Complete

" My own special flavoring to running programs
au FileType asm,c,objc,scheme,sh,python,perl,javascript nn <leader>R :!~/Scripts/deepThought.sh '%:p'<CR>

" Highlight trailing whitespace obnoxiously
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"
" Start Vundle
"

" Required by Vundle
filetype off

" Vundle is the new god among plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"
" Vundle Bundles
"

" Vundle bundle
Bundle 'gmarik/vundle'

" Updated Vim-Git runtime files
Bundle 'tpope/vim-git'

" For file browsing
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

" For the best snippet functionality
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

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

" Awesome Python utilities
"Bundle 'klen/python-mode'

" For CoffeeScript, YAY!
Bundle 'kchmck/vim-coffee-script'

" For LESS
Bundle 'groenewege/vim-less'

" For better status lines
Bundle 'bling/vim-airline'

" Let's add some colors
Bundle 'flazz/vim-colorschemes'

" Better Markdown
Bundle 'tpope/vim-markdown'

" Rust-Lang Features
Bundle 'wting/rust.vim'

" Git Gutter
Bundle 'airblade/vim-gitgutter'

" Stylus Plugin
Bundle 'wavded/vim-stylus'

" Vim-bad-whitespace, highlights bad whitespace
Bundle 'bitc/vim-bad-whitespace'

" Follow Google's C++ Style Guide
Bundle 'funorpain/vim-cpplint'

" Add Gist-vim
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'

" Awesome plugin for my capitalization woes:
" http://www.reddit.com/r/vim/comments/1im4d9/do_you_ever_accidentally_hold_the_shift_key_to/cb5za1t
Bundle 'takac/vim-commandcaps'

" Long live ctags
Bundle 'majutsushi/tagbar'

" CoVim
"Bundle 'FredKSchott/CoVim'

" Ack support in Vim
Bundle 'mileszs/ack.vim'

" Better Undo
Bundle 'sjl/gundo.vim'

"
" Custom Bindings
"

" Bind PasteToggle to something quick and easy
nm <leader>tP :cal PasteToggle()<cr>

" Bind :sort to something easy, don't press enter, allow for options (eg -u,
" n, sorting in reverse [sort!])
vnoremap <leader>s :sort

"
" Bundle Settings/Bindings
"

" Vundle mapping
nm <leader>vl :BundleList<cr>
nm <leader>vi :BundleInstall<cr>
nm <leader>vI :BundleInstall!<cr>
nm <leader>vc :BundleClean<cr>
nm <leader>vC :BundleClean!<cr>

" NERDTree Options: Toggle Browser
let NERDTreeIgnore = ['\.py[co]$', '\.sw[po]$']
nm <leader>tb :NERDTreeTabsToggle<cr>

" CtrlP Settings
nn <leader>p :CtrlP<cr>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Tagbar Options
" Toggle Tagbar
nm <leader>tt :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 30


" Autoclose Plugin options
let g:AutoClosePairs = "() {} [] \" ' `"
au FileType scheme let g:AutoClosePairs = "() {} [] \" `"

" Python-mode settings
let g:pymode_run_key = '<leader>r'
let g:pymode_lint_ignore = 'E501'
let g:pymode_folding = 0
let g:pymode_lint_config = "$HOME/.pylintrc"
let g:pymode_run = 0

" Airline options
let g:airline_enable_branch = 1
let g:airline_enable_syntastic = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'light'

" Fugitive mapping
nm <leader>gb :Gblame<cr>
nm <leader>gc :Gcommit<cr>
nm <leader>gd :Gdiff<cr>
nm <leader>gg :Ggrep
nm <leader>gl :Glog<cr>
nm <leader>gp :Git pull<cr>
nm <leader>gP :Git push<cr>
nm <leader>gs :Gstatus<cr>
nm <leader>gw :Gbrowse<cr>

" Python-mode options
if !has('python')
    " Only load Python-mode when Python is enabled
    let g:pymode = 0
endif

" Cpplint Settings
autocmd FileType cpp map <buffer> <leader>l :call Cpplint()<cr>

" Syntastic Settings
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_signs = 1
let g:syntastic_java_checkers = ["checkstyle", "javac"]
let g:syntastic_java_javac_delete_output = 0
let g:syntastic_java_checkstyle_conf_file = '~/jars/sun_checks.xml'
let g:syntastic_java_checkstyle_classpath = '~/jars/checkstyle-5.5-all.jar'

" Gundo settings
nm <leader>tg :GundoToggle<CR>
let g:gundo_width = 30

"
" Misc Settings
"

" Let's make it pretty
set background=dark
set t_Co=256
set t_AB=[48;5;%dm
set t_AF=[38;5;%dm

" Must be loaded after the vim-colorschemes bundle
if HasColorScheme('moria')
    colorscheme moria
endif

" Load plugins and indent for the filtype
" **Must be last for Vundle**
filetype plugin indent on
