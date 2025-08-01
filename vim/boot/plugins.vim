" Ack
let g:ackprg = 'rg --vimgrep'
let g:ack_qhandler = "botright copen 20"
map <Leader>a :Ack!<Space>
map <Leader>A :Ack! <C-r><C-w>

" Airline
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1        " Display tabline
let g:airline#extensions#tabline#show_buffers = 1   " Do not show buffers in tabline
let g:airline#extensions#tabline#tab_nr_type = 0    " Display tab number
let g:airline_powerline_fonts = 1                   " Use powerline fonts
let g:airline_theme='murmur'

" Easymotion
map <Leader>f <Plug>(easymotion-f)
map <Leader>F <Plug>(easymotion-F)
map <Leader>/ <Plug>(easymotion-sn)

" Easytags
let g:easytags_async = 1            " Update tags asynchronously
let g:easytags_auto_highlight = 0   " Disable tag highlighting

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Fugitive
nnoremap <Leader>b :Git blame<CR>

" Fzf
nmap <C-P> :Files<CR>
nmap <C-B> :Buffers<CR>


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

" LSP
map <Leader>d :LspHover<CR>
map <Leader>h :LspDiag current<CR>
map <Leader>] :LspDiag next<CR>
map <Leader>[ :LspDiag prev<CR>
map <Leader>g :LspGotoDefinition<CR>
map <Leader>G :LspGotoDeclaration<CR>
map <Leader>i :LspGotoImpl<CR>
map <Leader>r :LspShowReferences<CR>
map <Leader>ri :LspIncomingCalls<CR>
map <Leader>ro :LspOutgoingCalls<CR>
map <Leader>R :LspRename 

let pylsp_config = { 'pylsp': { 'plugins': { 'pycodestyle': { 'maxLineLength': 100 } } } }

" Python language server
autocmd User LspSetup call LspAddServer([#{
    \ name: 'pylsp',
    \ filetype: 'python',
    \ path: '/Users/canar/Library/Python/3.9/bin//pylsp',
    \ args: [],
    \ workspaceConfig: pylsp_config,
\ }])

" Go language server
autocmd User LspSetup call LspAddServer([#{
    \ name: 'golang',
    \ filetype: ['go', 'gomod'],
    \ path: '/Users/canar/go/bin/gopls',
    \ args: [],
    \ syncInit: v:true
\ }])

" Rust language server
autocmd User LspSetup call LspAddServer([#{
    \ name: 'rustlang',
    \ filetype: ['rust'],
    \ path: '/Users/canar/.cargo/bin/rust-analyzer',
    \ args: [],
    \ syncInit: v:true
\ }])

" Terraform language server
autocmd User LspSetup call LspAddServer([#{
    \ name: 'terraform',
    \ filetype: ['terraform'],
    \ path: '/opt/homebrew/bin//terraform-ls',
    \ args: ['serve'],
    \ syncInit: v:true
\ }])

" Copilot
map <Leader>c :Copilot<CR>
