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
set backspace=indent,eol,start
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set fillchars+=vert:│ " Use long bar as vertical separator

" Mouse settings
set mouse+=a           " Enable mouse
if &term =~ '^screen'  " Use extended mouse mode when using tmux, screen
  set ttymouse=xterm2
endif

" Hide this junk
set wildignore+=*/_workspace,*/build/\,*/target,*/vendor,*/venv*,*/dist,*/tmp,*.pyc,*.egg-info

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

" Find a HTML file in a directory matching the current word, and open it in
" a tmux pane in lynx. If no matches are found, try the current directory.
function! DocLookup(sourceDirs, patternPrefix)
    let word = expand("<cword>")
    for base in a:sourceDirs
        let filePaths = split(globpath(base, a:patternPrefix . word . ".html"), '\n')
        if (len(filePaths) > 0)
            call system("tmux split-window -v -p 40 'lynx " . filePaths[0] . "'")
            return
        endif
    endfor
endfunction

" Allow tab for completion while in insert mode
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-p>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" Language Settings
"
" Fix crontab weirdness
autocmd filetype crontab setlocal nobackup nowritebackup
autocmd filetype swift,ruby,markdown,journal,apiblueprint,lua,javascript,c,cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead jrnl*.txt set filetype=journal
autocmd BufNewFile,BufRead *.podspec set filetype=ruby
autocmd BufEnter,BufNew *.lalrpop set filetype=rust
autocmd filetype markdown,journal,apiblueprint set textwidth=80

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
Plug 'vim-syntastic/syntastic'

" '<leader>cc' to comment
" '<leader>c ' to toggle comment
Plug 'scrooloose/nerdcommenter'

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
Plug 'airblade/vim-gitgutter'

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
nnoremap <Leader>sh :GitGutterStageHunk<cr>
" Make
nnoremap <Leader>mm :!make<cr>
nnoremap <Leader>mc :!make clean<cr>
nnoremap <Leader>mt :!make test<cr>
nnoremap <Leader>mr :!make run<cr>
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
nnoremap <Leader>a :Tags<cr>
nnoremap <Leader>c :NERDCommenterToggle<cr>
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
autocmd filetype haxe nnoremap <buffer> <Leader>sd :call DocLookup(["~/doc/src/flixel/api"], "**/")<cr>
autocmd filetype rust nnoremap <buffer> <Leader>sd :call DocLookup(["~/.multirust/toolchains/stable/share/doc/rust/html/std", "./target/doc"], "**/*")<cr>
" swap colon and semicolon for easier commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Use Seoul256 color scheme
let g:seoul256_background = 235
colo seoul256

" Set NERDTree hidden files
let g:NERDTreeIgnore = ['_workspace', 'build/', 'target', 'vendor', 'dist', 'tmp', 'pyc', 'venv.*', 'egg-info']

" Allow fenced code block highlighting in Markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'php', 'json', 'ruby', 'c', 'diff']

