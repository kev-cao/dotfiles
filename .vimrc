execute pathogen#infect()

syntax on
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""
"""  AIRLINE VIM
"""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


" Colorscheme settings.
" colorscheme space_vim_theme
hi Normal ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi LineNr term=bold cterm=NONE ctermfg=74 ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
hi Comment cterm=italic

set relativenumber number
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Disable logging web-indenx
let g:js_indent_log = 0

" Disable clearing of clipboard.
autocmd VimLeave * call system('echo' . shellescape(getreg('+')) . ' | xclip -selection clipboard')
