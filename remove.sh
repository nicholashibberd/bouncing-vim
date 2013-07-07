#!/usr/bin/env bash

cd "$HOME/.vim/bundle"

# always expand the glob pattern (in ls and cd commands for example)
shopt -s globstar
# enable the inverse detection, for example ls !(b*)
shopt -s extglob

rm vim-luke-tmp-*
