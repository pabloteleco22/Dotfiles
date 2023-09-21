if &shell =~# 'fish$'
    set shell=bash
endif

set lbr
set nu
set relativenumber
set hls
set incsearch
set mouse=
"let mapleader = ","
set tabstop=4
set shiftwidth=4
set expandtab
set termguicolors

noremap j gj
noremap k gk
noremap l <space>
noremap h <backspace>
noremap <C-Backspace> db
inoremap <C-Backspace> <C-W>
noremap <C-Delete> dw
inoremap <C-Delete> <ESC>cw

"packadd! dracula
syntax enable
"colorscheme dracula

lua << END
require('lualine').setup({})
END

call plug#begin()
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'RRethy/vim-hexokinase'
call plug#end()

"    Plug 'uga-rosa/ccc.nvim'
