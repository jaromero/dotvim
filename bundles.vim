set nocompatible               " be iMproved

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage itself
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended
" After installing, cd to ~/.vim/bundle/vimproc and make -f <OS>
NeoBundle 'Shougo/vimproc'

" vim-scripts bundles
"NeoBundle 'bufexplorer.zip'
NeoBundle 'vim-coffee-script'

" Non-github
NeoBundle 'git://git.wincent.com/command-t.git'

" github bundles
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Bogdanp/quicksilver.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'godlygeek/tabular'
NeoBundle 'groenewege/vim-less'
NeoBundle 'honza/vim-snippets'
NeoBundle 'jelera/vim-javascript-syntax'
"NeoBundle 'kien/ctrlp.vim'
NeoBundle 'MarcWeber/ultisnips'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'othree/html5.vim'
NeoBundle 'Raimondi/delimitMate'
"NeoBundle 'rstacruz/sparkup', {'rtp':'vim/'}
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'sjbach/lusty'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'walm/jshint.vim'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session'

" Personal bundles
NeoBundle 'git@github.com:jaromero/vim-monokai-refined'


filetype plugin indent on     " required!

" Installation check
NeoBundleCheck
