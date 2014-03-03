#!/usr/bin/env bash

currdir=$( dirname $0 )

dependencies_csv_list='MOOOOOOOOOOOOOO'
version=9999999

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
}' "${currdir}/vim-deb-package-control-file" > "${currdir}/control"

# # Get the latest patch number to be used to set the version of the package
# grep 'static int included_patches\[\]' -A3 ~/Downloads/vim74/src/version.c | \
#   tail -n 1 | \
#   perl -pe 's|.+?([0-9]+).+|\1|'

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
