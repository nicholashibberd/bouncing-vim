#!/usr/bin/env bash

set -e

source util-functions.sh
source plugins.sh

for plugin in ${ESSENTIALS[@]}; do
  clone_temp_plugin "$plugin"
done
