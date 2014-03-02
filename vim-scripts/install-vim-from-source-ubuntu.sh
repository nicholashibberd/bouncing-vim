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

vim_source_dir="${HOME}/Downloads/vim74"
compile_with_ruby=false
install_ruby=false
dependencies=()
configure_options=()

#######################
### Download source ###
#######################

echo "--- [step 1] --- Download source"

echo "Update the apt index"
sudo apt-get update

echo "Ensure ~/Downloads exists"
mkdir -p ~/Downloads/

echo "Remove old vim source"
sudo rm -rf $vim_source_dir

echo "Do you wish to download a tarball (faster) or clone the repo (more up to date)?"
select reply in "download" "clone"; do
  case "${reply}" in
    "download" )
      echo "Ensure curl is installed"
      sudo apt-get install curl
      echo "Download vim tarball"
      cd ~/Downloads/ && { curl -O -L ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2; cd -; }
      echo "Extract vim source"
      tar xfj ~/Downloads/vim-7.4.tar.bz2 -C ~/Downloads/
      break ;;
    "clone" )
      sudo apt-get install mercurial
      echo "Clone vim source from googlecode.com"
      hg clone https://vim.googlecode.com/hg/ "${vim_source_dir}"
      break ;;
    * )
      echo "Exit without installing"
      exit 1 ;;
  esac
done

###########################
### Handle ruby support ###
###########################

echo "--- [step 2] --- Handle ruby support"

# - compile with ruby if present
# - ask to install, to compile without, or to abort otherwise

if [[ -x /usr/bin/ruby ]]; then
  echo "Ruby is already installed, nothing to do"
  compile_with_ruby=true
else
  echo "Ruby may be required for some plugins to work, but it is not installed"
  echo "Do you wish to...?"
  select reply in "Install system ruby 1.9.1" "Compile without ruby" "Abort"; do
    case "${reply}" in
      "Install system ruby 1.9.1" )
        install_ruby=true
        compile_with_ruby=true
        break ;;
      "Compile without ruby" )
        break ;;
      "Abort" )
        exit ;;
    esac
  done
fi

###########################
### Remove Vim packages ###
###########################

echo "--- [step 3] --- Remove Vim packages"

echo "Remove Ubuntu packages for Vim"
sudo apt-get remove -y \
  vim                  \
  vim-runtime          \
  gvim                 \
  vim-tiny             \
  vim-common           \
  vim-gui-common       \
  vim-gnome            \

echo "Install dependencies"

############################
### Install dependencies ###
############################

echo "--- [step 4] --- Install dependencies"

if $install_ruby; then
  dependencies+=("libruby1.9.1")
fi

# "libgnome2-dev"
# "libgnomeui-dev"
# "libgtk2.0-dev"
# "libatk1.0-dev"
# "libcairo2-dev"
# "libacl1-dev"
# "libattr1-dev"
# "libc6-dev"
# "libgpm-dev"
# "libreadline-dev"
# "libreadline5"
# "lua5.1"

dependencies+=(
  "build-essential"
  "exuberant-ctags"
  "git"
  "libacl1"
  "libc6"
  "libgpm2"
  "liblua5.1-0"
  "liblua5.1-0-dev"
  "libncurses5-dev"
  "libperl-dev"
  "libperl5.14"
  "libpython2.7"
  "libselinux1"
  "libsm6"
  "libtinfo5"
  "libx11-6"
  "libx11-dev"
  "libxpm-dev"
  "libxt6"
  "libxt-dev"
  "libxtst-dev"
  "python-dev"
)

# "Depends" field for the DEBIAN/control file
#
# exuberant-ctags (>= 5.9)
# git (>= 1.7.9.5-1)
# libacl1 (>= 2.2.51-5)
# libc6 (>= 2.15)
# libgpm2 (>= 1.20.4)
# liblua5.1-0
# libncurses5 (>= 5.9-4)
# libperl5.14 (>= 5.14.2)
# libpython2.7 (>= 2.7)
# libruby1.9.1
# libselinux1 (>= 1.32)
# libsm6
# libtinfo5
# libx11-6
# libxt6
#
# libxpm4 (>= 3.5.9-4)
# libruby1.9.1 (>= 1.9.3.0)

dependencies=${dependencies[*]}

sudo apt-get install -y $dependencies

###############################
### Compile and install vim ###
###############################

echo "--- [step 5] --- Compile and install vim"

if $compile_with_ruby; then
  configure_options+=(
    "--enable-rubyinterp"
    "--with-ruby-command=/usr/bin/ruby"
  )
fi

configure_options+=(
  "--disable-gui"
  "--with-features=huge"
  "--with-x"
  "--enable-luainterp"
  "--enable-pythoninterp"
  "--enable-perlinterp"
  "--enable-cscope"
  "--prefix=/usr"
)

configure_options=${configure_options[*]}

cd $vim_source_dir

echo "run ./configure"
./configure --quiet $configure_options

echo "run make"
make --quiet VIMRUNTIMEDIR=/usr/share/vim/vim74

echo "run make install"
sudo make install --quiet

##########################################
### Backup compiled source and cleanup ###
##########################################

echo "--- [step 6] --- Backup compiled source and cleanup"

cd ~/Downloads

archive_filename="vim74-compiled-$(date -u -d "today" +"%Y%m%dT%H%M%SZ").tar.gz"
echo "Archive source to ${archive_filename} for future uninstall."
# The -C options seems to work in the terminal but not in the script
# tar cfz "~/Downloads/${archive_filename}" -C ~/Downloads vim74
cd ~/Downloads && { tar cfz $archive_filename vim74; cd -; }

echo "Remove source dir"
rm -rf $vim_source_dir

###############################
### Set default system vim ####
###############################

echo "--- [step 7] --- Set default system vim"

echo "Add vim to the alternatives"
#                                  <link>          <group>  <path>          <priority>
sudo update-alternatives --install /usr/bin/editor editor   /usr/bin/vim    00
#                              <group>  <path>
sudo update-alternatives --set editor   /usr/bin/vim

########################
### Print final info ###
########################

echo "--- [step 8] --- Summary"

echo "To uninstall, unpack the latest source archive, cd to it, and run:"
echo
echo "    sudo make uninstall"
echo
echo "Run 'vim --version' to get full info about this install"
