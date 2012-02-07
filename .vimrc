set nocp
" General Settings
set history=100
set number
syntax on
filetype plugin indent on
"set guifont=Monaco:h11
set showmatch
set backspace=indent,eol,start
"set vb
set spl=en_us
set ic scs
set hlsearch
set shm=I

" Theme
"set background=dark
colorscheme desert 
"set cul

" Window Size
"set lines=58
"set columns=150

" Keystrokes
imap <C-F> <RIGHT>
imap <C-B> <LEFT>

" Indentation
set smartindent
set autoindent
set ts=4
set shiftwidth=4

" --------------------
imap <M-BS> <Esc>vBc

" Open NERDTree, B for browse
nm ,b :NERDTree<cr>
" Window shortcuts
nm ,k k
nm ,h h
nm ,j j
nm ,l l
nm ,T :tabnew<cr>
nm ,N :vsplit<cr>
nm ,n :split<cr>

"Normal Syntax
"im { {}<LEFT>
"im ( ()<LEFT>
"im [ []<LEFT>

" Pathogen
call pathogen#infect()

au FileType c set omnifunc=ccomplete#Complete
au FileType asm,c,objc,scheme,sh,python,perl,javascript nn ,R :!~/Programming/ShellScripts/deepThought.sh '%:p'<CR>

" Scheme
autocmd FileType scheme inoremap ( ()<LEFT>
"autocmd FileType scheme map <D-r> :!osascript ~/Programming/AppleScripts/Interp.scpt scheme " -load %"<CR>
"autocmd FileType scheme map <D-R> :!~/Programming/davis/ckn/bin/csi "~/Programming/Scheme/JDLib.scm" `pwd`/%<CR>

" Arduino
au BufNewFile,BufRead *.pde setf arduino

" Python
autocmd FileType python nmap <F4> i#!/usr/bin/env python 
au FileType python map <D-r> :!python %:p<CR>

" Java
autocmd FileType java nn ,R :cal BuildJavaFile()<cr>
nn ,I :JavaImport<cr>

function! BuildJavaFile()
	let workspace = "/home/davis/Eclipse/"
	let projectName = eclim#project#util#GetCurrentProjectName()
	if len(projectName)
		exe "!`~/Programming/Python/classPath.py %:p " . workspace . projectName . "`"
	endif
endf

" JavaScript
set makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -process\ %
"set errorformat=%f(%l):\ %m

" Session Stuff
"nm <F3> <ESC>:cal LoadSession()<cr>
"let s:sessionloaded = 0
"function! LoadSession()
	"source Session.vim
"	let s:sessionloaded = 1
"endf
"function! SaveSession()
"	if s:sessionloaded == 1
"		mksession!
"	end
"endf
"autocmd VimLeave * call SaveSession()


"Completion
ino <BS> <C-R>=DeleteEmpty()<CR><BS>
"ino  <C-R>=IndentCurly()<CR><RETURN>

function! DeleteEmpty()
	let str = strpart(getline("."), col(".") - 2, 2)
	let in = stridx(" ([{\"'<`", str[0])
	return (in == stridx(" )]}\"'>`", str[1]) && in > 0) ? "\<DEL>" : ""
endf

function! IndentCurly()
	let str = strpart(getline("."), col(".") - 2, 2)
	let in = stridx(" {", str[0])
	return (in == stridx(" }", str[1]) && in > 0) ? "\<RETURN>\<ESC>kA" : ""
endf

ino ( ()<Esc>i
ino [ []<Esc>i
ino { {}<Esc>i
"au Syntax html,vim ino < <lt>><Esc>i| ino > <C-R>=ClosePair('>')<CR>

ino ) <c-r>=ClosePair(')')<CR>
im ] <c-r>=ClosePair(']')<CR>
"ino } <c-r>=ClosePair('}')<CR>
"ino " <c-r>=DonQuiquote('"')<CR>
"ino " "<ESC>:call DonQuiquote('"')<CR>
"ino ' <c-r>=DonQuiquote("'")<CR>

" disable when editing .vimrc files
au Syntax vim ino " "
au Syntax vim ino ' '

function! RemoveWhitespace()
	if ! &bin | silent! %s/\s\+$//ge | endif
endf

function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function! QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		"Inserting a quoted quotation mark into the string
		return a:char
		"return a:char."\<Esc>bi".a:char
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		"Starting a string
		return a:char.a:char."\<Esc>i"
	endif
endf
