function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })                           " Package manager
  call packager#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})                     " Syntax parser and highliter
  " call packager#add('mhartington/oceanic-next')                                                 " Oceanic Theme
  call packager#add('sainnhe/edge')                                                             " Edge theme
  " call packager#add('VDuchauffour/neodark.nvim')                                              " Noedark theme
  call packager#add('neovim/nvim-lspconfig')                                                    " LSP configuration defaults
  call packager#add('hrsh7th/cmp-nvim-lsp-signature-help')                                      " LSP signature help completion
  call packager#add('onsails/lspkind.nvim')                                                     " LSP completion icons
  " call packager#add('hrsh7th/vim-vsnip')                                                        " Snippets support
  " call packager#add('hrsh7th/cmp-vsnip')                                                        " Snippets support
  " call packager#add('hrsh7th/vim-vsnip-integ')                                                  " Snippets interation
  call packager#add('saadparwaiz1/cmp_luasnip')                                                 " Snippets support
  call packager#add('L3MON4D3/LuaSnip')                                                         " Snippets engine
  call packager#add('nvim-lua/lsp_extensions.nvim')                                             " LSP extensions
  call packager#add('nvim-lua/lsp-status.nvim')                                                 " LSP Statusline info
  call packager#add('vim-airline/vim-airline')                                                  " Statusline
  call packager#add('vim-airline/vim-airline-themes')                                           " Statusline themes
  call packager#add('kyazdani42/nvim-web-devicons')                                             " Neovim Icons
  call packager#add('ryanoasis/vim-devicons')                                                   " Icons
  call packager#add('kyazdani42/nvim-tree.lua')                                                 " File explorer
  call packager#add('liuchengxu/vista.vim')                                                     " View and search LSP symbols, tags in Vim/NeoVim.
  call packager#add('tpope/vim-fugitive')                                                       " Git
  call packager#add('airblade/vim-gitgutter')                                                   " Git sign
  call packager#add('rhysd/git-messenger.vim')                                                  " Git history
  call packager#add('akinsho/bufferline.nvim')                                                  " Buffer line implementation
  call packager#add('jiangmiao/auto-pairs')                                                     " Autospell pairs 
  call packager#add('tpope/vim-surround')                                                       " Insert or delete brackets, parens, quotes in pair.
  call packager#add('scrooloose/NERDCommenter')                                                 " Commenter
  call packager#add('nvim-lua/popup.nvim')                                                      " Popup API
  call packager#add('nvim-lua/plenary.nvim')                                                    " Neovim helpers
  call packager#add('nvim-telescope/telescope.nvim')                                            " Finder
  call packager#add('liuchengxu/vim-clap', { 'do': ':Clap install-binary' })                    " Finder and dispatcher
  call packager#add('lotabout/skim')                                                            " Rust alternative to fzf
  call packager#add('lotabout/skim.vim')                                                        " Skim vim integration
  call packager#add('hrsh7th/cmp-nvim-lsp')                                                     " LSP completion integration
  call packager#add('hrsh7th/cmp-omni')                                                         " Omni completion
  call packager#add('hrsh7th/cmp-buffer')                                                       " Buffer completion
  call packager#add('hrsh7th/cmp-path')                                                         " Path completion
  call packager#add('hrsh7th/cmp-cmdline')                                                      " Cmd line completion
  call packager#add('hrsh7th/nvim-cmp')                                                         " Neovim completion
  call packager#add('nvim-telescope/telescope-ui-select.nvim')                                  " Ui actions picker (completer)
  call packager#add('simrat39/rust-tools.nvim', { 'branch': 'modularize_and_inlay_rewrite'})    " Rust tools (lsp extension)
  call packager#add('mfussenegger/nvim-dap')                                                    " Debugger
  call packager#add('rcarriga/nvim-dap-ui')                                                     " Debugger UI
  call packager#add('rcarriga/nvim-notify')                                                     " Notifications
  call packager#add('saecki/crates.nvim')                                                       " crates.io completion
  call packager#add('mfussenegger/nvim-dap-python/')                                            " Python debugger
endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()

"Load plugins only for specific filetype
"Note that this should not be done for plugins that handle their loading using ftplugin file.
"More info in :help pack-add
augroup packager_filetype
  " autocmd!
  " autocmd FileType javascript packadd vim-js-file-import
  " autocmd FileType go packadd vim-go
augroup END
