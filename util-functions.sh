#!/usr/bin/env bash

set -e

github_basename () {
  echo "$1" | sed -r 's|.+\/(.+)$|\1|g'
}

clone_to_bundle () {
  local GITHUB=$1
  local BASENAME=$2
  local DIR=$3

  if [[ ! -d "$HOME/.vim/bundle/$BASENAME" && ! -d "$HOME/.vim/bundle/$DIR" ]]; then
    git clone -q "git@github.com:$GITHUB" "$HOME/.vim/bundle/$DIR"
    echo "Installed $GITHUB to $HOME/.vim/bundle/$DIR"
  else
    echo "$GITHUB already installed, skipping"
  fi
}

clone_temp_plugin () {
  local GITHUB=$1
  local BASENAME=$(github_basename $GITHUB)
  local DIR="vim-luke-tmp-$BASENAME"

  clone_to_bundle $GITHUB $BASENAME $DIR
}

clone_plugin () {
  local GITHUB=$1
  local BASENAME=$(github_basename $GITHUB)
  local DIR="$BASENAME"

  clone_to_bundle $GITHUB $BASENAME $DIR
}
