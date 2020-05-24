set nocompatible   " Disable legacy vi things
set ignorecase     " Case-insensitive searching.
set smartcase      " But case-sensitive if expression contains a capital letter.
set relativenumber " Use relative line numbers by default
set ttyfast        " Set that we have a fast terminal
set hlsearch       " highlight the search results
set incsearch      " search as you type
set t_Co=256       " Explicitly tell Vim that the terminal supports 256 colors
set number         " Enable line numbers
set shortmess=Ia   " Abbreviate startup message
set smartindent    " GET SMART
set colorcolumn=80 " Consciously decide to make lines too long
set nowrap         " disable line wrapping
set signcolumn=yes " Always show the sign column
set backspace=indent,eol,start
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set fillchars+=vert:│ " Use long bar as vertical separator
set laststatus=2   " Always show status line
set termguicolors  " Nice colors

" Mouse settings
set mouse+=a           " Enable mouse
if &term =~ '^screen'  " Use extended mouse mode when using tmux, screen
  set ttymouse=xterm2
endif

" Hide this junk
set wildignore+=*/_workspace,*/build/\,*/target,*/vendor,*/venv*,*/tmp,*/dist/,*.pyc,*.egg-info

let mapleader=" "  " Map <leader> to space

filetype off
filetype plugin on
filetype indent on
syn on

" Set directory settings

" Create a directory if it doesn't exist yet
function! s:EnsureDirectory(directory)
  if !isdirectory(expand(a:directory))
    call mkdir(expand(a:directory), 'p')
  endif
endfunction

" Put all swap files in here
set backupdir=$HOME/.vim/tmp
set directory=$HOME/.vim/tmp
call s:EnsureDirectory(&directory)
set backup

if has("unix")
  " Copy copy register to OS X general pasteboard
  function! PBCopy()
    call system("pbcopy", getreg(""))
  endfunction

  " Paste from OS X general pasteboard to copy register
  function! PBPaste()
    call setreg("", system("pbpaste"))
  endfunction
endif

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

" Language Settings
"
" Fix crontab weirdness
autocmd filetype crontab setlocal nobackup nowritebackup
autocmd filetype swift,ruby,markdown,journal,apiblueprint,lua,javascript,c,cpp,cs setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.html.erb let b:eruby_subtype = 'html'
autocmd BufNewFile,BufRead *.md.erb let b:eruby_subtype = 'markdown'
autocmd BufNewFile,BufRead jrnl*.txt set filetype=journal
autocmd BufNewFile,BufRead *.podspec set filetype=ruby
autocmd BufEnter,BufNew *.make set filetype=make
autocmd BufEnter,BufNew *.lalrpop set filetype=rust
autocmd BufEnter,BufNew *.m set filetype=objc
autocmd BufEnter,BufNew *.mm set filetype=objcpp
autocmd BufEnter,BufNew *.metal set filetype=cpp
autocmd filetype markdown,journal,apiblueprint set textwidth=80
" Use templates for new files
" from https://twitter.com/petdance/status/1009826710752317440
call s:EnsureDirectory("$HOME/.vim/templates")
autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.tpl
autocmd filetype java set colorcolumn=100
autocmd filetype cs set colorcolumn=100


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Strip trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Load plugins with https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/bundle')

" Navigation and search
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle','NERDTreeFind'] }
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'
Plug 'drmingdrmer/xptemplate'
Plug 'tpope/vim-projectionist'
Plug 'joereynolds/SQHell.vim'

" '<leader>cc' to comment
" '<leader>c ' to toggle comment
Plug 'scrooloose/nerdcommenter'
Plug 'honza/vim-snippets'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Languages
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'kylef/apiblueprint.vim', { 'for': 'apiblueprint' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'wting/rust.vim', { 'for': 'rust' }
Plug 'junegunn/vim-journal', { 'for': 'journal' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'leafgarland/typescript-vim'
Plug 'leafo/moonscript-vim'

" VCS
Plug 'rhysd/committia.vim'
"Plug 'airblade/vim-gitgutter'

" Color and layout
Plug 'junegunn/seoul256.vim'
Plug 'keith/parsec.vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
call plug#end()

" Keybindings
"
" Git
nnoremap <Leader>gc :!tig status<cr>   " Show staging area
nnoremap <Leader>gs :!tig<cr>          " Tree view
nnoremap <Leader>gb :!tig blame %<cr>  " Show blame for current file
" Make
nnoremap <Leader>mm :make<cr>
nnoremap <Leader>mc :make clean<cr>
nnoremap <Leader>mt :make test<cr>
nnoremap <Leader>mr :make run<cr>
" Layout
nnoremap <Leader>t :NERDTreeToggle<cr>
nnoremap <Leader>j :NERDTreeFind<cr>
nnoremap vv :vsplit<cr>
nnoremap vh :split<cr>
" General
nnoremap Y y$
nnoremap <Leader>f :Files<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>a :CocList -I symbols<cr>
nnoremap <Leader>e :CocList diagnostics<cr>
nnoremap <Leader>, :CocCommand clangd.switchSourceHeader<cr>
nnoremap <Leader>c :NERDCommenterToggle<cr>

nnoremap <Leader>k :call <SID>show_documentation()<cr>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <Leader>K :CocCommand clangd.symbolInfo<cr>

nnoremap <Leader>gd <Plug>(coc-definition)
nnoremap <Leader>gr <Plug>(coc-references)
nnoremap <Leader>gh <Plug>(coc-type-definition)
nnoremap <Leader>gi <Plug>(coc-implementation)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Copy yanked text to system pasteboard
nnoremap <Leader>y :call PBCopy()<cr>
" Paste system pasteboard contents into copy register
nnoremap <Leader>p :call PBPaste()<cr>
" List operations
nnoremap <silent> gl "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>
nnoremap <silent> gh "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
" Search
nnoremap <Leader>ag :Ag <cword><cr>
" Docs
nnoremap <Leader>mn :execute '!man ' . expand("<cword>")<cr> " Show man page for current word
" swap colon and single quote for easier commands
nnoremap ' :
nnoremap : '
vnoremap ' :
vnoremap : '

let g:coc_snippet_next = '<tab>'
let g:coc_status_error_sign = 'E:'
let g:coc_status_warning_sign = '⚠'

" Use Seoul256 color scheme
let g:seoul256_background = 235
colo seoul256
" Set snippet options
let g:UltiSnipsExpandTrigger="<c-e>"

" Set NERDTree hidden files
let g:NERDTreeIgnore = ['_workspace', 'build/', 'target', 'vendor', 'dist/', 'tmp', '.pyc', 'venv.*', 'egg-info']

" Allow fenced code block highlighting in Markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'php', 'json', 'ruby', 'c', 'diff']

if has("gui_running")
    set guifont=Range\ Mono:h14
else
    :source $VIMRUNTIME/menu.vim
    :set wildmenu
    :set cpoptions-=<
    :set wildcharm=<C-Z>
    :map <F4> :emenu <C-Z>
endif

cnoremap <C-a> <Home>

if has("nvim")
  set inccommand=nosplit
endif

" Status line
" Format: {color}Filename/List flags =spacer= {color}syntax {color}filetype {color}buffer%
" Note:   Print available colors with :so $VIMRUNTIME/syntax/hitest.vim
set statusline=%#LineNr#%f%k%w\ %m%r%=%#SpellBad#%{coc#status()}%{get(b:,'coc_current_function','')}%#CursorLineNr#\ \♛%4P%#LineNr#\ %#Question#%y
