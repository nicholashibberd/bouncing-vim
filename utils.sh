#!/usr/bin/env bash

github_basename () {
  echo "$1" | sed -E 's|.+\/(.+)$|\1|g'
}

clone_to_bundle () {
  local GITHUB=$1
  local BASENAME=$2
  local DIR=$3

  if [[ ! -d "$HOME/.vim/bundle/$BASENAME" && ! -d "$HOME/.vim/bundle/$DIR" ]]; then
    echo "Install $GITHUB to $HOME/.vim/bundle/$DIR"
    git clone -q "https://github.com/${GITHUB}.git" "$HOME/.vim/bundle/$DIR"
  else
    echo "$GITHUB already installed, skipping"
  fi
}

install_tmp_plugin_with_pathogen () {
  local GITHUB=$1
  local BASENAME=$(github_basename $GITHUB)
  local DIR="bouncing-vim-tmp-$BASENAME"

  clone_to_bundle $GITHUB $BASENAME $DIR
}

install_plugin_with_pathogen () {
  local GITHUB=$1
  local BASENAME=$(github_basename $GITHUB)
  local DIR="$BASENAME"

  clone_to_bundle $GITHUB $BASENAME $DIR
}

# Read the dependencies from an external file, and save them in an array named dependencies
install_dependencies () {
  local dependency_file=$1

  SAVE_IFS=$IFS
  IFS=$'\n'
  local dependencies=($(cat $dependency_file))
  IFS=$SAVE_IFS

  local dependency_list=${dependencies[*]}

  sudo apt-get update
  sudo apt-get install -y $dependency_list
}

create_control_file () {
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

make_install_default () {
  local source_dir=$1

  cd "${source_dir}"

  echo "run make install"
  sudo make install

  cd -
}

make_install_for_package () {
  local source_dir=$1
  local package_dir=$2

  rm -rf "${package_dir}"
  mkdir -p "${package_dir}"

  cd "${source_dir}"

  make install DESTDIR="${package_dir}"

  cd -
}
