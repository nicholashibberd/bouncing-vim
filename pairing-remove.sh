#!/usr/bin/env bash

cd "$HOME/.vim/bundle"

# always expand the glob pattern (in ls and cd commands for example)
shopt -s globstar

rm -rfv vim-luke-tmp-*
