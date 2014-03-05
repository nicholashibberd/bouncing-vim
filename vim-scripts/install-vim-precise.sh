#!/usr/bin/env bash

# Info:
# - https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
# - http://stackoverflow.com/questions/11416069/compile-vim-with-clipboard-and-xterm
# - http://www.vimninjas.com/2012/09/21/vim-ruby-python/
#
# For a list of configure options:
# - in src/auto/configure look for ac_user_opts
# - :h +feature-list and :h feature-list

set -e

currdir=$( dirname $0 )

source "${currdir}/../utils.sh"
source "${currdir}/vim-utils.sh"

vim_repo_dir="${HOME}/Downloads/vim-hg"
vim_source_dir="${HOME}/Downloads/vim-src"

echo
echo "--- [step 1] Download source ---"
echo

pull_vim_repo "${vim_repo_dir}" "${vim_source_dir}"

echo
echo "--- [step 2] Remove Vim packages ---"
echo

remove_vim_packages

echo
echo "--- [step 3] Install dependencies ---"
echo

install_dependencies "${currdir}/vim-dependencies-precise.txt"

echo
echo "--- [step 4] Compile and install vim ---"
echo

vim_configure_and_make "${vim_source_dir}"
vim_make_install_system_wide "${vim_source_dir}"

echo
echo "--- [step 5] Backup compiled source and cleanup ---"
echo

archive_vim_source "${vim_source_dir}"

echo
echo "--- [step 6] Set default system vim ---"
echo

set_default_vim

echo
echo "--- [step 7] Summary ---"
echo

echo "To uninstall, unpack the latest source archive, cd to it, and run:"
echo
echo "    sudo make uninstall"
echo
echo "Run 'vim --version' to get full info about this install"
