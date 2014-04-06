#!/usr/bin/env bash

set -e

currdir=$(cd "$(dirname $0)" && pwd -P)

source "${currdir}/../utils.sh"
source "${currdir}/plugins.sh"

for plugin in ${ESSENTIALS[@]}; do
  install_tmp_plugin_with_pathogen "${plugin}"
done
