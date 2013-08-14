#!/usr/bin/env bash

set -e

currdir=$( dirname "$( readlink -f $0 )" )

source "$currdir/util-functions.sh"
source "$currdir/plugins.sh"

for plugin in ${ESSENTIALS[@]}; do
  clone_plugin "$plugin"
done

for plugin in ${NICE_TO_HAVES[@]}; do
  clone_plugin "$plugin"
done
