function! SetTitle()
    if $TERM =~ "^screen" || $TERM =~ "^xterm-256"
        let l:title = 'vi: ' . expand('%:t')

        if (l:title != 'vi: __Tag_List__')
            let l:truncTitle = strpart(l:title, 0, 15)
            silent exe '!echo -e -n "\033k' . l:truncTitle . '\033\\"'
        endif
    endif
endfunction
" Set screen title every time we change buffers
autocmd BufEnter,BufFilePost * call SetTitle()

" git commit textdwith
autocmd Filetype gitcommit setlocal textwidth=72

" python max line length
autocmd Filetype python setlocal colorcolumn=101 textwidth=100

" Some file types tabs should be 2 spaces
autocmd FileType ruby,cucumber setlocal shiftwidth=2 softtabstop=2 expandtab

" Show trailing whitespaces
autocmd VimEnter,WinEnter * match Error /\s\+$/

" Open quickfix window on :make
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow
