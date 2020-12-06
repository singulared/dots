#!/bin/sh

BASEDIR=$(dirname "$0")

echo "Install NEOVIM configuration"

cp -rf $BASEDIR/neovim ~/.config/nvim
git clone https://github.com/kristijanhusak/vim-packager ~/.config/nvim/pack/packager/opt/vim-packager
cargo install --force bat
cargo install --force skim
nvim +PackagerInstall +qa
nvim +'TSInstall rust python' +qa
nvim +TSUpdate +qa
