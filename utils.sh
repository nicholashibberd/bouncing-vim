#!/usr/bin/env bash

get_github_basename () {
  echo "$1" | sed -E 's|.+\/(.+)$|\1|g'
}

utc_timestamp () {
  date -u -d "today" +"%Y%m%dT%H%M%SZ"
}

link_rcfile () {
  local rcfile=$1
  local additional_message=$2

  local rcfile_fullpath="${HOME}/.${rcfile}"
  local rcfile_bkp_path="${HOME}/${rcfile}.$(utc_timestamp).bkp"
  local source_rcfile="${HOME}/.vim/bundle/bouncing-vim/rc-files/${rcfile}"

  echo
  echo "Some of the features require specific configuration, provided by"
  echo "${source_rcfile}"
  echo "You can now link to the ${rcfile} provided."
  echo "(your ${rcfile} will be backed up if present)"
  echo "Do you want to create a symlink? [y/N]: "
  read -r

  if [[ $REPLY =~ ^[Yy] ]]; then
    if [[ -e "${rcfile_fullpath}" && ! -L "${rcfile_fullpath}" ]]; then
      printf "[move] " && mv -v "${rcfile_fullpath}" "${rcfile_bkp_path}"
    else
      echo "No previous ${rcfile} to backup."
    fi

    printf "[symlink] " && ln -sfv "${source_rcfile}" "${rcfile_fullpath}"
  else
    echo "Inspect the provided ${rcfile} for more info."
    echo "${source_rcfile}"
    echo "${additional_message}"
  fi
}
