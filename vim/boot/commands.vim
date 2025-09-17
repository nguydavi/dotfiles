" Set tmux title every time we change buffers
function! SetTitle()
    let l:title = 'vi: ' . expand("%:t")
    let l:truncTitle = strpart(l:title, 0, 15)

    call system("tmux rename-window '" . l:truncTitle . "'")
endfunction
autocmd BufEnter,BufFilePost,BufReadPost,FileReadPost,BufNewFile * call SetTitle()
autocmd VimLeave * call system("tmux setw automatic-rename")

" git commit textdwith
autocmd Filetype gitcommit setlocal textwidth=72

" python max line length
autocmd Filetype python setlocal colorcolumn=101 textwidth=100

" Some file types tabs should be 2 spaces
autocmd FileType ruby,cucumber,typescript,terraform setlocal shiftwidth=2 softtabstop=2 expandtab

" Show trailing whitespaces
autocmd VimEnter,WinEnter * match SpellBad /\s\+$/

" Open quickfix window on :make
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow

" Add yaml revealer in status line
autocmd FileType yaml let g:airline_section_c = '%t%m %{YamlRevealerStatusLine()} %r'
