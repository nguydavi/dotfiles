set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'bling/vim-airline'
    Plugin 'kien/ctrlp.vim'
    " Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
    " Plugin 'scrooloose/nerdtree'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-vinegar'

    " Vim color schemes
    "Plugin 'altercation/vim-colors-solarized'
    "Plugin 'duythinht/inori'
    "Plugin 'duythinht/vim-coffee'
    "Plugin 'gosukiwi/vim-atom-dark'
    "Plugin 'sickill/vim-sunburst'
    "Plugin 'tomasr/molokai'
    "Plugin 'whatyouhide/vim-gotham'
    Plugin 'yantze/pt_black'

call vundle#end()            " required
filetype plugin indent on    " required

colorscheme pt_black

" Load custom settings
source ~/.vim/boot/commands.vim
source ~/.vim/boot/mappings.vim
source ~/.vim/boot/plugins.vim
source ~/.vim/boot/settings.vim
