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

set -e

VIM_SOURCE_DIR="$HOME/Downloads/vim"
VIM_SOURCE_BKP="${VIM_SOURCE_DIR}.bkp"

echo "Update the apt index"
sudo apt-get update -qq

sudo apt-get install -y \
  libncurses5-dev       \
  libgnome2-dev         \
  libgnomeui-dev        \
  libgtk2.0-dev         \
  libatk1.0-dev         \
  libbonoboui2-dev      \
  libcairo2-dev         \
  libperl-dev           \
  libx11-dev            \
  libxpm-dev            \
  libxt-dev             \
  libxtst-dev           \
  python-dev            \
  ruby-dev              \
  mercurial             \
  curl                  \
  git-core

echo "Ensure ~/Downloads exists"
mkdir -p ~/Downloads/

echo "Remove old vim source"
sudo rm -rf $VIM_SOURCE_DIR

if [[ -d $VIM_SOURCE_BKP ]]; then
  echo "Restore vim source from bkp"
  cp -R $VIM_SOURCE_BKP $VIM_SOURCE_DIR
else
  echo "Clone vim source from googlecode.com"
  hg clone -q https://vim.googlecode.com/hg/ $VIM_SOURCE_DIR
  echo "Make a bkp of the vim source"
  mv -T $VIM_SOURCE_DIR $VIM_SOURCE_BKP
  cp -R $VIM_SOURCE_BKP $VIM_SOURCE_DIR
fi

cd $VIM_SOURCE_DIR

sudo apt-get remove -y -qq \
  vim                      \
  vim-runtime              \
  gvim                     \
  vim-tiny                 \
  vim-common               \
  vim-gui-common           \
  vim-gnome

./configure                         \
  --with-features=huge              \
  --with-x                          \
  --enable-rubyinterp               \
  --with-ruby-command=/usr/bin/ruby \
  --enable-pythoninterp             \
  --enable-perlinterp               \
  --enable-gui=gtk2                 \
  --enable-cscope                   \
  --prefix=/usr

make VIMRUNTIMEDIR=/usr/share/vim/vim74

sudo make install

cd ~/Downloads

archive_filename="vim-compiled-$(date -d "today" +"%Y-%m-%d_%H-%M-%S").tar.gz"
echo "Archive source to $archive_filename for uninstall."
tar cfz $archive_filename vim/

echo "Remove source dir"
rm -rf $VIM_SOURCE_DIR

echo "Add vim to the alternatives"
sudo update-alternatives --install /usr/bin/editor editor   /usr/bin/vim    00
#                                  <link>          <group>  <path>          <priority>
sudo update-alternatives --set editor   /usr/bin/vim
#                              <group>  <path>

echo "To uninstall, unpack the latest source archive, cd to it, and run:"
echo
echo "    sudo make uninstall"
echo
echo "Run 'vim --version' to get full info about this install"
