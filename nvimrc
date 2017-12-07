runtime! macros/matchit.vim
set nocompatible              " be iMproved, required
filetype on                  " required

" Python hosts
let g:python_host_prog='/home/makc/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog='/home/makc/.pyenv/versions/neovim/bin/python'

" Functions
let g:myLang = 0
let g:myLangList = ['nospell', 'en_us,ru_ru']
function! MySpellLang()
  "loop through languages
  if g:myLang == 0 | setlocal nospell | endif
  if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg 'language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction


"=====================================================
" Plug settings
"=====================================================
" set the runtime path to include Vundle and initialize
call plug#begin('~/.nvim/bundle')

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

" Plugins
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elubow/cql-vim'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'hdima/python-syntax'
Plug 'iCyMind/NeoSolarized'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'klen/python-mode', {'branch': 'develop'}
Plug 'majutsushi/tagbar'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mitsuhiko/vim-jinja'
Plug 'mitsuhiko/vim-python-combined'
Plug 'neovim/node-host', { 'do': 'npm install' }
Plug 'pearofducks/ansible-vim'
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/NERDCommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/dbext.vim'
Plug 'aklt/plantuml-syntax'
Plug 'scrooloose/vim-slumlord'
Plug 'cespare/vim-toml'
Plug 'w0rp/ale'
Plug 'mileszs/ack.vim'
" Plug 'scrooloose/syntastic'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'altercation/vim-colors-solarized'
" Plug 'vimlab/mdown.vim', { 'do': 'npm install' }


" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required


"=====================================================
" General settings
"=====================================================
" disable beep
set visualbell t_vb= 
set novisualbell

syntax on
set termguicolors
"set t_Co=256
set background=dark
"let g:solarized_termcolors=256
colorscheme NeoSolarized

set enc=utf-8	     " utf-8 is a default
set ls=2             " statusbar is visible always
set incsearch	     " incremental search
set hlsearch	     " search highlight
set ignorecase       " searches are case insensitive...
set smartcase        " ... unless they contain at least one capital letter
set nu	             " line numbers
set scrolloff=5	     " scroll by 5 lines
set cursorline
set lazyredraw

" hide ui elements
set guioptions-=T    " toolbar

" Tab settings
set smarttab
" I'm prefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab

set ttyfast
set clipboard+=unnamedplus
" set showmatch

set wrap
set linebreak

set guifont=DejaVu\ Sans\ Mono\ For\ Powerline\ Nerd\ Font\ 10
"set directory=~/.nvim/.swapfiles/

" Cursor shape
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
" set guicursor=
au VimLeave * set guicursor=a:block-blinkon0


"=====================================================
" NeoSolarized settings
"=====================================================
" default value is "normal", Setting this option to "high" or "low" does use the 
" same Solarized palette but simply shifts some values up or down in order to 
" expand or compress the tonal range displayed.
let g:neosolarized_contrast = "normal"

" Special characters such as trailing whitespace, tabs, newlines, when displayed 
" using ":set list" can be set to one of three levels depending on your needs. 
" Default value is "normal". Provide "high" and "low" options.
let g:neosolarized_visibility = "normal"

" I make vertSplitBar a transparent background color. If you like the origin solarized vertSplitBar
" style more, set this value to 0.
let g:neosolarized_vertSplitBgTrans = 1

" If you wish to enable/disable NeoSolarized from displaying bold, underlined or italicized 
" typefaces, simply assign 1 or 0 to the appropriate variable. Default values:  
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 0

"=====================================================
" Devicons settings 
"=====================================================
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

"=====================================================
" Airline settings
"=====================================================
set laststatus=2
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"=====================================================
" Tagbar settings
"=====================================================
let g:tagbar_autofocus = 0 " disable Tagbar autofocus

"=====================================================
" Gitgutter settings
"=====================================================
" let g:gitgutter_realtime = 0
" let g:gitgutter_eager = 0

"=====================================================
" NerdTree settings
"=====================================================
" ignored files 
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$','\.o$']  
autocmd BufEnter *.py :call tagbar#autoopen(0)
autocmd BufWinLeave *.py :TagbarClose

"=====================================================
" NerdComenter settings
"=====================================================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

"=====================================================
" YouCompleteMe settings
"=====================================================
" let g:ycm_server_keep_logfiles=1
" let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_python_binary_path = '/home/makc/.pyenv/versions/3.6.2/bin/python3.6'
let g:ycm_server_python_interpreter = '/home/makc/.pyenv/versions/3.6.2/bin/python3.6'
" let g:ycm_path_to_python_interpreter = '/home/makc/.pyenv/shims/python' 
let g:ycm_path_to_python_interpreter = '/home/makc/.pyenv/versions/3.6.2/bin/python3.6'
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
" let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_rust_src_path = '/home/makc/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
let g:ycm_goto_buffer_command = 'new-or-existing-tab' 

"=====================================================
" Ale settings
"=====================================================
let g:ale_open_list = 1
" let g:ale_keep_list_window_open = 1
let g:ale_python_autopep8_executable = '/home/makc/.pyenv/versions/neovim/bin/autopep8'
let g:ale_python_flake8_executable = '/home/makc/.pyenv/shims/python'
let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_mypy_executable = '/home/makc/.pyenv/versions/neovim/bin/python'
let g:ale_python_mypy_options = '-m mypy --ignore-missing-imports'
let g:ale_python_yapf_executable = '/home/makc/.pyenv/versions/neovim/bin/python'
let g:ale_python_yapf_options = '-m yapf'
let g:ale_python_isort_executable = '/home/makc/.pyenv/versions/neovim/bin/python'
let g:ale_python_isort_options = '-m isort'
let g:ale_python_pylint_executable = '/home/makc/.pyenv/versions/neovim/bin/pylint'
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['isort']}
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let g:ale_lint_on_text_changed = 'never'

"=====================================================
" Syntastic settings
"=====================================================
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" "let g:syntastic_python_python_exec = 'python3'
" let g:syntastic_python_checkers = ['flake8', 'pyflakes']
" let g:syntastic_python_pylint_post_args='--disable=E1120,E1130,E1103,W1401'
" "let g:syntastic_ignore_files = ['\.py$']
" let g:syntastic_rst_checkers = ['sphinx']
" let g:syntastic_rust_checkers = ['cargo']

"=====================================================
" Pythonmode settings
"=====================================================
" let g:pymode = 1
let g:pymode_python = 'python3'

autocmd BufWritePre *.py :%s/\s\+$//e
au FileType python setlocal cc=80 
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let python_highlight_all=0
let python_highlight_exceptions=0
let python_highlight_builtins=0
let python_slow_sync=1

" disable pymode autocomplete
let g:pymode_rope = 1
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" docs
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'

" disable pymode linters
let g:pymode_lint = 0
let g:pymode_lint_checker = 'pyflakes,pep8'
"let g:pymode_lint_ignore='E501,W601,C0110'

" check code after save
let g:pymode_lint_write = 1

" virtualenv support
let g:pymode_virtualenv = 1

" breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace()  # XXX: BREAKPOINT'

"
" syntax highlight
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" disable autofold
let g:pymode_folding = 0

"=====================================================
" User defined functions
"=====================================================
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunction

"=====================================================
" User defined shortcut
"=====================================================
map <F3> :NERDTreeTabsToggle<CR>
map <F2> :TagbarToggle<CR>
map <F4> :SyntasticCheck<CR>
map <F7> :<C-U>call MySpellLang()<CR>
set pastetoggle=<F5>
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <A-Left> :tabp<CR>
nnoremap <A-Right> :tabn<CR>
inoremap <A-Left> <Esc>:tabp<CR>
inoremap <A-Right> <Esc>:tabn<CR>
nnoremap <A-Up> :bp<CR>
nnoremap <A-Down> :bn<CR>
inoremap <A-Left> <Esc>:bp<CR>
inoremap <A-Right> <Esc>:bn<CR>

nnoremap <A-C-Right> :wincmd l<CR>
nnoremap <A-C-Left> :wincmd h<CR>
nnoremap <A-C-Up> :wincmd k<CR>
nnoremap <A-C-Down> :wincmd j<CR>
inoremap <A-C-Right> <Esc>:wincmd l<CR>
inoremap <A-C-Left> <Esc>:wincmd h<CR>
inoremap <A-C-Up> <Esc>:wincmd k<CR>
inoremap <A-C-Down> <Esc>:wincmd j<CR>

"nnoremap <S-Right> :wincmd l<CR>
"nnoremap <S-Left> :wincmd h<CR>
"nnoremap <S-Up> :wincmd k<CR>
"nnoremap <S-Down> :wincmd j<CR>
"inoremap <S-Right> <Esc>:wincmd l<CR>
"inoremap <S-Left> <Esc>:wincmd h<CR>
"inoremap <S-Up> <Esc>:wincmd k<CR>
"inoremap <S-Down> <Esc>:wincmd j<CR>
"
nnoremap <A-h> :tabp<CR>
nnoremap <A-l> :tabn<CR>
inoremap <A-h> <Esc>:tabp<CR>
inoremap <A-l> <Esc>:tabn<CR>
nnoremap <A-k> :bp<CR>
nnoremap <A-j> :bn<CR>
inoremap <A-k> <Esc>:bp<CR>
inoremap <A-j> <Esc>:bn<CR>

nnoremap <A-C-l> :wincmd l<CR>
nnoremap <A-C-h> :wincmd h<CR>
nnoremap <A-C-k> :wincmd k<CR>
nnoremap <A-C-j> :wincmd j<CR>
inoremap <A-C-l> <Esc>:wincmd l<CR>
inoremap <A-C-h> <Esc>:wincmd h<CR>
inoremap <A-C-k> <Esc>:wincmd k<CR>
inoremap <A-C-j> <Esc>:wincmd j<CR>
"set langmap=!\\"№\\;%?*ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;!@#$%&*`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
"inoremap <C-c> <Esc>
