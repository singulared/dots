" Wildmenu
set wildoptions=pum
set pumblend=20

filetype plugin indent on

" Hybrid relative line number
set number relativenumber

" Always show sign column
set signcolumn=yes

" Language
let g:myLang = 0
let g:myLangList = ['nospell', 'en_us,ru_yo']

" Show current cursor line
set cursorline

" Clipboard
set clipboard+=unnamedplus

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
