#!/usr/bin/env bash



# dependencies+=(
#   "build-essential"
#   "exuberant-ctags"
#   "git"
#   "libacl1"
#   "libc6"
#   "libgpm2"
#   "liblua5.1-0"
#   "liblua5.1-0-dev"
#   "libncurses5-dev"
#   "libperl-dev"
#   "libperl5.14"
#   "libpython2.7"
#   "libselinux1"
#   "libsm6"
#   "libtinfo5"
#   "libx11-6"
#   "libx11-dev"
#   "libxpm-dev"
#   "libxt6"
#   "libxt-dev"
#   "libxtst-dev"
#   "python-dev"
# )

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

# Get the latest patch number to be used to set the version of the package
grep 'static int included_patches\[\]' -A3 ~/Downloads/vim74/src/version.c | \
  tail -n 1 | \
  perl -pe 's|.+?([0-9]+).+|\1|'
