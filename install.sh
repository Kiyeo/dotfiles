#!/usr/bin/env bash

set -e

os_type="$(uname -s)"

apt_packages="zsh stow git neovim ripgrep zoxide clang"
brew_packages="zsh stow git neovim ripgrep zoxide clang"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

case "$os_type" in
  Linux*)
    sudo apt-get update && sudo apt-get install -y ${apt_packages}
    ;;
  Darwin*)
    brew install ${brew_packages}
    ;;
esac

chsh -s "$(command -v zsh)"

git submodule update --init --recursive --remote

stow */

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' # https://github.com/wbthomason/packer.nvim/issues/502
