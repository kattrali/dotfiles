" Load plugins with https://github.com/junegunn/vim-plug
call plug#begin(g:bundledir)

" Navigation and search
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle','NERDTreeFind'] }
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-projectionist'

" '<leader>cc' to comment
" '<leader>c ' to toggle comment
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'honza/vim-snippets'
Plug 'vim-test/vim-test'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Languages
Plug 'kylef/apiblueprint.vim'
Plug 'dag/vim-fish'
Plug 'ledger/vim-ledger'
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'leafgarland/typescript-vim'
Plug 'leafo/moonscript-vim'
Plug 'udalov/kotlin-vim'
Plug 'tikhomirov/vim-glsl'
Plug 'bakpakin/fennel.vim'
Plug 'kattrali/suspect.vim' " vim-test extension for projects using suspect test framework

" VCS
Plug 'rhysd/committia.vim'

" Color and layout
Plug 'rcarriga/nvim-notify'
" Plug 'junegunn/seoul256.vim'
" Plug 'keith/parsec.vim'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/edge'
Plug 'flrnd/candid.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
call plug#end()
