call plug#begin("~/.vim/plugged")

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'Mofiqul/vscode.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lervag/vimtex'
Plug 'sheerun/vim-polyglot'

call plug#end()

" File Tree
lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
require('nvim-tree').setup()
EOF

nmap <silent> tt :NvimTreeToggle<CR>

" CoC Bindings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

nmap <leader>do <Plug>(coc-codeaction)

nmap <leader>rn <Plug>(coc-rename)

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-css',
  \  'coc-eslint',
  \  'coc-prettier',
  \  'coc-go',
  \ ]

" Status Line
lua << EOF
require('lualine').setup({
    options = {
        theme = 'vscode'
    }
})
require('vscode').setup({
    transparent = true,
    italic_comments = true
})
require('vscode').load()
EOF


" Standard Vim Setup
syntax on
filetype plugin indent on

set redrawtime=20000
set re=2
set relativenumber number
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set cino=N-s,g0 " Prevent indenting of namespace in C++
set textwidth=80
set formatoptions-=tc " Prevent autowrapping of comments and text
set ruler

" Disable logging web-indenx
let g:js_indent_log = 0

" Disable clearing of clipboard.
autocmd VimLeave * call system('echo' . shellescape(getreg('+')) . ' | xclip -selection clipboard')

" Hide command line when not being used
set cmdheight=0

" Terminal Bindings
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

command Terminal botright vs|term
cabbrev terminal Terminal
cabbrev term Terminal

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull',
      \ 'Overfull',
      \ 'does not make sense',
      \ 'Non standard sectioning'
      \ ]
" let g:vimtex_compiler_method = 'latexrun'
let maplocalleader = ","
