" Airline
let g:airline#extensions#tabline#enabled = 1    " Enable line of buffers
let g:airline_powerline_fonts = 1               " Use powerline fonts
let g:airline_theme='murmur'

" Easymotion
map <Leader>f <Plug>(easymotion-f)
map <Leader>F <Plug>(easymotion-F)
map <Leader>/ <Plug>(easymotion-sn)

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

autocmd FileType python nnoremap <Bslash>r :VBGstartPDB %<CR>
