" vim: fdm=marker fmr={{{,}}} fdl=0

set nocompatible
filetype off

" Detect OS {{{
    let s:is_windows = has('win32') || has('win64')
    let s:is_osx = has('gui_macvim')
" }}}

" NeoBundle startup {{{
if has('vim_starting')
    set rtp+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \   'unix' : 'make -f make_unix.mak'
    \   },
    \ }
" }}}

" Helper functions {{{
function! Preserve(command) "{{{
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction "}}}
function! StripTrailingWhitespace() "{{{
    call Preserve("%s/\\s\\+$//e")
endfunction "}}}
function! EnsureExists(path) "{{{
    if !isdirectory(expand(a:path))
      call mkdir(expand(a:path))
    endif
endfunction "}}}
function! CloseWindowOrKillBuffer() "{{{
    let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

    " never bdelete a nerd tree
    if matchstr(expand("%"), 'NERD') == 'NERD'
      wincmd c
      return
    endif

    if number_of_windows_to_this_buffer > 1
      wincmd c
    else
      bdelete
    endif
endfunction "}}}
function! ChangeCurrDir() "{{{
    let _dir = expand("%:p:h")
    exec "cd " . escape(_dir,' ')
    unlet _dir
endfunction "}}}
"}}}

" Basic editor preferences {{{
set autoread
set encoding=utf-8
set errorbells
set hidden
set history=500
set iskeyword=@,48-57,_,192-255
set keymodel=startsel,stopsel
set modeline
set mousemodel=popup
set nomousehide
set nosol
set ruler
set scrolloff=3
set selectmode=mouse,key
set shortmess=filmnrxtToO
set showcmd
set viewoptions=folds,options,cursor,unix,slash
set viminfo+=!
set whichwrap=b,s,<,>,[,]

if has('mouse')
    set mouse=a
endif

" Whitespace
set backspace=indent,eol,start
set autoindent
set smartindent
set listchars=eol:$,tab:→\ ,trail:_,extends:»,precedes:«,nbsp:·
set linebreak
let &showbreak = '» '

" Work with spaces instead of tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

" Wild options
set wildmenu
set wildmode=list:longest:full

" Windows
set splitbelow
set splitright

" Searching
set hlsearch
set incsearch
set smartcase
if executable('ack')
    set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
    set grepformat=%f:%l:%c:%m
endif

" File/folder management {{{

" Persistent undo
if exists('+undofile')
    set undofile
    set undodir=~/.vim/.cache/undo
endif

" Backups and swap
set backup
set backupcopy=auto

if s:is_windows
    set backupdir=$HOME/Local\ Settings\/Temp
    set directory=$HOME/Local\ Settings\/Temp//
else
    set backupdir=~/tmp
    set directory=~/.vim/.cache/swap//
endif

call EnsureExists('~/.vim/.cache')
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)

" Wildignore
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll
set wildignore+=.git/*,.bzr/*,.hg/*,.svn/*
set wildignore+=.DS_Store,__MACOSX/*,Thumbs.db
set wildignore+=.sass-cache/*,.cache/*,.tmp/*,*.scssc

" }}}

" Leader
let mapleader=","
let g:mapleader=","

" }}}

" Visual config {{{
set showmatch
set number
set laststatus=2
set cul
set nocuc

" Folds {{{
set foldenable
set foldmethod=syntax
set foldlevelstart=99

let g:xml_syntax_folding=1
let g:perl_fold=1
" }}}

if has('conceal')
    set conceallevel=1
    set listchars+=conceal:△
endif

if has('gui_running') " {{{
    set guioptions=aegimrL

    au GUIEnter * set lines=45 columns=90

    " This causes issues in terminal vim, so it's here
    " Clear search highlights on <esc>
    nnoremap <silent> <Esc> :noh<CR><Esc>

    " Fonts
    if has('gui_gtk')
        set guifont=Meslo\ LG\ S\ for\ Powerline\ 11
    elseif has('gui_win32') || has('gui_win64')
        set guifont=Andale\ Mono:h10:cANSI
    endif

    " Font size adjusting {{{
    if has('gui_gtk')
        let s:pattern     = '^\(.* \)\([1-9][0-9]*\)$'
    elseif s:is_windows
        let s:pattern     = '^\(.*:h\)\([1-9][0-9]*\)\(:.*\)?$'
    endif
    let s:minfontsize = 6
    let s:maxfontsize = 32

    function! AdjustFontSize(amount)
        let fontname = substitute(&guifont, s:pattern, '\1', '')
        let cursize  = substitute(&guifont, s:pattern, '\2', '')
        let newsize  = cursize + a:amount
        if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
            let newfont  = fontname . newsize
            let &guifont = newfont
        endif
    endfunction

    function! LargerFont()
        call AdjustFontSize(1)
    endfunction
    command! LargerFont call LargerFont()

    function! SmallerFont()
        call AdjustFontSize(-1)
    endfunction
    command! SmallerFont call SmallerFont()

    nmap <C-Up> :LargerFont<CR>
    nmap <C-Down> :SmallerFont<CR>
    " }}}
" }}}
else " {{{
    if $COLORTERM == 'gnome-terminal'
        set t_co=256
    endif
endif "}}}

" }}}

" Plugins {{{

" Utilities {{{
    NeoBundle 'Shougo/context_filetype.vim'
    NeoBundle 'michaeljsmith/vim-indent-object'
    NeoBundle 'tpope/vim-fugitive' "{{{
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>gx :Gremove<CR>

        au BufReadPost fugitive://* set bufhidden=delete
    "}}}
    NeoBundle 'tpope/vim-dispatch'
    "NeoBundle 'mhinz/vim-startify' "{{{
        "let g:startify_session_dir   = '~/.vim/.cache/startify'
        "let g:startify_show_sessions = 1
        "nnoremap <M-F1> :Startify<CR>
    " }}}
    NeoBundleLazy 'guns/xterm-color-table.vim', {'autoload':{'commands':'XtermColorTable'}}
" }}}

" Edition {{{
    NeoBundle 'mattn/emmet-vim' "{{{
        let g:user_emmet_expandabbr_key = '<C-E>'
        let g:user_emmet_expandword_key = '<C-S-E>'
        let g:user_emmet_settings       = {
            \ 'html' : {
            \   'empty_element_suffix' : '>'
            \   }
            \ }
    "}}}
    NeoBundle 'scrooloose/nerdcommenter'
    NeoBundle 'tpope/vim-repeat'
    NeoBundle 'tpope/vim-speeddating'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'tpope/vim-unimpaired' "{{{
        nmap <C-S-Up> [e
        nmap <C-S-Down> ]e
        vmap <C-S-Up> [egv
        vmap <C-S-Down> ]egv
    "}}}
    NeoBundle 'godlygeek/tabular' "{{{
        nmap <leader>a= :Tabularize /=<CR>
        vmap <leader>a= :Tabularize /=<CR>
        nmap <leader>a: :Tabularize /:\zs<CR>
        vmap <leader>a: :Tabularize /:\zs<CR>

        au FileType css,sass,scss,scss.css nmap <buffer> <leader>aa :Tabularize /:\zs<CR>
        au FileType css,sass,scss,scss.css vmap <buffer> <leader>aa :Tabularize /:\zs<CR>

        au FileType javascript,coffee nmap <buffer> <leader>aa :Tabularize /:\zs<CR>
        au FileType javascript,coffee vmap <buffer> <leader>aa :Tabularize /:\zs<CR>
        au FileType javascript,coffee nmap <buffer> <leader>az :Tabularize /=<CR>
        au FileType javascript,coffee vmap <buffer> <leader>az :Tabularize /=<CR>
    "}}}
    "NeoBundle 'junegunn/vim-easy-align' "{{{
        "vnoremap <silent> <C-Enter> :EasyAlign<CR>
    "}}}
    NeoBundle 'Raimondi/delimitMate' "{{{
        let delimitMate_expand_cr    = 1
        let delimitMate_expand_space = 1

        au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:}"

        imap <expr> <CR> pumvisible() ? "\<C-Y>" : "<plug>delimitMateCR"
    "}}}
" }}}

" Autocomplete and snippets {{{
    NeoBundle 'honza/vim-snippets'
    "NeoBundle 'ervandew/supertab' "{{{
        "let g:SuperTabDefaultCompletionType                  = 'context'
        "let g:SuperTabNoCompleteAfter                        = ['^','\.',':','\s']
        "let g:SUperTabCrMapping                              = 0
        "au FileType javascript let b:SuperTabNoCompleteAfter = ['^',':','\s']
        "au FileType vim let b:SuperTabNoCompleteAfter        = ['^',':','\s']
    "}}}
    "NeoBundle 'garbas/vim-snipmate' "{{{
        "let g:snips_disable_extra_mappings = 1
    "}}}
    "NeoBundle 'Valloric/YouCompleteMe', {'vim_version':'7.3.584'} "{{{
        "let g:ycm_complete_in_comments_and_strings = 1
        "let g:ycm_key_list_select_completion       = ['<C-N>', '<Down>']
        "let g:ycm_key_list_previous_completion     = ['<C-P>', '<Up>']
        "let g:ycm_filetype_blacklist               = {'unite': 1}
        "let g:ycm_autoclose_preview_window_after_completion = 1
    "}}}
    "NeoBundle 'MarcWeber/ultisnips' "{{{
        "let g:UltiSnips                          = {}
        "let g:UltiSnips.ExpandTrigger            = '<tab>'
        "let g:UltiSnips.JumpForwardTrigger       = '<tab>'
        "let g:UltiSnips.JumpBackwardTrigger      = '<S-tab>'
        ""let g:UltiSnips.always_use_first_snippet = 1
        ""let g:UltiSnipsSnippetsDir               = '~/.vim/snippets'

        "function! g:UltiSnips_Complete()
            "call UltiSnips_ExpandSnippet()
            "if g:ulti_expand_res == 0
                "if pumvisible()
                    "return "\<C-N>"
                "else
                    "call UltiSnips_JumpForwards()
                    "if g:ulti_jump_forward_res == 0
                        "return "\<tab>"
                    "endif
                "endif
            "endif
            "return ""
        "endfunction

        "au BufEnter * exec "silent inoremap <silent> " . g:UltiSnips.ExpandTrigger . "<C-R>=g:UltiSnips_Complete()<CR>"

        "let g:UltiSnips.ListSnippets="<C-L>"
        ""let g:UltiSnipsSnippetDirectories = ["UltiSnips", "ultisnips-snippets"]
        "let g:UltiSnips.UltiSnips_ft_filter = {
            "\ 'default': {'filetypes': ["FILETYPE"]},
            "\ 'scss': {'filetypes': ["css"]},
            "\ 'sass': {'filetypes': ["css"]},
            "\ 'scss.css': {'filetypes': ["css"]},
            "\ }   
    "}}}
    NeoBundle 'Shougo/neosnippet.vim' "{{{
        imap <expr><tab> neosnippet#expandable_or_jumpable() ?
            \ "\<plug>(neosnippet_expand_or_jump)"
            \ : pumvisible() ? "\<C-N>" : "\<tab>"
        smap <expr><tab> neosnippet#expandable_or_jumpable() ?
            \ "\<plug>(neosnippet_expand_or_jump)"
            \ : "\<tab>"
        imap <expr><S-tab> pumvisible() ? "\<C-P>" : ""
        smap <expr><S-tab> pumvisible() ? "\<C-P>" : ""
        let g:neosnippet#enable_snipmate_compatibility = 1
        let g:neosnippet#snippets_directory            = '~/.vim/bundle/vim-snippets/snippets'

        au FileType sass.scss,scss.css NeoSnippetSource ~/.vim/bundle/vim-snippets/snippets/css.snippets
    "}}}
    NeoBundleLazy 'Shougo/neocomplete.vim', {'autoload':{'insert':1}, 'vim_version':'7.3.885'} "{{{
        let g:neocomplete#enable_at_startup                 = 1
        let g:neocomplete#enable_smart_case                 = 1
        let g:neocomplete#auto_completion_start_length      = 3
        let g:neocomplete#enable_auto_select                = 1
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#data_directory                    = '~/.vim/.cache/neocomplete'
    "}}}
" }}}

" Navigation {{{
    "NeoBundle 'Bogdanp/quicksilver.vim'
    NeoBundleLazy 'scrooloose/nerdtree', {'autoload':{'commands':['NERDTreeToggle','NERDTreeFind']}} "{{{
        let NERDTreeShowHidden    = 1
        let NERDTreeQuitOnOpen    = 0
        let NERDTreeShowBookmarks = 1
        "let NERDTreeIgnore        = ['\.git', '\.hg', '\.bzr', '\.svn', '\.cvs']
        let NERDTreeBookmarksFile = '~/.vim/.cache/NERDTreeBookmarks'
        nnoremap <F3> :NERDTreeToggle<CR>
        nnoremap <S-F3> :NERDTreeFind<CR>
    "}}}
    "NeoBundle 'git://git.wincent.com/command-t.git' "{{{
        "let g:CommandTMaxHeight        = 20
        "let g:CommandTMinHeight        = 5
        "let g:CommandTMatchWindowAtTop = 1
        "nnoremap <C-P> :CommandT<CR>
        "nnoremap <M-F12> :CommandTBuffer<CR>
    "}}}
    NeoBundle 'kien/ctrlp.vim' "{{{
        let g:ctrlp_map                 = '<C-P>'
        let g:ctrlp_cmd                 = 'CtrlPMixed'
        let g:ctrlp_working_path_mode   = 'ra'
        let g:ctrlp_switch_buffer       = 'et'
        let g:ctrlp_use_caching         = 1
        let g:ctrlp_mruf_max            = 250
        let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/](\.(git|hg|svn|build|sass-cache|tmp|cache)|dist|node_modules|__MAC_OSX)$',
            \ 'file': '\v(\.(exe|so|dll|scssc)|Thumbs.db|.DS_Store)$',
            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
            \ }
        let g:ctrlp_match_window        = 'top,order:ttb,min:10,max:10,results:40'
        let g:ctrlp_clear_cache_on_exit = 0
        let g:ctrlp_show_hidden         = 1
        let g:ctrlp_follow_symlinks     = 1
        let g:ctrlp_working_path_mode   = 0
        let g:ctrlp_max_files           = 20000
        let g:ctrlp_cache_dir           = '~/.vim/.cache/ctrlp'

        function! MyPrtMappings()
            let g:ctrlp_prompt_mappings = {
                \ 'AcceptSelection("e")': ['<CR>', '<2-LeftMouse>'],
                \ 'AcceptSelection("t")': ['<C-T>'],
                \ }
        endfunction

        function! MyCtrlPTag()
            let g:ctrlp_prompt_mappings = {
                \ 'AcceptSelection("e")': ['<CR>', '<2-LeftMouse>'],
                \ 'AcceptSelection("t")': ['<C-T>'],
                \ }
            CtrlPBufTag
        endfunction

        let g:ctrlp_buffer_func = { 'exit': 'MyPrtMappings' }
        command! MyCtrlPTag call MyCtrlPTag()

        let g:ctrlp_buftag_types = {
            \ 'go': '--language-force=go --golang-types=ftv',
            \ 'coffee': '--language-force=coffee --coffee-types=cmfvf',
            \ 'markdown': '--language-force=markdown --markdown-types=hik',
            \ }

        nnoremap <M-F12> :CtrlPMRU<CR>
        nnoremap <C-F12> :CtrlPBuffer<CR>
    " }}}
" }}}

" Unite.vim {{{
    NeoBundle 'Shougo/unite.vim' "{{{
        call unite#filters#matcher_default#use(['matcher_fuzzy'])
        call unite#filters#sorter_default#use(['sorter_rank'])
        call unite#custom#source('file_rec,file_rec/async,grep',
            \ 'ignore_pattern',
            \ '\(\.git\|\.svn\|\.bzr\|\.hg\|\.tmp\|dist\|node_modules\|app/bower_components\|app/components\|\.sass-cache\|\.cache\)/\.*')
        let g:unite_prompt = '» '
        let g:unite_data_directory = '~/.vim/.cache/unite'
        let g:unite_source_rec_max_cache_files = 5000

        if executable('ack')
            let g:unite_source_rec_async_command = 'ack -f --nofilter'
            let g:unite_source_grep_command = 'ack'
            let g:unite_source_grep_default_opts = '--no-heading --no-color -a -C4'
            let g:unite_source_grep_recursive_opt = ''
        endif

        function! s:unite_settings()
            nmap <buffer> Q <plug>(unite_exit)
            nmap <buffer> <Esc> <plug>(unite_exit)
            imap <buffer> <Esc> <plug>(unite_exit)
        endfunction

        nnoremap <leader>pp :<C-U>Unite -start-insert -toggle -auto-resize -buffer-name=files file_rec/async<CR>
        nnoremap <leader>pm :<C-U>Unite -toggle -buffer-name=mru file_mru<CR>
        nnoremap <leader>pb :<C-U>Unite -toggle -quick-match -buffer-name=buffers buffer<CR>
        "nnoremap <C-F12> :<C-U>Unite -toggle -buffer-name=mru file_mru<CR>
        "nnoremap <M-F12> :<C-U>Unite -toggle -quick-match -buffer-name=buffers buffer<CR>

        nnoremap <leader>nbu :Unite neobundle/update -vertical -no-start-insert<CR>
    "}}}
    NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources':'colorscheme'}} " {{{
        nnoremap <leader>pc :<C-U>Unite -winheight=10 -auto-preview -buffer-name=colorschemes colorscheme<CR>
    " }}}
" }}}

" Information {{{
    NeoBundle 'bling/vim-airline' " {{{
        "let g:airline_left_sep          = '▶'
        "let g:airline_right_sep         = '◀'
        "let g:airline_linecolumn_prefix = '¶ '
        "let g:airline_branch_prefix     = '⎇ '
        "let g:airline_paste_symbol      = 'ρ'
        let g:airline_detect_whitespace  = 0
        let g:airline_powerline_fonts    = 1
        let g:airline_theme              = 'solarized'
    " }}}
    NeoBundle 'nathanaelkane/vim-indent-guides' "{{{
        let g:indent_guides_start_level          = 2
        let g:indent_guides_guide_size           = 1
        let g:indent_guides_color_change_percent = 3
    "}}}
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'walm/jshint.vim'
" }}}

" Improved sessions {{{
    NeoBundle 'xolox/vim-session', {'depends':'xolox/vim-misc'} "{{{
        set sessionoptions-=help
        let g:session_autosave         = 'no'
        let g:session_autoload         = 'no'
        let g:session_verbose_messages = 0
        let g:session_directory        = '~/.vim/.cache/sessions'
    "}}}
    NeoBundle 'amiorin/vim-project'
"}}}

" Syntax {{{
    NeoBundleLazy 'othree/html5.vim', {'autoload':{'filetypes':['html']}}
    NeoBundleLazy 'tpope/vim-markdown', {'autoload':{'filetypes':['markdown']}}
    NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
    NeoBundleLazy 'kchmck/vim-coffee-script', {'autoload':{'filetypes':['coffee']}}
    NeoBundleLazy 'mintplant/vim-literate-coffeescript', {'autoload':{'filetypes':['litcoffee']}}
    NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload':{'filetypes':['scss','sass']}}
    NeoBundleLazy 'groenewege/vim-less', {'autoload':{'filetypes':['less']}}
    NeoBundleLazy 'tpope/vim-markdown', {'autoload':{'filetypes':['markdown']}}
    NeoBundleLazy 'leshill/vim-json', {'autoload':{'filetypes':['json']}}
    NeoBundleLazy 'gregsexton/MatchTag', {'autoload':{'filetypes':['html','xml']}}
" }}}

" }}}

" Key maps and commands {{{
    " Ctrl+Tab is next window, Ctrl+Shift+Tab is previous
    noremap <C-Tab> <C-W>w
    inoremap <C-Tab> <C-O><C-W>w
    cnoremap <C-Tab> <C-O><C-W>w
    onoremap <C-Tab> <C-O><C-W>w

    noremap <C-S-Tab> <C-W>W
    inoremap <C-S-Tab> <C-O><C-W>W
    cnoremap <C-S-Tab> <C-O><C-W>W
    onoremap <C-S-Tab> <C-O><C-W>W

    " cd here
    command! CDhere call ChangeCurrDir()

    " Close window, or delete buffer
    noremap <C-F4> :call CloseWindowOrKillBuffer()<CR>
    noremap <leader>q :call CloseWindowOrKillBuffer()<CR>

    " Backspace in visual mode deletes selection
    vnoremap <BS> d

    " Shift+Del for cut, Ctrl+Ins for copy, Shift+Ins for paste
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

    " Buffers - next/previous: F12, Shift-F12
    nnoremap <silent> <F12> :bn<CR>
    nnoremap <silent> <S-F12> :bp<CR>

    " Open/Close folds
    nnoremap <silent> + zo
    nnoremap <silent> - zc

    " Duplicate current line
    nmap <C-D> YPj$

    " Quickly sort selection
    vmap <leader>s :sort<CR>

    " Convert markdown to HTML
    if executable('markdown')
        nmap <leader>md :%!markdown --html4tags<CR>
    endif

    " Smart home key
    " http://vim.wikia.com/wiki/Smart_home
    noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
    imap <Home> <C-O><Home>

    " Quickly toggle set list
    nmap <leader>l :set list!<CR>

    " Reselect block after indent
    vnoremap < <gv
    vnoremap > >gv

    " Show syntax highlighting group for word under cursor
    function! <SID>SynStack()
        if !exists('*synstack')
            return
        endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunction
    nnoremap <C-S-I> :call <SID>SynStack()<CR>

" }}}

" autocmd {{{
    " Go back to previous cursor position
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \  exe 'normal! g`"zvzz' |
        \ endif

    " Easily close HTML tags
    " http://vim.wikia.com/wiki/Auto_closing_an_HTML_tag
    au FileType html,xml inoremap <buffer> <C-Z> </<C-X><C-O>

    au FileType coffee setl fdm=indent
    au FileType markdown setl nolist
    au FileType python setl fdm=indent
    au FileType text setl textwidth=78
    au FileType vim setl fdm=indent keywordprg=:help

    " Define additional filetypes
    au BufRead,BufNewFile *.wiki setf Wikipedia
    au BufRead,BufNewFile *.lsl setf LSL
    au BufRead,BufNewFile *conkyrc* setf conkyrc
    au BufRead,BufNewFile *.ds setf scheme
" }}}

" Colorschemes {{{
    set bg=dark

    NeoBundle 'altercation/vim-colors-solarized' "{{{
        let g:solarized_termcolors = 256
        let g:solarized_termtrans  = 1
        let g:solarized_contrast   = "high"
        let g:solarized_hitrail    = 1
        let g:solarized_visibility = "low"
    "}}}
    NeoBundle 'chriskempson/base16-vim'
    NeoBundle 'sickill/vim-monokai'
    NeoBundle 'jaromero/vim-monokai-refined'

    colors solarized
" }}}

" Finish loading {{{
    filetype plugin indent on
    syntax on
    NeoBundleCheck
" }}}

