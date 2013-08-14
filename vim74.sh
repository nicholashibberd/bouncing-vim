#!/usr/bin/env bash

# Info:
# - https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
# - http://stackoverflow.com/questions/11416069/compile-vim-with-clipboard-and-xterm
# - http://www.vimninjas.com/2012/09/21/vim-ruby-python/
#
# For a list of configure options:
# - in src/auto/configure look for ac_user_opts
# - :h +feature-list and :h feature-list
#
# To uninstall:
#
#     sudo dpkg -r vim

set -e

echo "Update the apt index"
sudo apt-get update -qq

sudo apt-get install -y \
  libncurses5-dev \
  libgnome2-dev \
  libgnomeui-dev \
  libgtk2.0-dev \
  libatk1.0-dev \
  libbonoboui2-dev \
  libcairo2-dev \
  libperl-dev \
  libx11-dev \
  libxpm-dev \
  libxt-dev \
  libxtst-dev \
  python-dev \
  ruby-dev \
  mercurial

mkdir -p ~/Downloads/

echo "Remove old vim source"
rm -rf ~/Downloads/vim

if [[ -d ~/Downloads/vim.bkp ]]; then
  echo "Restore vim source from bkp"
  cp -R ~/Downloads/vim.bkp ~/Downloads/vim
else
  echo "Clone vim source from googlecode.com"
  hg clone -q https://vim.googlecode.com/hg/ ~/Downloads/vim
  echo "Make a bkp of the vim source"
  mv -T ~/Downloads/vim ~/Downloads/vim.bkp
  cp -R ~/Downloads/vim.bkp ~/Downloads/vim
fi

cd ~/Downloads/vim/

sudo apt-get remove \
  vim \
  vim-runtime \
  gvim \
  vim-tiny \
  vim-common \
  vim-gui-common \
  vim-gnome

./configure \
  --with-features=huge \
  --with-x \
  --enable-rubyinterp \
  --with-ruby-command=/usr/bin/ruby \
  --enable-pythoninterp \
  --enable-perlinterp \
  --enable-gui=gtk2 \
  --enable-cscope \
  --prefix=/usr

make VIMRUNTIMEDIR=/usr/share/vim/vim74

sudo make install
