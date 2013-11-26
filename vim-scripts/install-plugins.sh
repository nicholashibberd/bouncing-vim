#!/usr/bin/env bash

set -e

currdir=$( dirname "$( readlink -f $0 )" )

source "${currdir}/../utils.sh"
source "${currdir}/../plugins.sh"

if [[ ! $(command -v curl) ]]; then
  echo "curl is required"
  exit 1
fi

if [[ ! $(command -v git) ]]; then
  echo "git is required"
  exit 1
fi

if [[ -d ~/.vim && ! -d ~/.vim.original ]]; then
  echo "Backup ~/.vim to ~/.vim.original"
  mv ~/.vim{,.original}
fi

echo "Ensure ~/.vim dir structure"
mkdir -p \
  ~/.vim \
  ~/.vim/bundle \
  ~/.vim/autoload \
  ~/.vim/colors \
  ~/.vim/undo \
  ~/.vim/swap \
  ~/.vim/_disabled_plugins

# git clone https://github.com/tpope/vim-pathogen.git ~/.vim/vim-pathogen
# ln -sf ~/.vim/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim

if [[ -e "${HOME}/.vim/autoload/pathogen.vim" ]]; then
  echo "vim pathogen is already installed"
else
  echo "Install pathogen plugin"
  curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
fi

for plugin in ${ESSENTIALS[@]}; do
  clone_plugin "$plugin"
done

for plugin in ${NICE_TO_HAVES[@]}; do
  clone_plugin "$plugin"
done

if [[ -e ~/.vimrc && ! -L ~/.vimrc ]]; then
  echo "Backup original vimrc"
  mv ~/.vimrc ~/.vimrc.original
fi

echo "Symlink vimrc"
ln -sf "${currdir}/../rc-files/vimrc" "${HOME}/.vimrc"
