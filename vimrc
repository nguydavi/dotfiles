set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    " Completion
    Plugin 'ervandew/supertab'
    Plugin 'github/copilot.vim'
    Plugin 'girishji/vimcomplete'
    Plugin 'girishji/vimsuggest'
    Plugin 'yegappan/lsp'

    " Motion
    Plugin 'Lokaltog/vim-easymotion'

    " Search & Files
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'mileszs/ack.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'tpope/vim-vinegar'

    " Specific for a filetype
    Plugin 'Einenlum/yaml-revealer'
    Plugin 'tpope/vim-fugitive'

    " Theme
    Plugin 'catppuccin/vim'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'

    " Utilities when updating text/code
    Plugin 'tpope/vim-abolish'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-unimpaired'


call vundle#end()            " required
filetype plugin indent on    " required

colorscheme catppuccin_macchiato

" Load custom settings
source ~/.vim/boot/commands.vim
source ~/.vim/boot/mappings.vim
source ~/.vim/boot/plugins.vim
source ~/.vim/boot/settings.vim
