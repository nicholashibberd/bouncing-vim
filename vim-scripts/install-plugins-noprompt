#!/usr/bin/env bash

set -e

currdir=$(cd "$(dirname $0)" && pwd -P)

home_dir=$1

if [[ -z "${home_dir}" ]]; then
  echo "The home dir must be passed, aborting."
  exit 1
fi

source "${currdir}/../utils.sh"
source "${currdir}/vim-utils.sh"
source "${currdir}/plugins.sh"

echo "Ensure a complete ~/.vim dir structure"
mkdir -v -p ~/.vim/{bundle,autoload,colors,undo,swap,_disabled_plugins}

curl -Sso "${home_dir}/.vim/autoload/pathogen.vim" \
  "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"

for plugin in ${ESSENTIALS[@]}; do
  clone_to_bundle_with_home "${plugin}" "${home_dir}"
done

for plugin in ${NICE_TO_HAVES[@]}; do
  clone_to_bundle_with_home "${plugin}" "${home_dir}"
done

ln -sfv "${home_dir}/.vim/bundle/bouncing-vim/rc-files/vimrc" "${home_dir}/.vimrc"

ln -sfv "${home_dir}/.vim/bundle/bouncing-vim/rc-files/tmux.conf" "${home_dir}/.tmux.conf"
