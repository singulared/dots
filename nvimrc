runtime! macros/matchit.vim
set nocompatible              " be iMproved, required
filetype on                  " required

" Python hosts
let g:python_host_prog='~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog='~/.pyenv/versions/neovim-3.8.1/bin/python'
" let g:python_host_prog='/usr/bin/python2'
" let g:python3_host_prog='/usr/bin/python3'

" Functions
let g:myLang = 0
let g:myLangList = ['nospell', 'en_us,ru_yo']
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

" let g:plug_url_format = 'git@github.com:%s.git'

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

" Plugins
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'bling/vim-bufferline'
Plug 'elubow/cql-vim'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'hdima/python-syntax'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'klen/python-mode', {'branch': 'develop'}
Plug 'majutsushi/tagbar'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mitsuhiko/vim-jinja'
Plug 'mitsuhiko/vim-python-combined'
Plug 'pearofducks/ansible-vim'
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/NERDCommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/dbext.vim'
Plug 'aklt/plantuml-syntax'
Plug 'cespare/vim-toml'

Plug 'mileszs/ack.vim'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" Themees
Plug 'lifepillar/vim-solarized8'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'

" Float windows documentation preview
Plug 'ncm2/float-preview.nvim'

" LanguageServer client for NeoVim.
Plug 'neovim/nvim-lsp'

" Completion manager for lsp
Plug 'haorenW1025/completion-nvim'

" Diagnostic messages [deprecated and moved into nvim-lsp]
" Plug 'haorenW1025/diagnostic-nvim'

" Snippets support
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Show parameter doc.
Plug 'Shougo/echodoc.vim'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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
au VimLeave * set guicursor=a:block-blinkon0

" Wildmenu
set wildoptions=pum
set pumblend=20

" Per project settings
set exrc
set secure

"=====================================================
" Solarized8 settings
"=====================================================
set background=dark
colorscheme solarized8_flat
let g:solarized_old_cursor_style = 1

" Debug syntax group
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"=====================================================
" Devicons settings 
"=====================================================
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

"=====================================================
" Nvim lsp settings
"=====================================================
" setup rust_analyzer LSP (IDE features)
" lua require'nvim_lsp'.rust_analyzer.setup{capabilities = {textDocument = {completion = {completionItem = {snippetSupport = true}}}}}
" lua require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach, cmd = {'/home/singulared/.pyenv/versions/neovim-3.8.1/bin/pyls'}, settings = {pyls = {configurationSources = { "pyflakes", "pycodestyle" }}}}

" Use LSP omni-completion in Rust files
" autocmd Filetype rust,python setlocal omnifunc=v:lua.vim.lsp.omnifunc
set completeopt=noinsert,menuone,noselect
" set completeopt-=preview

nnoremap <silent> <leader>g  <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD         <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> K          <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>I  <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>s  <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>G  <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr         <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>ic <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> <leader>ic <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap <silent> <leader>r  <cmd>lua vim.lsp.buf.rename()<Cr>
" nnoremap <silent> <leader>e <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>d <cmd>lua vim.lsp.diagnostic.set_loclist()<Cr>

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

"=====================================================
" Completion-nvim settings
"=====================================================
" Enable lsp completion & diagnostic

:lua << EOF
local nvim_lsp = require'lspconfig';
local on_attach_vim = function()
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require'completion'.on_attach()
end
require'lspconfig'.rust_analyzer.setup{
    on_attach = on_attach_vim, 
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
            },
        },
    }
}
require'lspconfig'.pyls.setup{
    on_attach=on_attach_vim, 
    cmd = {'~/.pyenv/versions/neovim-3.8.1/bin/pyls'}, 
    settings = {
        pyls = {
            configurationSources = { "pyflakes", "pycodestyle" }
        }
    },
    root_dir = function(fname)
        local nvim_lsp = require'lspconfig';
		local filename = nvim_lsp.util.path.is_absolute(fname) and fname
			or nvim_lsp.util.path.join(vim.loop.cwd(), fname)
		local root_pattern = nvim_lsp.util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'mypy.ini', '.pylintrc', '.flake8rc', '.git', '.gitignore')
		return root_pattern(filename) or nvim_lsp.util.dirname(filename)
	end;
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = false,
    update_in_insert = false,
    virtual_text = true,
  }
)

EOF
" Avoid showing message extra message when using completion
set shortmess+=c

" Enable snippets support
let g:completion_enable_snippet = 'vim-vsnip'

" Setup completion chars
let g:completion_trigger_character = ['.', '::']

" Fix auto-pairs CR with completion
" let g:AutoPairsMapCR = 0
" let g:completion_confirm_key = "\<c-y>"

" Add CR autopairs fallback
" let g:completion_confirm_key_rhs = "\<Plug>AutoPairsReturn"

"=====================================================
" Diagnostic-nvim settings
"=====================================================
" Enable virtual text
" let g:diagnostic_enable_virtual_text = 1

"=====================================================
" Auto-pairs settings
"=====================================================
" Enable Fly mode
" let g:AutoPairsFlyMode = 1

"=====================================================
" UltiSnips settings
"=====================================================

imap <A-Tab> <Plug>(neosnippet_expand_or_jump)
smap <A-Tab> <Plug>(neosnippet_expand_or_jump)
xmap <A-Tab> <Plug>(neosnippet_expand_target)

"=====================================================
" Airline settings
"=====================================================
set laststatus=2
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
" let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:airline#extensions#tabline#show_splits = 0
" let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"=====================================================
" Tagbar settings
"=====================================================
let g:tagbar_autofocus = 0 " disable Tagbar autofocus

"=====================================================
" Gitgutter settings
"=====================================================
" let g:gitgutter_realtime = 0
" let g:gitgutter_eager = 0
"
" Always show sign column
set signcolumn=yes

"=====================================================
" NerdTree settings
"=====================================================
" ignored files 
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$','\.o$']  
" autocmd BufEnter *.py :call tagbar#autoopen(0)
" autocmd BufWinLeave *.py :TagbarClose
let NERDTreeMapJumpPrevSibling="<A-C-k>"
let NERDTreeMapJumpNextSibling="<A-C-j>"

"=====================================================
" NerdComenter settings
"=====================================================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

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
let g:pymode_rope = 0
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
" Ack configuration
"=====================================================
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

"=====================================================
" Clipboard configuration
"
" Wayland clipboard provider that strips carriage returns (GTK3 issue).
" This is needed because currently there's an issue where GTK3 applications on
" Wayland contain carriage returns at the end of the lines (this is a root
" issue that needs to be fixed).
"=====================================================
" let g:clipboard = {
      " \   'name': 'wayland-strip-carriage',
      " \   'copy': {
      " \      '+': 'wl-copy --foreground --type text/plain',
      " \      '*': 'wl-copy --foreground --type text/plain --primary',
      " \    },
      " \   'paste': {
      " \      '+': {-> systemlist('wl-paste --no-newline | tr -d "\r"')},
      " \      '*': {-> systemlist('wl-paste --no-newline --primary | tr -d "\r"')},
      " \   },
      " \   'cache_enabled': 1,
      " \ }

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
map <F4> :ALEToggle<CR>
map <F7> :<C-U>call MySpellLang()<CR>
nnoremap <C-p> :Files<Cr>
" map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>. 
nnoremap <leader>q :bp<cr>:bd #<cr>
set pastetoggle=<F5>
" nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
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

nnoremap <A-h> :bp!<CR>
nnoremap <A-l> :bn!<CR>
inoremap <A-h> <Esc>:bp!<CR>
inoremap <A-l> <Esc>:bn!<CR>
nnoremap <A-k> :bp<CR>
nnoremap <A-j> :bn<CR>
inoremap <A-k> <Esc>:bp<CR>
inoremap <A-j> <Esc>:bn<CR>

nnoremap <C-l> :wincmd l<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-j> :wincmd j<CR>
inoremap <C-l> <Esc>:wincmd l<CR>
inoremap <C-h> <Esc>:wincmd h<CR>
inoremap <C-k> <Esc>:wincmd k<CR>
inoremap <C-j> <Esc>:wincmd j<CR>
"set langmap=!\\"№\\;%?*ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;!@#$%&*`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
"inoremap <C-c> <Esc>
