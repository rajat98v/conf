inoremap kj <ESC>
inoremap jk <ESC>

let mapleader="\<Space>"
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <Leader><Leader> <C-^><CR> "cycle the buffer

" PLUGIN: FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 



set background=dark
set clipboard=unnamedplus " able to copy from program and paste into nvim
"+ register is copy paste register, * register is selection register
set completeopt=noinsert,menuone,noselect
set number relativenumber
set hidden
set inccommand=split
set mouse=a
set number
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/dag/vim-fish'
Plug 'navarasu/onedark.nvim'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'

call plug#end()


filetype plugin indent on
syntax on

set t_Co=256
" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

let g:onedark_style = 'darker'
"let g:onedark_style = 'warmer'
colorscheme onedark

