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

clone_temp_plugin () {
  local GITHUB=$1
  local BASENAME=$(github_basename $GITHUB)
  local DIR="bouncing-vim-tmp-$BASENAME"

  clone_to_bundle $GITHUB $BASENAME $DIR
}

clone_plugin () {
  local GITHUB=$1
  local BASENAME=$(github_basename $GITHUB)
  local DIR="$BASENAME"

  clone_to_bundle $GITHUB $BASENAME $DIR
}
