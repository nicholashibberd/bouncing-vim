#!/usr/bin/env bash

set -e

currdir=$( dirname $0 )

source "${currdir}/../utils.sh"
source "${currdir}/tmux-utils.sh"

TMUX_MINOR_VERSION=1.9
TMUX_PATCHLEVEL=a
TMUX_VERSION="${TMUX_MINOR_VERSION}${TMUX_PATCHLEVEL}"
TMUX_SOURCE_TARBALL="${HOME}/Downloads/tmux-${TMUX_VERSION}.tar.gz"
TMUX_SOURCE_DIR="tmux-${TMUX_VERSION}"
TMUX_SOURCE_PATH="${HOME}/Downloads/tmux-${TMUX_VERSION}"
TMUX_DOWNLOAD_URL="http://downloads.sourceforge.net/project/tmux/tmux/tmux-${TMUX_MINOR_VERSION}/tmux-${TMUX_VERSION}.tar.gz"

# ====================================
# === Dependencies and environment ===
# ====================================

install_dependencies "${currdir}/tmux-deps-build-precise.txt"

# ================
# === Download ===
# ================

get_source_from_tarball "${TMUX_DOWNLOAD_URL}" \
                        "${TMUX_SOURCE_TARBALL}" \
                        "${TMUX_SOURCE_PATH}" \

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

ARCHIVE_FILENAME="tmux-${TMUX_VERSION}-compiled-$(date -u -d "today" +"%Y%m%dT%H%M%SZ").tar.gz"
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
  echo "Inspect the provided tmux.conf for more info."
  echo "-> ${HOME}/.vim/bundle/bouncing-vim/rc-files/tmux.conf"
fi
