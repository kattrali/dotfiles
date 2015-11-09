
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
set backspace=indent,eol,start
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" Mouse settings
set mouse+=a           " Enable mouse
if &term =~ '^screen' " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Hide this junk
set wildignore+=*/_workspace
set wildignore+=*/build,*/target,*/vendor

let mapleader=","  " Map <leader> to comma

filetype off
filetype plugin on
filetype indent on
syn on

" Toggle relative vs absolute line numbers
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
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

" Allow tab for completion while in insert mode
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-p>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" By the power of https://github.com/sjl/vitality.vim, copies and pastes
" to the OS X pasteboard when switching between vim and other windows
" (even in tmux)
autocmd FocusLost * :call PBCopy()
autocmd FocusGained * :call PBPaste()

" Language Settings
"
" Fix crontab weirdness
autocmd filetype crontab setlocal nobackup nowritebackup
autocmd filetype swift,ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead jrnl*.txt set filetype=journal
autocmd filetype markdown,journal set textwidth=80

" Strip trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Load plugins with https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/bundle')

" Navigation and search
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'

" '<leader>cc' to comment
" '<leader>c ' to toggle comment
Plug 'scrooloose/nerdcommenter'

" Languages
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'kylef/apiblueprint.vim', { 'for': 'apib' }
Plug 'gfontenot/vim-xcodebuild', { 'on': ['XBuild','XClean','XTest','XSelectScheme'] }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'wting/rust.vim', { 'for': 'rust' }
Plug 'junegunn/vim-journal'
Plug 'cespare/vim-toml', { 'for': 'toml' }

" Utilities
Plug 'sjl/vitality.vim' " Fixes FocusLost/FocusGained in tmux

" Color and layout
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'jaxbot/semantic-highlight.vim', { 'on': 'SemanticHighlightToggle' }

call plug#end()

" Keybindings
"
" Git
nnoremap <Leader>gc :!tig status<cr>   " Show staging area
nnoremap <Leader>gs :!tig<cr>          " Tree view
nnoremap <Leader>gl :!tig log<cr>      " Log view
nnoremap <Leader>gb :!tig blame %<cr>  " Show blame for current file
nnoremap <Leader>gp :!git push<cr>     " Push changes
" Make
nnoremap <Leader>mm :!make<cr>
nnoremap <Leader>mc :!make clean<cr>
nnoremap <Leader>mt :!make test<cr>
nnoremap <Leader>mr :!make run<cr>
" Layout
nnoremap <C-n> :call NumberToggle()<cr>
nnoremap <Leader>t :NERDTreeToggle<cr>
nnoremap <Leader>y :Goyo<cr>
nnoremap <Leader>ll :Limelight!!<cr>
nnoremap <Leader>s :SemanticHighlightToggle<cr>
" General
nnoremap Y y$
inoremap jj <Esc>
nnoremap <Leader>p :CtrlP<cr>
nnoremap <Leader>w :w<cr>
" swap colon and semicolon for easier commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Use Seoul256 color scheme
colo seoul256

