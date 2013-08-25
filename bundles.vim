set nocompatible               " be iMproved

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage itself
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended
" After installing, cd to ~/.vim/bundle/vimproc and make -f <OS>
NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \   'unix' : 'make -f make_unix.mak',
    \   },
    \ }

" vim-scripts bundles
"NeoBundle 'bufexplorer.zip'

" Non-github
NeoBundle 'git://git.wincent.com/command-t.git'

" github bundles
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'amiorin/vim-project'
NeoBundle 'Bogdanp/quicksilver.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'chriskempson/base16-vim'
"NeoBundle 'ervandew/supertab'
"NeoBundle 'garbas/vim-snipmate'
NeoBundle 'godlygeek/tabular'
NeoBundle 'groenewege/vim-less'
NeoBundle 'honza/vim-snippets'
NeoBundle 'jelera/vim-javascript-syntax'
"NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'kchmck/vim-coffee-script'
"NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'MarcWeber/ultisnips'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'mintplant/vim-literate-coffeescript'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'othree/html5.vim'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
"NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'walm/jshint.vim'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session'

" Personal bundles
NeoBundle 'git@github.com:jaromero/vim-monokai-refined'


filetype plugin indent on     " required!

" Installation check
NeoBundleCheck
