#!/usr/bin/env bash

CURRDIR=$(cd "$(dirname $0)" && pwd -P)

source "${CURRDIR}/../utils.sh"

clone_to_bundle_with_home () {
  local github_project=$1
  local home_dir=$2

  local github_basename=$(get_github_basename $github_project)
  local plugin_dir="${home_dir}/.vim/bundle/$github_basename"

  if [[ ! -d "${plugin_dir}" ]]; then
    echo "[install] $github_project -> ${plugin_dir}"
    git clone -q "https://github.com/${github_project}.git" "${plugin_dir}"
  else
    echo "[skip] $github_project -> (already installed)"
  fi
}

_get_std_plugin_dir () {
  local github_project=$1
  local github_basename=$(get_github_basename $github_project)
  echo "${HOME}/.vim/bundle/${github_basename}"
}

_get_tmp_plugin_dir () {
  local github_project=$1
  local github_basename=$(get_github_basename $github_project)
  echo "${HOME}/.vim/bundle/bouncing-vim-tmp-${github_basename}"
}

install_plugin_with_pathogen () {
  local github_project=$1
  local std_plugin_dir=$(_get_std_plugin_dir "${github_project}")
  local tmp_plugin_dir=$(_get_tmp_plugin_dir "${github_project}")

  if [[ -d "${tmp_plugin_dir}" ]]; then
    echo "[rename] tmp location: ${tmp_plugin_dir} -> ${std_plugin_dir}"
    mv "${tmp_plugin_dir}" "${std_plugin_dir}"
  elif [[ -d "${std_plugin_dir}" ]]; then
    echo "[skip] $github_project -> already installed"
  else
    echo "[install] $github_project -> ${std_plugin_dir}"
    git clone -q "https://github.com/${github_project}.git" "${std_plugin_dir}"
  fi
}

install_tmp_plugin_with_pathogen () {
  local github_project=$1

  local std_plugin_dir=$(_get_std_plugin_dir "${github_project}")
  local tmp_plugin_dir=$(_get_tmp_plugin_dir "${github_project}")

  if [[ -d "${std_plugin_dir}" || -d "${tmp_plugin_dir}" ]]; then
    echo "[skip] $github_project -> already installed"
  else
    echo "[install] $github_project -> ${tmp_plugin_dir}"
    git clone -q "https://github.com/${github_project}.git" "${tmp_plugin_dir}"
  fi
}

pull_vim_repo () {
  local vim_repo_dir=$1
  local vim_source_dir=$2

  mkdir -vp ~/Downloads/

  echo "Remove old vim source"
  sudo rm -rf $vim_source_dir

  sudo apt-get install -y mercurial

  echo "Pull vim source from googlecode.com"

  if [[ -d "${vim_repo_dir}" ]]; then
    cd "${vim_repo_dir}"
    hg pull -u
    cd -
  else
    hg clone https://vim.googlecode.com/hg/ "${vim_repo_dir}"
  fi

  cp -R "${vim_repo_dir}" "${vim_source_dir}"
  rm -rf "${vim_source_dir}/.hg"
  rm -f "${vim_source_dir}/.hgignore"
  rm -f "${vim_source_dir}/.hgtags"
}

remove_vim_packages () {
  sudo apt-get remove -y \
    vim                  \
    vim-runtime          \
    gvim                 \
    vim-tiny             \
    vim-common           \
    vim-gui-common       \
    vim-gnome
}

has_pathogen () {
  if [[ -n $(find ~/.vim -name pathogen.vim) ]]; then
    return 0
  else
    return 1
  fi
}

install_pathogen () {
  echo "Install pathogen to handle your plugins"
  curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
}

vim_configure_and_make () {
  local vim_source_dir=$1

  local configure_options=(
    "--enable-rubyinterp"
    "--with-ruby-command=/usr/bin/ruby"
    "--disable-gui"
    "--with-features=huge"
    "--with-x"
    "--enable-luainterp"
    "--enable-pythoninterp"
    "--enable-perlinterp"
    "--enable-cscope"
    "--prefix=/usr"
  )

  local configure_option_list=${configure_options[*]}
  local vim_runtime_dirname=$(get_vim_version_nodot "${vim_source_dir}")

  cd $vim_source_dir

  echo "run ./configure"
  ./configure --quiet $configure_option_list

  echo "run make"
  make VIMRUNTIMEDIR="/usr/share/vim/${vim_runtime_dirname}"

  cd -
}

set_default_vim () {
  echo "Add vim to the alternatives"
  #                                  <link>          <group>  <path>          <priority>
  sudo update-alternatives --install /usr/bin/editor editor   /usr/bin/vim    00
  #                              <group>  <path>
  sudo update-alternatives --set editor   /usr/bin/vim
}

# Get the latest patch number to be used to set the version of the package
get_vim_patch_number () {
  local vim_source_dir=$1

  grep 'static int included_patches\[\]' -A3 "${vim_source_dir}/src/version.c" | \
    tail -n 1 | \
    perl -pe 's|.+?([0-9]+).+|\1|'
}

_get_vim_version_ () {
  local vim_source_dir=$1
  local VERSION_TYPE=$2

  grep "define VIM_VERSION_${VERSION_TYPE}" "${vim_source_dir}/src/version.h" | \
    perl -pe 's|.+"(.+)"|\1|'
}

get_vim_version_nodot () {
  local vim_source_dir=$1

  _get_vim_version_ $vim_source_dir "NODOT"
}

get_vim_version_short () {
  local vim_source_dir=$1

  _get_vim_version_ $vim_source_dir "SHORT"
}

get_vim_version_full () {
  local vim_source_dir=$1

  local version_short=$(get_vim_version_short "${vim_source_dir}")
  local patch_number=$(get_vim_patch_number "${vim_source_dir}")

  echo "${version_short}.${patch_number}"
}

ls_tmp_plugins () {
  find "${HOME}/.vim/bundle/" -type d -iname 'bouncing-vim-tmp-*'
}

archive_tmp_plugins () {
  local tmp_plugin_name=

  mkdir -p "${HOME}/.vim/_disabled_plugins"

  ls_tmp_plugins | while read tmp_plugin; do
    tmp_plugin_name=$(basename $tmp_plugin)
    mv -v \
      "${tmp_plugin}" \
      "${HOME}/.vim/_disabled_plugins/${tmp_plugin_name}-$(utc_timestamp)"
  done
}
