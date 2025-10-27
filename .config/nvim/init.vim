set lbr
set nu
set relativenumber
set hls
set incsearch
" set mouse=
let mapleader = ","
set tabstop=4
set shiftwidth=4
set expandtab
set termguicolors
set ignorecase
set nowrap
set foldmethod=syntax
set foldlevelstart=99999

" Coc options
set nobackup
set nowritebackup
set signcolumn=yes

" noremap j gj
" noremap k gk
" noremap l <space>
" noremap h <backspace>
noremap <silent> <C-Backspace> <Plug>AirlineSelectPrevTab :<C-u>keepalt bd #<CR>:AirlineRefresh<CR>
inoremap <C-Backspace> <C-W>
noremap <C-Delete> dw
inoremap <C-Delete> <ESC>cw
noremap <silent> <C-a> :<C-u>Neotree toggle reveal<CR>
inoremap <silent> <C-a> <ESC>:<C-u>Neotree toggle reveal<CR>a
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>x "_x
vnoremap <leader>x "_x

lua << EOF
require("comments")
require("safe_paste")
require("hexeditor")
EOF

vnoremap p <cmd>SafePaste<CR>
vnoremap <leader>p p

CommentSyntaxMapping <leader>/

CommentSyntaxAdd .py #
CommentSyntaxAdd .sh #
CommentSyntaxAdd .bash #
CommentSyntaxAdd .c //
CommentSyntaxAdd .h //
CommentSyntaxAdd .cpp //
CommentSyntaxAdd .hpp //
CommentSyntaxAdd .js //
CommentSyntaxAdd .ts //
CommentSyntaxAdd .vim "
CommentSyntaxAdd .lua --
CommentSyntaxAdd Makefile #
CommentSyntaxAdd makefile #

call plug#begin()

" NeoTree
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'antosha417/nvim-lsp-file-operations'
Plug 'folke/snacks.nvim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/plenary.nvim'

" Telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-telescope/telescope-symbols.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Theme Kanagawa
Plug 'rebelot/kanagawa.nvim'

" Syntax highlighting for C and C++
Plug 'bfrg/vim-c-cpp-modern'

" Tree sitter
"Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main', 'do': ':TSUpdate' }

call plug#end()

nnoremap <leader>1 <Plug>AirlineSelectTab1
nnoremap <leader>2 <Plug>AirlineSelectTab2
nnoremap <leader>3 <Plug>AirlineSelectTab3
nnoremap <leader>4 <Plug>AirlineSelectTab4
nnoremap <leader>5 <Plug>AirlineSelectTab5
nnoremap <leader>6 <Plug>AirlineSelectTab6
nnoremap <leader>7 <Plug>AirlineSelectTab7
nnoremap <leader>8 <Plug>AirlineSelectTab8
nnoremap <leader>9 <Plug>AirlineSelectTab9
nnoremap <leader>0 <Plug>AirlineSelectTab0
nnoremap <leader>< <Plug>AirlineSelectPrevTab
nnoremap <leader>> <Plug>AirlineSelectNextTab

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" GoTo code navigation
nnoremap <silent><nowait> gd <Plug>(coc-definition)
nnoremap <silent><nowait> gy <Plug>(coc-type-definition)
nnoremap <silent><nowait> gi <Plug>(coc-implementation)
nnoremap <silent><nowait> gr <Plug>(coc-references)

" Show action pannel
nnoremap <silent> <leader>a <Plug>(coc-codeaction-line)

" Navigate diagnostics
nnoremap <silent><nowait> <leader>gp <Plug>(coc-diagnostics-prev)
nnoremap <silent><nowait> <leader>gn <Plug>(coc-diagnostics-next)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nnoremap <silent> <leader>gf :<C-u>call CocActionAsync('format')<CR>

noremap <C-Tab> :tabnext<CR>
noremap <C-S-Tab> :tabprevious<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Format on save
autocmd BufWritePre * lua pcall(vim.fn.CocAction, 'format')

" Save view when leaving a buffer
autocmd BufWinLeave * silent! mkview

" Restore view when entering a buffer
autocmd BufWinEnter * silent! loadview

colorscheme kanagawa

lua << EOF
require("neotree-conf")
EOF
