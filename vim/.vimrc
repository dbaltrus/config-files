set breakindent
set showbreak=\|\ 

syntax on
filetype plugin indent on

" Indentation
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

set laststatus=2 " always show the status line

set list " we do what to show tabs, to ensure we get them out of my files
set listchars=tab:>-,trail:~ " show tabs and trailing
set matchtime=5 " how many tenths of a second to blink matching brackets for

set ignorecase
set smartcase

set number

set pastetoggle=<f11>

set autowrite
set undodir=~/.vim/undo
set undofile
set undolevels=999999999
set undoreload=999999999

