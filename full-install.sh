#!/usr/bin/env bash

set -e

source util-functions.sh
source plugins.sh

for plugin in ${ESSENTIALS[@]}; do
  clone_plugin "$plugin"
done

for plugin in ${NICE_TO_HAVES[@]}; do
  clone_plugin "$plugin"
done
