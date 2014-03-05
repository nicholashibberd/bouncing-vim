#!/usr/bin/env bash

set -e

currdir=$( dirname $0 )

source "${currdir}/../utils.sh"
source "${currdir}/vim-utils.sh"

vim_repo_dir="${HOME}/Downloads/vim-hg"
vim_source_dir="${HOME}/Downloads/vim-src"

pull_vim_repo "${vim_repo_dir}" "${vim_source_dir}"

# These variables have to computed after pulling, otherwise the source dir would
# not be available to get the necessary data.
version_full=$(get_vim_version_full "${vim_source_dir}")
vim_package_dir="${HOME}/Downloads/vim-${version_full}-amd64-precise"

install_dependencies "${currdir}/vim-dependencies-precise.txt"

vim_configure_and_make "${vim_source_dir}"

make_install_for_package "${vim_source_dir}" "${vim_package_dir}"

create_control_file "${vim_source_dir}" \
                    "${vim_package_dir}" \
                    "${currdir}/vim-dependencies-precise.txt" \
                    "${currdir}/vim-deb-package-control-file" \
                    "${version_full}" \

dpkg-deb --build "${vim_package_dir}"
