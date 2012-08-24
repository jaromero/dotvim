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

" github bundles
Bundle 'altercation/vim-colors-solarized'
Bundle 'Bogdanp/quicksilver.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'honza/snipmate-snippets'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'Lokaltog/vim-powerline'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'othree/html5.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'rstacruz/sparkup', {'rtp':'vim/'}
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sickill/vim-monokai'
Bundle 'sjbach/lusty'
Bundle 'tomtom/tlib_vim'
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
Bundle 'git@github.com:jaromero/vim-snipmate'


filetype plugin indent on     " required!

