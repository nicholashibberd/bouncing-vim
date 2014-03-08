#!/usr/bin/env bash

set -e

currdir=$(cd "$(dirname $0)" && pwd -P)

source "${currdir}/../utils.sh"
source "${currdir}/tmux-utils.sh"

TMUX_MINOR_VERSION=1.9
TMUX_PATCHLEVEL=a
TMUX_VERSION="${TMUX_MINOR_VERSION}${TMUX_PATCHLEVEL}"
TMUX_SOURCE_TARBALL="${HOME}/Downloads/tmux-${TMUX_VERSION}.tar.gz"
TMUX_SOURCE_DIR="tmux-${TMUX_VERSION}"
TMUX_SOURCE_PATH="${HOME}/Downloads/tmux-${TMUX_VERSION}"
TMUX_DOWNLOAD_URL="http://downloads.sourceforge.net/project/tmux/tmux/tmux-${TMUX_MINOR_VERSION}/tmux-${TMUX_VERSION}.tar.gz"

tmux_package_dir="${HOME}/Downloads/tmux-${TMUX_VERSION}-amd64-precise"

echo
echo "--- [step 1] Download source ---"
echo

get_source_from_tarball "${TMUX_DOWNLOAD_URL}" \
                        "${TMUX_SOURCE_TARBALL}" \
                        "${TMUX_SOURCE_PATH}" \

install_dependencies "${currdir}/tmux-deps-build-precise.txt"

tmux_configure_and_make "${TMUX_SOURCE_PATH}"

make_install_for_package "${TMUX_SOURCE_PATH}" "${tmux_package_dir}"

create_control_file "${TMUX_SOURCE_PATH}" \
                    "${tmux_package_dir}" \
                    "${currdir}/tmux-deps-runtime-precise.txt" \
                    "${currdir}/tmux-deb-package-control-file" \
                    "${TMUX_VERSION}" \

dpkg-deb --build "${tmux_package_dir}"
