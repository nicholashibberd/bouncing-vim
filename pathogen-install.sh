#!/usr/bin/env bash

if [[ -d ~/.vim && ! -d ~/.vim.original ]]; then
  mv ~/.vim{,.original}
  echo "Backup ~/.vim to ~/.vim.original"
fi

mkdir -p \
  ~/.vim \
  ~/.vim/bundle \
  ~/.vim/autoload \
  ~/.vim/colors \
  ~/.vim/undo \
  ~/.vim/swap \
  ~/.vim/_disabled_plugins
echo "Created ~/.vim dir structure"

# git clone https://github.com/tpope/vim-pathogen.git ~/.vim/vim-pathogen
# ln -sf ~/.vim/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim

curl -Sso ~/.vim/autoload/pathogen.vim \
  https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo "Installed pathogen plugin"
