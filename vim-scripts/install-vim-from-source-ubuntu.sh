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

echo "Update the apt index"
sudo apt-get update -qq
echo "Ensure curl is installed"
sudo apt-get install curl -qq
echo "Ensure ~/Downloads exists"
mkdir -p ~/Downloads/
echo "Remove old vim source"
sudo rm -rf $vim_source_dir
echo "Download vim tarball"
cd ~/Downloads/ && { curl -s -O -L ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2; cd -; }
echo "Extract vim source"
tar xfj ~/Downloads/vim-7.4.tar.bz2 -C ~/Downloads/

###########################
### Handle ruby support ###
###########################

# - compile with ruby if present
# - ask to install, to compile without, or to abort otherwise

if [[ -x /usr/bin/ruby ]]; then
  compile_with_ruby=true
else
  echo "Ruby may be required for some plugins to work, but it is not installed"
  echo "Do you wish to...?"
  select reply in "Install system ruby 1.9.3" "Compile without ruby" "Abort"; do
    case "${reply}" in
      "Install system ruby 1.9.3" )
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

if $install_ruby; then
  dependencies+=("ruby1.9.3")
fi

if $compile_with_ruby; then
  configure_options+=(
    "--enable-rubyinterp"
    "--with-ruby-command=/usr/bin/ruby"
  )
fi

##########################################
### Install and remove system packages ###
##########################################

echo "Remove Ubuntu packages for Vim"
sudo apt-get remove -y -qq  \
  vim                       \
  vim-runtime               \
  gvim                      \
  vim-tiny                  \
  vim-common                \
  vim-gui-common            \
  vim-gnome                 \

echo "Install dependencies"
dependencies+=(
  "libncurses5-dev"
  "libgnome2-dev"
  "libgnomeui-dev"
  "libgtk2.0-dev"
  "libatk1.0-dev"
  "libbonoboui2-dev"
  "libcairo2-dev"
  "libperl-dev"
  "libx11-dev"
  "libxpm-dev"
  "libxt-dev"
  "libxtst-dev"
  "python-dev"
  "git-core"
)

dependencies=${dependencies[*]}

sudo apt-get install -y -qq $dependencies

###############################
### Compile and install vim ###
###############################

cd $vim_source_dir

configure_options+=(
  "--with-features=huge"
  "--with-x"
  "--enable-pythoninterp"
  "--enable-perlinterp"
  "--enable-gui=gtk2"
  "--enable-cscope"
  "--prefix=/usr"
)

configure_options=${configure_options[*]}

./configure $configure_options

make VIMRUNTIMEDIR=/usr/share/vim/vim74

sudo make install

##########################################
### Backup compiled source and cleanup ###
##########################################

cd ~/Downloads

archive_filename="vim74-compiled-$(date -d "today" +"%Y-%m-%d_%H-%M-%S").tar.gz"
echo "Archive source to ${archive_filename} for future uninstall."
tar cfz ~/Downloads/$archive_filename $vim_source_dir

echo "Remove source dir"
rm -rf $vim_source_dir

###############################
### Set default system vim ####
###############################

echo "Add vim to the alternatives"
#                                  <link>          <group>  <path>          <priority>
sudo update-alternatives --install /usr/bin/editor editor   /usr/bin/vim    00
#                              <group>  <path>
sudo update-alternatives --set editor   /usr/bin/vim

########################
### Print final info ###
########################

echo "To uninstall, unpack the latest source archive, cd to it, and run:"
echo
echo "    sudo make uninstall"
echo
echo "Run 'vim --version' to get full info about this install"
