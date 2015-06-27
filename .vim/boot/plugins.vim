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
map <Bslash>n :VBGstepOver<CR>
map <Bslash>s :VBGstepIn<CR>
map <Bslash>c :VBGcontinue<CR>
map <Bslash>f :VBGstepOut<CR>
map <Bslash><CR> :VBGrepeat<CR>

map <Bslash>d :VBGclearBreakpoints<CR>
map <Bslash>b :VBGtoggleBreakpointThisLine<CR>
map <Bslash>e :VBGeval 
map <Bslash>x :VBGexecute 
map <Bslash>k :VBGkill<CR>

autocmd FileType python nnoremap <Bslash>r :VBGstartPDB %<CR>
