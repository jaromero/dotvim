set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage itself
Bundle 'gmarik/vundle'

" vim-scripts bundles
Bundle 'Command-T'
Bundle 'bufexplorer.zip'
Bundle 'mru.vim'
Bundle 'vim-coffee-script'

" github bundles
Bundle 'altercation/vim-colors-solarized'
Bundle 'Bogdanp/quicksilver.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'groenewege/vim-less'
Bundle 'honza/vim-snippets'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'MarcWeber/ultisnips'
"Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'mattn/zencoding-vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'othree/html5.vim'
Bundle 'Raimondi/delimitMate'
"Bundle 'rstacruz/sparkup', {'rtp':'vim/'}
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sickill/vim-monokai'
Bundle 'sjbach/lusty'
"Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'walm/jshint.vim'
Bundle 'xolox/vim-session'

" Personal bundles
Bundle 'git@github.com:jaromero/vim-monokai-refined'
"Bundle 'git@github.com:jaromero/vim-snipmate'


filetype plugin indent on     " required!

