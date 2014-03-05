#!/usr/bin/env bash

github_basename () {
  echo "$1" | sed -E 's|.+\/(.+)$|\1|g'
}

clone_to_bundle () {
  local GITHUB=$1
  local BASENAME=$2
  local DIR=$3

  if [[ ! -d "$HOME/.vim/bundle/$BASENAME" && ! -d "$HOME/.vim/bundle/$DIR" ]]; then
    echo "Install $GITHUB to $HOME/.vim/bundle/$DIR"
    git clone -q "https://github.com/${GITHUB}.git" "$HOME/.vim/bundle/$DIR"
  else
    echo "$GITHUB already installed, skipping"
  fi
}

install_tmp_plugin_with_pathogen () {
  local GITHUB=$1
  local BASENAME=$(github_basename $GITHUB)
  local DIR="bouncing-vim-tmp-$BASENAME"

  clone_to_bundle $GITHUB $BASENAME $DIR
}

install_plugin_with_pathogen () {
  local GITHUB=$1
  local BASENAME=$(github_basename $GITHUB)
  local DIR="$BASENAME"

  clone_to_bundle $GITHUB $BASENAME $DIR
}

# Read the dependencies from an external file, and save them in an array named dependencies
install_dependencies () {
  local dependency_file=$1

  SAVE_IFS=$IFS
  IFS=$'\n'
  local dependencies=($(cat $dependency_file))
  IFS=$SAVE_IFS

  local dependency_list=${dependencies[*]}

  sudo apt-get update
  sudo apt-get install -y $dependency_list
}
