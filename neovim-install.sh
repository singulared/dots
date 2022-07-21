#!/bin/sh

BASEDIR=$(dirname "$0")

echo "Install NEOVIM configuration"

ln -s $BASEDIR/neovim ~/.config/nvim
git clone https://github.com/kristijanhusak/vim-packager ~/.config/nvim/pack/packager/opt/vim-packager
cargo install --force ripgrep
cargo install --force skim
nvim +PackagerInstall +qa
nvim +'TSInstall rust python bash c json toml' +qa
nvim +TSUpdate +qa
