#!/usr/bin/env bash

set -e

TMUX_VERSION=1.9
TMUX_SOURCE_TARBALL="${HOME}/Downloads/tmux-${TMUX_VERSION}.tar.gz"
TMUX_SOURCE_DIR="tmux-${TMUX_VERSION}"
TMUX_SOURCE_PATH="${HOME}/Downloads/tmux-${TMUX_VERSION}"
TMUX_DOWNLOAD_URL="http://downloads.sourceforge.net/project/tmux/tmux/tmux-${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz"

echo
echo "--- Install tmux ${TMUX_VERSION} from source ---"
echo

# ====================================
# === Dependencies and environment ===
# ====================================

echo "Ensure dependencies for compiling tmux"
sudo apt-get update
sudo apt-get -y install curl build-essential libncurses-dev libevent-dev

mkdir -v -p "${HOME}/Downloads"

echo "Ensure to remove tmux source dir"
rm -rf $TMUX_SOURCE_PATH

# ================
# === Download ===
# ================

if [[ -f "${HOME}/Downloads/tmux-${TMUX_VERSION}.tar.gz" ]]; then
  echo "tmux-${TMUX_VERSION}.tar.gz already downloaded"
else
  echo "Download tmux ${TMUX_VERSION}"
  curl -o $TMUX_SOURCE_TARBALL -L $TMUX_DOWNLOAD_URL
fi

echo "Extract tmux source archive"
tar xfz $TMUX_SOURCE_TARBALL -C "${HOME}/Downloads/"

# ===========================
# === Compile and install ===
# ===========================

echo "run ./configure"
cd $TMUX_SOURCE_PATH
./configure
cd -

echo "run make"
make -C $TMUX_SOURCE_PATH

sudo make install -C $TMUX_SOURCE_PATH
echo
echo "Installed tmux version $(tmux -V) at $(which tmux)"

cd "$HOME/Downloads"

# ============================
# === Archive and clean up ===
# ============================

ARCHIVE_FILENAME="tmux-${TMUX_VERSION}-compiled-$(date -d "today" +"%Y-%m-%d_%H-%M-%S").tar.gz"
echo "Archive source to ${ARCHIVE_FILENAME} for uninstall."
tar cfz "${HOME}/Downloads/${ARCHIVE_FILENAME}" -C "${HOME}/Downloads" $TMUX_SOURCE_DIR

echo "Remove source dir"
rm -rf $TMUX_SOURCE_PATH

# ======================
# === tmux.conf file ===
# ======================

echo "Some of the features require specific configuration."
echo "Your tmux.conf will be backed up."

read -p "Do you want to link to the tmux.conf provided? [y/N]: " -r
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
