" Set Space as Leader (not using mapleader so that it appears in showcmd in later version of Vim)
let mapleader = " "
map <Space> <Leader>

" Clipboard
nnoremap <Leader>C "+yy     " Copy current line to system clipboard
nnoremap <Leader>v "+p      " Paste from system clipboard
vnoremap <Leader>c "+y

" Unmap the arrow keys
noremap <down> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>
noremap <up> <Nop>
inoremap <down> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>
inoremap <up> <Nop>
vnoremap <down> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>
vnoremap <up> <Nop>

" Buffers
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
nnoremap <Leader>w :bp\|bd #<CR>    " Close current buffer and go to previous

" Replace word under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>r :s/\<\>//g<Left><Left><Left><Left><Left>
" Keep capitalization with abolish plugin
nnoremap <Leader>R :%S/<C-r><C-w>//g<Left><Left>
vnoremap <Leader>R :S///g<Left><Left><Left><Left><Left>

" Remove highlighting
nnoremap <Leader><Tab> :noh<CR>
" Tab left with Shift+Tab
inoremap <S-Tab> <BS>
" Loop through windows
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
