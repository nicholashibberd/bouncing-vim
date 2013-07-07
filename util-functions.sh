#!/usr/bin/env bash

set -e

get_basename () {
  echo "$GITHUB" | sed -r 's|.+\/(.+)\.git$|\1|g'
}

clone_to_bundle_dir () {
  local GITHUB=$1
  local BASENAME=$2
  local DIR=$3
  if [[ ! -d "$HOME/.vim/bundle/$BASENAME" ]]; then
    echo
    git clone "git@github.com:$GITHUB" "$HOME/.vim/bundle/$DIR"
  else
    echo 
    echo "$GITHUB already installed, skipping"
  fi

}

clone_temp_plugin () {
  local GITHUB=$1
  local BASENAME=$(get_basename $GITHUB)
  local DIR="vim-luke-tmp-$BASENAME"

  clone_to_bundle_dir $GITHUB $BASENAME $DIR
}

clone_plugin () {
  local GITHUB=$1
  local BASENAME=$(get_basename $GITHUB)
  local DIR="$BASENAME"

  clone_to_bundle_dir $GITHUB $BASENAME $DIR
}
