execute pathogen#infect()
syntax on
filetype plugin indent on

" Indentation
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

set wildmenu
set wildmode=list:longest

set laststatus=2 " always show the status line
set lazyredraw " do not redraw while running macros

set list " we do what to show tabs, to ensure we get them out of my files
set listchars=tab:>-,trail:- " show tabs and trailing
set matchtime=5 " how many tenths of a second to blink matching brackets for

set ignorecase
set smartcase

set number " turn on line numbers

set pastetoggle=<f11>

let g:rainbow_active = 0

noremap <S-space> <C-b>
noremap <space> <C-f>

nmap <left> gT
nmap <right> gt
map <up> <C-w>W
map <down> <C-w><C-w>
map <F9> :RainbowToggle<CR>

set autowrite

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
