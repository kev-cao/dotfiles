execute pathogen#infect()

syntax on
filetype plugin indent on

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
