#!/usr/bin/env bash

github_basename () {
  echo "$1" | sed -E 's|.+\/(.+)$|\1|g'
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

get_source_from_tarball () {
  local download_url=$1
  local tarball_fullpath=$2
  local source_dir=$3

  local tarball_basepath=$(dirname "${tarball_fullpath}")
  local tarball_basename=$(basename "${tarball_fullpath}")

  echo "Ensure any old source dir is removed"
  rm -rf "${source_dir}"

  mkdir -v -p "${source_dir}"
  mkdir -v -p "${tarball_basepath}"

  if [[ -f "${tarball_fullpath}" ]]; then
    echo "${tarball_basename} already downloaded"
  else
    echo "Download ${tarball_basename}"
    curl -o "${tarball_fullpath}" -L "${download_url}"
  fi

  echo "Extract source archive"
  tar xvf "${tarball_fullpath}" -C "${source_dir}" --strip-components=1
}

archive_source () {
  local source_dir=$1
  local appname=$2
  local version=$3

  local timestamp=$(date -u -d "today" +"%Y%m%dT%H%M%SZ")
  local archive_filename="${appname}-${version}-compiled-${timestamp}.tar.gz"
  local source_basepath=$(dirname "${source_dir}")
  local source_basename=$(basename "${source_dir}")

  echo "Archive source to ${archive_filename} for future uninstall."
  tar czf "${source_basepath}/${archive_filename}" -C "${source_basepath}" "${source_basename}"

  echo "Remove source dir"
  rm -rf $source_dir
}
