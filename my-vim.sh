#!/usr/bin/env bash

set -e

source util-functions.sh

# Colorschemes
# wget https://raw.github.com/garybernhardt/dotfiles/master/.vim/colors/grb256.vim -P ~/.vim/colors/
# tpope/vim-vividchalk
# Lokaltog/vim-distinguished
# noahfrederick/Hemisu
# morhetz/gruvbox

# Plugins
# tComment???
# jistr/vim-nerdtree-tabs
# tpope/vim-fugitive
# plasticboy/vim-markdown
clone_plugin lucabelmondo/vim-luke

clone_plugin mileszs/ack.vim
clone_plugin kien/ctrlp.vim
clone_plugin fholgado/minibufexpl.vim
clone_plugin juvenn/mustache.vim
clone_plugin scrooloose/nerdtree
clone_plugin hdima/python-syntax
clone_plugin ervandew/supertab
clone_plugin godlygeek/tabular
clone_plugin altercation/vim-colors-solarized
clone_plugin jeetsukumaran/vim-buffergator
clone_plugin tpope/vim-commentary
clone_plugin tpope/vim-markdown
clone_plugin t9md/vim-ruby-xmpfilter
clone_plugin vim-ruby/vim-ruby
clone_plugin tpope/vim-sensible
clone_plugin tpope/vim-surround
clone_plugin benmills/vimux
