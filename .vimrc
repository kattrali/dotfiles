
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

" Mouse settings
set mouse+=a           " Enable mouse
if &term =~ '^screen'  " Use extended mouse mode when using tmux, screen
  set ttymouse=xterm2
endif

" Hide this junk
set wildignore+=*/_workspace,*/build,*/target,*/vendor,*/venv*,*/dist,*/tmp,*.pyc

let mapleader=","  " Map <leader> to comma

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

" Put all swap files and here
set backup
set backupdir=$HOME/.vim/tmp
set directory=$HOME/.vim/tmp
call s:EnsureDirectory(&directory)

" Toggle relative vs absolute line numbers
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

" Copy copy register to OS X general pasteboard
function! PBCopy()
  call system("pbcopy", getreg(""))
endfunction

" Paste from OS X general pasteboard to copy register
function! PBPaste()
  call setreg("", system("pbpaste"))
endfunction

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

" '<leader>cc' to comment
" '<leader>c ' to toggle comment
Plug 'scrooloose/nerdcommenter'

" Languages
Plug 'scrooloose/syntastic'
let g:syntastic_shell = '/usr/local/bin/bash'

Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'kylef/apiblueprint.vim', { 'for': 'apiblueprint' }
Plug 'gfontenot/vim-xcodebuild', { 'on': ['XBuild','XClean','XTest','XSelectScheme'] }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'wting/rust.vim', { 'for': 'rust' }
Plug 'junegunn/vim-journal', { 'for': 'journal' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'vim-scripts/lua.vim', { 'for': 'lua' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'jdonaldson/vaxe'

" VCS
Plug 'rhysd/committia.vim'
Plug 'airblade/vim-gitgutter'

" Color and layout
Plug 'junegunn/seoul256.vim'
Plug 'keith/parsec.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'jaxbot/semantic-highlight.vim'

call plug#end()

" Keybindings
"
" Git
nnoremap <Leader>gc :!tig status<cr>   " Show staging area
nnoremap <Leader>gs :!tig<cr>          " Tree view
nnoremap <Leader>gl :!tig log<cr>      " Log view
nnoremap <Leader>gb :!tig blame %<cr>  " Show blame for current file
nnoremap <Leader>gp :!git push<cr>     " Push changes
nnoremap <Leader>ggt :GitGutterToggle<cr>
" Make
nnoremap <Leader>mm :!make<cr>
nnoremap <Leader>mc :!make clean<cr>
nnoremap <Leader>mt :!make test<cr>
nnoremap <Leader>mr :!make run<cr>
" Layout
nnoremap <C-n> :call NumberToggle()<cr>
nnoremap <Leader>t :NERDTreeToggle<cr>
nnoremap <Leader>j :NERDTreeFind<cr>
nnoremap <Leader>y :Goyo<cr>
nnoremap <Leader>ll :Limelight!!<cr>
nnoremap <Leader>s :SemanticHighlightToggle<cr>
nnoremap vv :vsplit<cr>
nnoremap vh :split<cr>
" General
nnoremap Y y$
nnoremap <Leader>p :Files<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>a :Tags<cr>
nnoremap <Leader>c :tag <cword><cr>
" Search
nnoremap <Leader>ag :Ag <cword><cr>
" Insert a single return and esc
nnoremap <Leader>o o<esc>
nnoremap <Leader>O O<esc>
" Docs
autocmd filetype haxe nnoremap <buffer> <Leader>sd :call DocLookup(["~/doc/src/flixel/api"], "**/")<cr>
autocmd filetype rust nnoremap <buffer> <Leader>sd :call DocLookup(["~/.multirust/toolchains/stable/share/doc/rust/html/std", "./target/doc"], "**/*")<cr>
" swap colon and semicolon for easier commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Vaxe config
let g:vaxe_openfl_target = "neko"
let g:vaxe_lime_target = "neko"

" Use Seoul256 color scheme
" let g:seoul256_background = 235

colo parsec

" Set NERDTree hidden files
let g:NERDTreeIgnore = ['_workspace', 'build', 'target', 'vendor', 'dist', 'tmp', 'pyc', 'venv.*']

" Allow fenced code block highlighting in Markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'php', 'json', 'ruby']
