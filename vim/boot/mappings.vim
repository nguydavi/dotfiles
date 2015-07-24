" Set Space as Leader (not using mapleader so that it appears in showcmd in later version of Vim)
let mapleader = " "
map <Space> <Leader>

" Clipboard
nnoremap <Leader>c "+yy
nnoremap <Leader>v "+p
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
nnoremap <Leader>w :bd<CR>
nnoremap g1 :b1<CR>
nnoremap g2 :b2<CR>
nnoremap g3 :b3<CR>
nnoremap g4 :b4<CR>
nnoremap g5 :b5<CR>
nnoremap g6 :b6<CR>
nnoremap g7 :b7<CR>
nnoremap g8 :b8<CR>
nnoremap g9 :b9<CR>

" Replace word under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>r :s/\<\>//g<Left><Left><Left><Left><Left>
nnoremap <Leader>R :%S/<C-r><C-w>//g<Left><Left>
vnoremap <Leader>R :S///g<Left><Left><Left><Left><Left>

" Remove highlighting
nnoremap <Leader><Tab> :noh<CR>
" Tab left with Shift+Tab
inoremap <S-Tab> <BS>
" Loop through windows
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" Build the project
nnoremap <Leader>b :make<CR>
