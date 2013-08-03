#!/usr/bin/env bash

# Colorschemes
# wget https://raw.github.com/garybernhardt/dotfiles/master/.vim/colors/grb256.vim -P ~/.vim/colors/
# tpope/vim-vividchalk
# Lokaltog/vim-distinguished
# noahfrederick/Hemisu
# morhetz/gruvbox

# Other intesting plugins
# jistr/vim-nerdtree-tabs
# tpope/vim-fugitive
# plasticboy/vim-markdown
# jeffkreeftmeijer/vim-numbertoggle
# tomtom/tcomment_vim

declare -a ESSENTIALS=(
 "lucabelmondo/vim-luke"
      "mileszs/ack.vim"
         "kien/ctrlp.vim"
     "fholgado/minibufexpl.vim"
       "juvenn/mustache.vim"
   "scrooloose/nerdtree"
     "ervandew/supertab"
    "godlygeek/tabular"
"jeetsukumaran/vim-buffergator"
       "kchmck/vim-coffee-script"
        "tpope/vim-commentary"
        "tpope/vim-markdown"
        "tpope/vim-rails"
     "vim-ruby/vim-ruby"
        "tpope/vim-sensible"
     "benmills/vimux"
)

declare -a NICE_TO_HAVES=(
        "hdima/python-syntax"
  "altercation/vim-colors-solarized"
         "t9md/vim-ruby-xmpfilter"
        "tpope/vim-surround"
)

# echo ${PLUGINS[@]}
