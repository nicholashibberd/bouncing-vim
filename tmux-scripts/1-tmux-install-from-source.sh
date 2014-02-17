#!/usr/bin/env bash

set -e

TMUX_VERSION=1.8
TMUX_SOURCE_DIR="${HOME}/Downloads/tmux-${TMUX_VERSION}"
tmux_download_url="http://downloads.sourceforge.net/project/tmux/tmux/tmux-${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz"

echo
echo "--- Install tmux ${TMUX_VERSION} from source ---"
echo

echo "Ensure dependencies for compiling tmux"
sudo apt-get update
sudo apt-get -y install curl build-essential libncurses5-dev libevent-dev

mkdir -v -p "${HOME}/Downloads"

echo "Ensure to remove tmux source dir"
rm -rf $TMUX_SOURCE_DIR

if [[ -f "${HOME}/Downloads/tmux-${TMUX_VERSION}.tar.gz" ]]; then
  echo "tmux-${TMUX_VERSION}.tar.gz already downloaded"
else
  echo "Download tmux ${TMUX_VERSION}"
  cd "${HOME}/Downloads/" && { curl -O -L $tmux_download_url; cd  -; }
fi

echo "Extract tmux source archive"
tar xfz "${HOME}/Downloads/tmux-${TMUX_VERSION}.tar.gz" -C "${HOME}/Downloads/"

echo "run ./configure"
cd $TMUX_SOURCE_DIR
./configure
cd -

echo "run make"
make -C $TMUX_SOURCE_DIR

sudo make install -C $TMUX_SOURCE_DIR
echo
echo "Installed tmux version $(tmux -V) at $(which tmux)"

cd "$HOME/Downloads"

archive_filename="tmux-${TMUX_VERSION}-compiled-$(date -d "today" +"%Y-%m-%d_%H-%M-%S").tar.gz"
echo "Archive source to ${archive_filename} for uninstall."
cd ~/Downloads && { tar cfz $archive_filename "tmux-${TMUX_VERSION}"; cd -; }

echo "Remove source dir"
rm -rf $TMUX_SOURCE_DIR

echo "Do you want to link to the tmux.conf provided?"
read -p "Your tmux.conf will be backed up. [y/N] " -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [[ -e ~/.tmux.conf && ! -L ~/.tmux.conf ]]; then
    echo "Backup original vimrc"
    mv -v ~/.tmux.conf ~/tmux.conf.original
  fi

  ln -vsf "${HOME}/.vim/bundle/bouncing-vim/rc-files/tmux.conf" "${HOME}/.tmux.conf"
else
  echo "Inspect the provided tmux.conf for more info. ${HOME}/.vim/bundle/bouncing-vim/rc-files/tmux.conf"
fi
