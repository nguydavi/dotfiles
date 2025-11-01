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

" Context
" Doesn't work well with yaml
let g:context_filetype_blacklist = ['nerdtree', 'gitcommit', 'help', 'yaml']

" Easymotion
map <Leader>/ <Plug>(easymotion-sn)

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Fugitive
nnoremap <Leader>b :Git blame<CR>

" Fzf
nmap <C-P> :Files<CR>
nmap <C-B> :Buffers<CR>
map <Leader>m :Maps<CR>

" Peekaboo
let g:peekaboo_window = "vert bo 120new"

" Undotree
map <Leader>u :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 60
let g:undotree_SetFocusWhenToggle = 1

" Yaml revealer
let g:yaml_revealer_display_mode = 'statusline'

" vimsuggest
let s:vim_suggest = {}
let s:vim_suggest.cmd = {'onspace': ['.*']}
autocmd VimEnter * call g:VimSuggestSetOptions(s:vim_suggest)

" Which-key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" LSP
map <Leader>d :LspHover<CR>
map <Leader>h :LspDiag current<CR>
map <Leader>] :LspDiag next<CR>
map <Leader>[ :LspDiag prev<CR>
map <Leader>g :LspGotoDefinition<CR>
map <Leader>G :LspGotoDeclaration<CR>
map <Leader>i :LspGotoImpl<CR>
map <Leader>r :LspShowReferences<CR>
map <Leader>I :LspIncomingCalls<CR>
map <Leader>O :LspOutgoingCalls<CR>
map <Leader>R :LspRename<Space>

let pylsp_config = { 'pylsp': { 'plugins': { 'pycodestyle': { 'maxLineLength': 100 } } } }

" Python language server
autocmd User LspSetup call LspAddServer([#{
    \ name: 'pylsp',
    \ filetype: 'python',
    \ path: exepath('pylsp'),
    \ args: [],
    \ workspaceConfig: pylsp_config,
\ }])

" Go language server
autocmd User LspSetup call LspAddServer([#{
    \ name: 'golang',
    \ filetype: ['go', 'gomod'],
    \ path: exepath('gopls'),
    \ args: [],
    \ syncInit: v:true
\ }])

" Rust language server
autocmd User LspSetup call LspAddServer([#{
    \ name: 'rustlang',
    \ filetype: ['rust'],
    \ path: exepath('rust-analyzer'),
    \ args: [],
    \ syncInit: v:true
\ }])

" Terraform language server
autocmd User LspSetup call LspAddServer([#{
    \ name: 'terraform',
    \ filetype: ['terraform'],
    \ path: exepath('terraform-ls'),
    \ args: ['serve'],
    \ syncInit: v:true
\ }])

" Copilot
map <Leader>c :Copilot<CR>
imap <C-d> <Plug>(copilot-dismiss)

"" Set Shift+Tab to accept Copilot suggestion or fallback to Supertab
let g:copilot_no_tab_map = v:true

function! s:CopilotSuperTabFallback() abort
  if exists('*SuperTab')
    return "\<C-R>=SuperTab('p')\<CR>"
  endif
  return ''
endfunction

function! s:CopilotAcceptOrSuperTab() abort
  if exists('*copilot#Accept')
    return copilot#Accept(function('s:CopilotSuperTabFallback'))
  endif
  return s:CopilotSuperTabFallback()
endfunction

autocmd VimEnter * inoremap <silent><script><expr> <S-Tab> <SID>CopilotAcceptOrSuperTab()
