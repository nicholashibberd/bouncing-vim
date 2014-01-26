#!/usr/bin/env bash

set -e

currdir=$( dirname "$( readlink -f $0 )" )
rootdir=$( readlink -f "${currdir}/../" )

source "${currdir}/../utils.sh"
source "${currdir}/plugins.sh"

# ==========================
# === Check dependencies ===
# ==========================

if [[ ! $(command -v curl) ]]; then
  echo "curl is required"
  exit 1
fi

if [[ ! $(command -v git) ]]; then
  echo "git is required"
  exit 1
fi

# ========================
# ===~/.vim/ directory ===
# ========================

# The ~/.vim/ dir will be created, or used, and optionally backed up.
# It will also be possible to abort the install process.

if [[ -d ~/.vim ]]; then
  echo "The ~/.vim/ directory exists. Do you want to...?"
  select reply in "Use existing" "Backup and recreate" "Abort"; do
    case "${reply}" in
      "Use existing" )
        break ;;
      "Backup and recreate" )
        echo "Backup ~/.vim to ~/.vim.bkp"
        mv ~/.vim{,.bkp}
        break ;;
      "Abort" )
        exit 1;;
    esac
  done
fi

echo "Ensure a complete ~/.vim dir structure"
mkdir -p ~/.vim/{bundle,autoload,colors,undo,swap,_disabled_plugins}

# ================
# === pathogen ===
# ================

# It will use pathogen if present, offer to install, or abort.

if [[ $(find ~/.vim -name pathogen.vim) ]]; then
  echo "pathogen.vim is already installed"
else
  select reply in "Install pathogen to handle your plugins" "Abort"; do
    case "${reply}" in
      "Install pathogen to handle your plugins" )
        echo "Install pathogen to handle your plugins"
        curl -Sso ~/.vim/autoload/pathogen.vim \
          https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
        break ;;
      "Abort" )
        echo "Note: pathogen.vim is required to install the vim plugins, aborting."
        exit 1 ;;
    esac
  done
fi

# =======================
# === Install plugins ===
# =======================

for plugin in ${ESSENTIALS[@]}; do
  install_plugin_with_pathogen "${plugin}"
done

for plugin in ${NICE_TO_HAVES[@]}; do
  install_plugin_with_pathogen "$plugin"
done

echo "Do you want to link to the vimrc provided?"
read -p "(your vimrc will be backed up if present): [y/N]" -r
echo

# =============
# === vimrc ===
# =============

if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [[ -e ~/.vimrc && ! -L ~/.vimrc ]]; then
    echo "Backup original vimrc"
    mv ~/.vimrc ~/vimrc.original
  fi

  ln -sfv "${HOME}/.vim/bundle/bouncing-vim/rc-files/vimrc" "${HOME}/.vimrc"
else
  echo "Inspect the provided vimrc for more info. ${HOME}/.vim/bundle/bouncing-vim/rc-files/vimrc"
fi
