" Improved mode!
set nocompatible

" Neobundle stuff
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

" Stop littering everywhere with backups
" Now more portable!
set backupdir=~/tmp,/var/tmp,$HOME/Local\ Settings\/Temp

" One directory for swapfiles
set directory=~/.vimswp//,$HOME/Local\ Settings\/Temp//

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
imap <S-Insert> <Esc>a<Space><Esc>"+gPxi
cmap <S-Insert> <C-R>+

" For keypad — Specific to ASUS G73JW keyboard, which
"  somehow 'swaps' between numlock-on and numlock-off when
"  the shift key is pressed
" NOTE: On an ASUS G74SX these seem to work well, except for
"  the lack of actual kDel/kInsert keys
vnoremap <S-kDel> "+x
vnoremap <C-S-kInsert> "+y
map <S-kInsert> "+gP
imap <S-kInsert> <Esc>a<Space><Esc>"+gPxi
cmap <S-kInsert> <C-R>+

" Buffers - explore/next/previous: Alt-F12, F12, Shift-F12
"nnoremap <silent> <M-F12> :BufExplorer<CR>
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>

" Open/Close folds
nnoremap <silent> + zo
nnoremap <silent> - zc

" Duplicate current line
nmap <C-D> YPj$

" Convert markdown to HTML
nmap <leader>md :%!markdown --html4tags<CR>

" Easily close HTML tags
" http://vim.wikia.com/wiki/Auto_closing_an_HTML_tag
inoremap <C-Z> </<C-X><C-O>

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
runtime! ftplugin/man.vim               " Manpage support

" When reopening a file, return to the last spot
au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" Omnicomplete thing
if exists("+omnifunc")
    au Filetype *
        \   if &omnifunc == "" |
        \       setlocal omnifunc=syntaxcomplete#Complete |
        \   endif
endif

" Change working directory to the current buffer's file
function! CHANGE_CURR_DIR()
    let _dir = expand("%:p:h")
    exec "cd " . escape(_dir,' ')
    unlet _dir
endfunction

"au BufEnter * call CHANGE_CURR_DIR()

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
let g:SuperTabNoCompleteAfter = ['^','\.',':','\s']
let g:SUperTabCrMapping = 0
au FileType javascript let b:SuperTabNoCompleteAfter = ['^',':','\s']
au FileType vim let b:SuperTabNoCompleteAfter = ['^',':','\s']

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=0
let NERDTreeIgnore=['\.git', '\.hg', '\.bzr', '\.svn', '\.cvs']
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <S-F3> :NERDTreeFind<CR>

" FastWordCompleter
nmap <Leader>fw :FastWordCompletionStart<CR>
nmap <Leader>fs :FastWordCompletionStop<CR>

" Snipmate disable extra mappings
let g:snips_disable_extra_mappings = 1

" UltiSnips config
let g:UltiSnips = {}
let g:UltiSnips.ExpandTrigger = "<C-J>"
let g:UltiSnips.UltiSnips_ft_filter = { 'default' : { 'filetypes' : ['all'] } }
let g:UltiSnips.always_use_first_snippet = 1

" Powerline
let g:Powerline_symbols = "unicode"

" Airline
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '¶ '
let g:airline_branch_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'

" Unite.vim
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom_source('file_rec,file_rec/async,grep',
    \ 'ignore_pattern',
    \ '\(node_modules\|dist\|.tmp\|app/bower_components\)/\.*')
let g:unite_prompt='» '

if executable('ack')
    let g:unite_source_rec_async_command = 'ack -f --nofilter'
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '--no-heading --no-color -a -C4'
    let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <C-P> :Unite -start-insert -toggle -auto-resize file_rec/async<CR>
nnoremap <C-F12> :Unite -toggle file_mru<CR>
nnoremap <M-F12> :Unite -toggle -quick-match buffer<CR>

" emmet-vim
inoremap <C-E> <plug>EmmetExpandAbbr<CR>
nnoremap <C-E> <plug>EmmetExpandAbbr<CR>
vnoremap <C-E> <plug>EmmetExpandAbbr<CR>

inoremap <C-S-E> <plug>EmmetExpandWord<CR>
nnoremap <C-S-E> <plug>EmmetExpandWord<CR>
vnoremap <C-S-E> <plug>EmmetExpandWord<CR>

" Indent Guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Session auto-save
let g:session_autosave = 'no'

" Fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gr :Gremove<CR>

" Ragtag
"let g:ragtag_global_maps = 1

" Easy Align
vnoremap <silent> <C-L> :EasyAlign<CR>

" Delimitmate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:}"

