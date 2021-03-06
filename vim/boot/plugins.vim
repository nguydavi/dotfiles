" Ack
let g:ackprg = 'ag --vimgrep'
let g:ack_qhandler = "botright copen 40"
map <Leader>a :Ack!<Space>
map <Leader>A :Ack! <C-r><C-w>

" Airline
" let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1        " Display tabline
let g:airline#extensions#tabline#show_buffers = 0   " Do not show buffers in tabline
let g:airline#extensions#tabline#tab_nr_type = 1    " Display tab number
let g:airline_powerline_fonts = 1                   " Use powerline fonts
let g:airline_theme='murmur'

" Ctrlp
" Open in a new tab by default
let g:ctrlp_prompt_mappings = { 'AcceptSelection("e")':['<c-t>'], 'AcceptSelection("t")':['<cr>','<2-LeftMouse>'] }

" Easymotion
map <Leader>f <Plug>(easymotion-f)
map <Leader>F <Plug>(easymotion-F)
map <Leader>/ <Plug>(easymotion-sn)

" Easytags
let g:easytags_async = 1            " Update tags asynchronously
let g:easytags_auto_highlight = 0   " Disable tag highlighting

" Javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_ImportSortType = 'packageName'
let g:JavaComplete_ImportOrder = ['*', 'java.', 'javax.']

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Vebugger
nnoremap <Bslash>n :VBGstepOver<CR>
nnoremap <Bslash>s :VBGstepIn<CR>
nnoremap <Bslash>c :VBGcontinue<CR>
nnoremap <Bslash>f :VBGstepOut<CR>
nnoremap <Bslash><CR> :VBGrepeat<CR>

nnoremap <Bslash>d :VBGclearBreakpoints<CR>
nnoremap <Bslash>b :VBGtoggleBreakpointThisLine<CR>
nnoremap <Bslash>e :VBGeval 
nnoremap <Bslash>x :VBGexecute 
nnoremap <Bslash>k :VBGkill<CR>

" Vim cpp enhanced highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

autocmd FileType python nnoremap <Bslash>r :VBGstartPDB %<CR>
