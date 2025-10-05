" Standard vim options
set autoindent                " always set autoindenting on
set background=dark           " dark backgruond
set backspace=2               " allow backspacing over everything in insert mode
set cindent                   " c code indenting
set colorcolumn=121           " show red column at 121st column
set cursorline                " show a line below current line
set diffopt=filler,iwhite     " keep files synced and ignore whitespace
set expandtab                 " Get rid of tabs altogether and replace with spaces
set foldcolumn=0              " set a column incase we need it
set foldlevel=0               " show contents of all folds
set foldmethod=indent         " use indent unless overridden
set guioptions-=m             " Remove menu from the gui
set guioptions-=T             " Remove toolbar
set hidden                    " hide buffers instead of closing
set history=50                " keep 50 lines of command line history
set hlsearch                  " highlight all matching pattern
set ignorecase                " Do case insensitive matching
set incsearch                 " Incremental search
set laststatus=2              " always have status bar
set linebreak                 " This displays long lines as wrapped at word boundries
set matchtime=10              " Time to flash the brack with showmatch
set nobackup                  " Don't keep a backup file
set nocompatible              " Use Vim defaults (much better!)
set nofen                     " disable folds
set noshowmode                " do not show what mode we are in
set noswapfile                " disable swap files
set notimeout                 " i like to be pokey
set number                    " show line numbers
set pastetoggle=<F2>          " Switch for paste mode
set ttimeout                  " timeout on key-codes
set ttimeoutlen=100           " timeout on key-codes after 100ms
set ruler                     " the ruler on the bottom is useful
set scrolloff=1               " dont let the curser get too close to the edge
set shiftwidth=4              " Set indention level to be the same as softtabstop
set showcmd                   " Show (partial) command in status line.
set showmatch                 " Show matching brackets.
set softtabstop=4             " Why are tabs so big?  This fixes it
set tabstop=4                 " Make sure tab are 4 spaces
set textwidth=120             " This wraps a line with a break when you reach 80 chars
set shiftwidth=4              " Goes along with tabstop
set virtualedit=block         " let blocks be in virutal edit mode
set wildmenu                  " This is used with wildmode(full) to cycle options

" Longer Set options
set listchars=tab:▸\ ,eol:¬                  " prefix tabs with a > and trails with - in list mode
set whichwrap+=h,l                           " arrow keys can wrap in normal and insert modes
set wildmode=list:longest,full               " list all options, match to the longest

set helpfile=$VIMRUNTIME/doc/help.txt
set path+=.,..,../..,../../..,../../../..,/usr/include

set completeopt=menu,menuone,noinsert,noselect  " prevents auto-insert of first match

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files I am not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.class

" LargeFile.vim settings
" don't run syntax and other expensive things on files larger than NUM megs
let g:LargeFile = 100

" Turn on syntax highlighting
syntax on

" For better colorschemes
set termguicolors
