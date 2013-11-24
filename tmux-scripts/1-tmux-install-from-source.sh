#!/usr/bin/env bash

set -e

TMUX_VERSION=1.8
TMUX_SOURCE_DIR="${HOME}/Downloads/tmux-${TMUX_VERSION}"

echo
echo "--- Install tmux ${TMUX_VERSION} from source ---"
echo

mkdir -p "${HOME}/Downloads"
echo "Ensure ~/Downloads dir exists"

echo "Ensure to remove tmux source dir"
rm -rf $TMUX_SOURCE_DIR

if [[ -f "${HOME}/Downloads/tmux-${TMUX_VERSION}.tar.gz" ]]; then
  echo "tmux-${TMUX_VERSION}.tar.gz already downloaded"
else
  echo "Download tmux ${TMUX_VERSION}"
  wget -q -P "${HOME}/Downloads/" "http://downloads.sourceforge.net/project/tmux/tmux/tmux-${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz"
fi

echo "Extract tmux source archive"
tar xfz "${HOME}/Downloads/tmux-${TMUX_VERSION}.tar.gz" -C "${HOME}/Downloads/"

echo "Ensure dependencies for compiling tmux"
sudo apt-get update -qq
sudo apt-get install libncurses5-dev libevent-dev -qq -y

echo "run ./configure"
cd $TMUX_SOURCE_DIR
./configure --quiet
cd -

echo "run make"
make --quiet -C $TMUX_SOURCE_DIR

sudo make install --quiet -C $TMUX_SOURCE_DIR
echo
echo "Installed tmux version $(tmux -V) at $(which tmux)"

cd "$HOME/Downloads"

archive_filename="tmux-compiled-$(date -d "today" +"%Y-%m-%d_%H-%M-%S").tar.gz"
echo "Archive source to ${archive_filename} for uninstall."
tar cfz $archive_filename $TMUX_SOURCE_DIR

echo "Remove source dir"
rm -rf $TMUX_SOURCE_DIR
