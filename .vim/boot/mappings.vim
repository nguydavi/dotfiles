" Set Space as Leader (not using mapleader so that it appears in showcmd in later version of Vim)
" let mapleader = " "
map <Space> <Leader>

" Clipboard
nnoremap <Leader>c "+y
nnoremap <Leader>v "+p

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
nnoremap <Leader>w :bd<CR>

" Replace word under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" Remove highlighting
nnoremap <Tab> :noh<CR><Tab>
