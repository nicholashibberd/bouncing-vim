#!/usr/bin/env bash

# always expand the glob pattern (in ls and cd commands for example)
shopt -s globstar

rm -rfv ~/.vim/bundle/bouncing-vim-tmp-*
