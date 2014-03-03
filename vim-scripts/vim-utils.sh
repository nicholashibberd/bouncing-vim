#!/usr/bin/env bash

pull_vim_repo () {
  local vim_repo_dir=$1
  local vim_source_dir=$2

  sudo apt-get update
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

# Read the dependencies from an external file, and save them in an array named dependencies
install_dependencies () {
  local dependency_file=$1

  SAVE_IFS=$IFS
  IFS=$'\n'
  local dependencies=($(cat $dependency_file))
  IFS=$SAVE_IFS

  local dependency_list=${dependencies[*]}

  sudo apt-get install -y $dependency_list
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

  cd $vim_source_dir

  echo "run ./configure"
  ./configure --quiet $configure_option_list

  echo "run make"
  make --quiet VIMRUNTIMEDIR=/usr/share/vim/vim74

  cd -
}

vim_make_install_system_wide () {
  local vim_source_dir=$1

  cd "${vim_source_dir}"

  echo "run make install"
  sudo make install --quiet

  cd -
}

archive_vim_source () {
  local vim_source_dir=$1
  local archive_filename="vim74-compiled-$(date -u -d "today" +"%Y%m%dT%H%M%SZ").tar.gz"
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
