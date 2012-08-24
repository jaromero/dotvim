" Improved mode!
set nocompatible

" Vundle stuff
source ~/.vim/bundles.vim

" Basic editor preferences
set showcmd
set history=2000
set ruler
set backup
set backupcopy=auto
set modeline
set scrolloff=3
set incsearch
set mousemodel=popup
set selectmode=mouse,key
set keymodel=startsel,stopsel
set viminfo+=!
set shortmess=filmnrxtToO
set whichwrap=b,s,<,>,[,]
set iskeyword=@,48-57,_,192-255
set nosol
set linebreak
set showbreak=»\ 
set nomousehide
set errorbells
set hidden
set autoread
set number

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Non-printable characters
"set listchars=eol:$,tab:⇨\ ,trail:_,extends:»,precedes:«,nbsp:·
set listchars=eol:$,tab:▸\ ,trail:_,extends:»,precedes:«,nbsp:·

" Highlight cursor line and column
set cul
set nocuc


" Edition
set backspace=indent,eol,start
set encoding=utf-8

" Work with spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab


" Define additional filetypes
au BufRead,BufNewFile *.wiki setfiletype Wikipedia
au BufRead,BufNewFile *.lsl setfiletype LSL
au BufRead,BufNewFile *conkyrc* setfiletype conkyrc
au BufRead,BufNewFile *.ds setfiletype scheme

" Syntax options
let apache_version = "2.0"
let python_highlight_all = 1
let perl_fold = 1
"let php_folding = 1

" Plain text
au FileType text setlocal textwidth=78

" CSS
"au FileType css setl fdm=marker
"au FileType css setl fmr={,}


" Colors
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"let g:solarized_contrast="high"
"let g:solarized_hitrail=1
"let g:solarized_visibility="low"

set bg=dark
colors Monokai-Refined


" Print font
set printfont=DejaVu\ Sans\ Mono


" Status Line
"set statusline=             " Clearing the statusline.
"set statusline+=%02n\       " Buffer number
"set statusline+=%f          " Tail of full file path of current file in buffer.
"set statusline+=%m          " If file has been modified, [+], and [-] if modifiable is set to off.
"set statusline+=%r          " Readonly flag [RO]
"set statusline+=%h          " Help buffer flag [Help]
"set statusline+=%w\         " Preview window flag [Preview]
"set statusline+=[%{strlen(&ft)?&ft:'none'},  " Type of file in buffer.
"set statusline+=%{strlen(&fenc)?&fenc:&enc}, " File encoding
"set statusline+=%{&ff}]\    " File format (line endings)
"set statusline+=%=
"set statusline+=[%03.8b,    " ASCII code of char under cursor
"set statusline+=0x%02.4B]\  " Hex code. They both are of length 4 and 8 for unicode chars.
"set statusline+=[%04l/%04L, " current line / lines in file. %04 to keep it from flickering in small files.
"set statusline+=%02c,       " Column number
"set statusline+=%03p%%]     " Percentage through file. %03 again, to avoid flickering.
set laststatus=2


" Custom mappings
let mapleader = ","

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" Backspace in Visual mode deletes selection
vnoremap <BS> d

" SHIFT-Del for cut, Ctrl-Ins for copy, SHIFT-Ins for paste
vnoremap <S-Del> "+x
vnoremap <C-Insert> "+y
map <S-Insert> "+gP
imap <S-Insert> <Esc>"+gP
cmap <S-Insert> <C-R>+

" For keypad — Specific to ASUS G73JW keyboard, which
"  somehow 'swaps' between numlock-on and numlock-off when 
"  the shift key is pressed
vnoremap <S-kDel> "+x
vnoremap <C-S-kInsert> "+y
map <S-kInsert> "+gP
imap <S-kInsert> <Esc>a<Space><Esc>"+gPxi
cmap <S-kInsert> <C-R>+

" Buffers - explore/next/previous: Alt-F12, F12, Shift-F12
nnoremap <silent> <M-F12> :BufExplorer<CR> 
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>

" Open/Close folds
nnoremap <silent> + zo
nnoremap <silent> - zc

" Duplicate current line
nmap <C-D> YPj$

" Convert markdown to HTML
nmap <leader>md :%!markdown --html4tags<CR>

" Smart home key
" http://vim.wikia.com/wiki/Smart_home
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
imap <Home> <C-O><Home>

" Quickly toggle set list
nmap <leader>l :set list!<CR>

" Bubbling text with unimpaired.vim
nmap <C-S-Up> [e
nmap <C-S-Down> ]e
vmap <C-S-Up> [egv
vmap <C-S-Down> ]egv


" Functions and Auto-commands
runtime! ftplugin/man.vim	            " Manpage support

" When reopening a file, return to the last spot
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" Omnicomplete thing
if exists("+omnifunc")
    au Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
endif

" Change working directory to the current buffer's file
function! CHANGE_CURR_DIR()
	let _dir = expand("%:p:h")
	exec "cd " . escape(_dir,' ')
	unlet _dir
endfunction

au BufEnter * call CHANGE_CURR_DIR()

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabNoCompleteAfter = ['\.',':','\s']
au FileTYpe javascript let b:SuperTabNoCompleteAfter = [':','\s']
au FileTYpe vim let b:SuperTabNoCompleteAfter = [':','\s']

" NERDTree
map <F3> :NERDTreeToggle<CR>

" FastWordCompleter
nmap <Leader>fw :FastWordCompletionStart<CR>
nmap <Leader>fs :FastWordCompletionStop<CR>

" Snipmate disable extra mappings
let g:snips_disable_extra_mappings = 1

" Powerline
let g:Powerline_symbols = "unicode"

" Indent Guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Do not create swap files on remote (or any) gvfs directory, or on ~/Dropbox
au BufRead,BufNewFile /home/nsdragon/.gvfs/* setl noswapfile
au BufRead,BufNewFile /home/nsdragon/Dropbox/* setl noswapfile

