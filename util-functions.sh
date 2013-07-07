#!/usr/bin/env bash

set -e

get_basename () {
  echo "$GITHUB" | sed -r 's|.+\/(.+)\.git$|\1|g'
}

clone_to_bundle_dir () {
  local GITHUB=$1
  local DIR=$2
  if [[ ! -d "$DIR" ]]; then
    git clone "git@github.com:$GITHUB" "$HOME/.vim/bundle/$DIR"
  else
    echo "$GITHUB already installed, skipping"
  fi

}

clone_temp_plugin () {
  local GITHUB=$1
  local BASENAME=$(get_basename $GITHUB)
  local DIR="vim-luke-tmp-$BASENAME"

  clone_to_bundle_dir $GITHUB $DIR
}

clone_plugin () {
  local GITHUB=$1
  local DIR=$(get_basename $GITHUB)

  clone_to_bundle_dir $GITHUB $DIR
}
