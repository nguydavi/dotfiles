match ERROR /\s\+$/                                 " Show every trailing whitespace as errors

function! SetTitle()
    if $TERM =~ "^screen" || $TERM =~ "^xterm-256"
        let l:title = 'vi: ' . expand('%:t')

        if (l:title != 'vi: __Tag_List__')
            let l:truncTitle = strpart(l:title, 0, 15)
            silent exe '!echo -e -n "\033k' . l:truncTitle . '\033\\"'
        endif
    endif
endfunction
autocmd BufEnter,BufFilePost * call SetTitle()      " Run it every time we change buffers

autocmd Filetype gitcommit setlocal textwidth=72    " git commit textwidth
