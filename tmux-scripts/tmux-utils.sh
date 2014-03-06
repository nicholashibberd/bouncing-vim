#!/usr/bin/env bash

tmux_configure_and_make () {
  local source_dir=$1

  echo "run ./configure"
  cd "${source_dir}"
  ./configure
  cd -

  echo "run make"
  make -C "${source_dir}"
}
