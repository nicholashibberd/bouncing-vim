#!/usr/bin/env bash

set -e

currdir=$( dirname "$( readlink -f $0 )" )

source "${currdir}/../utils.sh"
source "${currdir}/../plugins.sh"

for plugin in ${ESSENTIALS[@]}; do
  clone_temp_plugin "${plugin}"
done
