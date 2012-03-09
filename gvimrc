" GUI-only preferences

set guioptions=aegimrL

" Helper function for GTK
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 32
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
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

" Ctrl-Up/Down to scale font
if has("gui_gtk2") && has("gui_running")
    nmap <C-Up> :LargerFont<CR>
    nmap <C-Down> :SmallerFont<CR>
endif

" Automatically try to resize window on startup to a decent size
if has("gui_running")
    autocmd GUIEnter * set lines=50 columns=100
endif

" Fonts
if has("gui_gtk2") && has("gui_running")
    set guifont=Menlo\ 10
elseif has("gui_win32") && has("gui_running")
    set guifont=Andale\ Mono:h10:cANSI
endif

" This causes issues in terminal vim
" Clear search highlights on <Esc>
nnoremap <silent> <Esc> :noh<CR><Esc>
