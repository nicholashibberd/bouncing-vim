#!/usr/bin/env bash

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

vim_make_install_system_wide () {
  local vim_source_dir=$1

  cd "${vim_source_dir}"

  echo "run make install"
  sudo make install

  cd -
}

vim_make_install_for_package () {
  local vim_source_dir=$1
  local vim_package_dir=$2

  rm -rf "${vim_package_dir}"
  mkdir -p "${vim_package_dir}"

  cd "${vim_source_dir}"

  make install DESTDIR="${vim_package_dir}"

  cd -
}

archive_vim_source () {
  local vim_source_dir=$1
  local vim_version_full=$(get_vim_version_full "${vim_source_dir}")
  local archive_filename="vim-${vim_version_full}-compiled-$(date -u -d "today" +"%Y%m%dT%H%M%SZ").tar.gz"
  local source_basepath=$(dirname "${vim_source_dir}")
  local source_basename=$(basename "${vim_source_dir}")

  echo "Archive source to ${archive_filename} for future uninstall."
  tar czf "${source_basepath}/${archive_filename}" -C "${source_basepath}" "${source_basename}"

  echo "Remove source dir"
  rm -rf $vim_source_dir
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

create_vim_control_file () {
  local source_dir=$1
  local package_dir=$2
  local dependency_file=$3
  local template=$4
  local version=$5

  SAVE_IFS=$IFS
  IFS=$'\n'
  local dependencies=($(cat $dependency_file))
  IFS=$SAVE_IFS

  local dependencies_csv_list=$(printf ", %s" "${dependencies[@]}")
  dependencies_csv_list=${dependencies_csv_list:2}

  mkdir -vp "${package_dir}/DEBIAN"

  awk \
    -F: \
    -v dependencies_csv_list="${dependencies_csv_list}" \
    -v version="${version}" \
  '{
    if ($1 ~ "Depends")
      print $1 ": " dependencies_csv_list
    else if ($1 ~ "Version")
      print $1 ": " version
    else
      print $0
    }' "${template}" > "${package_dir}/DEBIAN/control"

  echo "Create control file for deb package in ${package_dir}/DEBIAN/control"
}
