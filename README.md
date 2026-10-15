# dots

Personal configuration. Currently Neovim only.

## Neovim

A Rust-focused [LazyVim](https://www.lazyvim.org/) setup. Needs Neovim 0.11.2 or newer (LazyVim's minimum).

### Install

```sh
git clone git@github.com:singulared/dots.git ~/sources/dots
ln -s ~/sources/dots/neovim ~/.config/nvim
nvim # lazy.nvim bootstraps itself and installs the plugins
```

### Updating plugins

Plugin versions are pinned in `neovim/lazy-lock.json`. After `:Lazy update`, commit the lockfile on its own.
If an update breaks something, `git checkout neovim/lazy-lock.json` and run `:Lazy restore`.

### External dependencies

LSP servers, formatters, linters, cspell and codelldb are installed by Mason. Mason's bin directory is appended to
`PATH`, so system binaries take precedence (rust-analyzer comes from rustup/cargo).

| Tool                                                                    | Used for                                             |
| ----------------------------------------------------------------------- | ---------------------------------------------------- |
| `rust-analyzer`                                                         | rustaceanvim                                         |
| `deno`                                                                  | building peek.nvim (markdown preview, `<leader>mp`)  |
| `chafa`                                                                 | dashboard image                                      |
| `gh` with [gh-notify](https://github.com/meiji163/gh-notify), `jq`, `curl` | dashboard GitHub sections, `scripts/oss-stats.sh` |
| `delta`                                                                 | fzf-lua code action preview                          |
| `sway`                                                                  | optional: places the peek preview window             |

### Local plugin development

Plugins matching `singulared/*` are loaded from `~/sources/nvim/<name>` when that checkout exists, otherwise they are
cloned from GitHub.
