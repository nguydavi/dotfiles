set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'Shougo/vimproc.vim'         " required for vim-vebugger
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'artur-shaik/vim-javacomplete2'
    Plugin 'vim-airline/vim-airline'
    Plugin 'fatih/vim-go'
    Plugin 'idanarye/vim-vebugger'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'mileszs/ack.vim'
    Plugin 'octol/vim-cpp-enhanced-highlight'
    Plugin 'rust-lang/rust.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'tpope/vim-abolish'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'tpope/vim-vinegar'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'xolox/vim-easytags'
    Plugin 'xolox/vim-misc'

call vundle#end()            " required
filetype plugin indent on    " required

colorscheme darkblue

" Load custom settings
source ~/.vim/boot/commands.vim
source ~/.vim/boot/mappings.vim
source ~/.vim/boot/plugins.vim
source ~/.vim/boot/settings.vim
