#!/usr/bin/env bash

set -e

WEMUX_INSTALL_DIR=/usr/local/share/wemux

echo
echo "--- Install wemux ---"
echo

if [[ $(command -v wemux) ]]; then
  echo "wemux was already installed"
else
  sudo git clone --quiet git://github.com/zolrath/wemux.git $WEMUX_INSTALL_DIR
  echo "Cloned wemux to ${WEMUX_INSTALL_DIR}"
fi

sudo ln -sf ${WEMUX_INSTALL_DIR}/wemux /usr/local/bin/wemux
echo "wemux executable symlinked at /usr/local/bin/wemux"

sudo cp ${WEMUX_INSTALL_DIR}/wemux.conf.example /usr/local/etc/wemux.conf
echo "wemux sample config copied to /usr/local/etc/wemux.conf"

sudo sed -r -i "s/host_list=\(.+\)/host_list=\(${USER}\)/" /usr/local/etc/wemux.conf
echo "Ensure current user authorized to create wemux servers"

echo
echo "--- What to do next? ---"
echo
echo "1 - Start a wemux server with wemux start"
echo "2 - Run 'chmod 1777 /tmp/wemux-wemux' in order to enable other users to attach"
echo "3 - When the guest has ssh'ed into this machine, make her attach:"
echo "    wemux allows three modes:"
echo "    $ wemux mirror # => read-only"
echo "    $ wemux pair   # => host and guest share the same tmux window"
echo "    $ wemux rogue  # => host and guest can use different tmux windows"
