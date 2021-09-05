function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Allow tab for completion while in insert mode
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <Leader>sh :CocCommand git.chunkStage<cr>
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nnoremap <Leader>a :CocList -I symbols<cr>
nnoremap <Leader>e :CocList diagnostics<cr>
nnoremap <Leader>l :CocList outline<cr>
nnoremap <Leader>, :CocCommand clangd.switchSourceHeader<cr>

nnoremap <Leader>k :call <SID>show_documentation()<cr>
function! s:show_documentation()
  if (coc#rpc#ready())
    call CocActionAsync('doHover')
  endif
endfunction

nmap <Leader>gd <Plug>(coc-definition)
nmap <Leader>gr <Plug>(coc-references)
nmap <Leader>gh :call CocActionAsync('highlight')<cr>
nmap <Leader>gy <Plug>(coc-type-definition)
nmap <Leader>gi <Plug>(coc-implementation)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

let g:coc_snippet_next = '<tab>'
let g:coc_status_error_sign = 'E:'
let g:coc_status_warning_sign = '⚠'
let g:coc_global_extensions = ['coc-snippets', 'coc-git', 'coc-tsserver', 'coc-rls', 'coc-go', 'coc-clangd']

" Set snippet options
let g:UltiSnipsExpandTrigger="<c-e>"
