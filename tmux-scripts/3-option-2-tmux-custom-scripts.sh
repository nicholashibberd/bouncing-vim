#!/usr/bin/env bash

set -e

currdir=$(cd "$(dirname $0)" && pwd -P)

PAIR_USER=pair

BASHRC_FILE="${HOME}/.bashrc"
TMUX_SESSION_SCRIPT="${HOME}/bin/tmux-session"
SHARE_SESSION_SCRIPT="${HOME}/bin/share-session"
ATTACH_SESSION_SCRIPT="${HOME}/bin/attach-session"

echo
echo "--- Setting up the bin directory ---"
echo

mkdir -v -p ~/bin
echo "Ensure ~/bin directory"

if [[ $(echo $PATH | grep "\(^\|:\)${HOME}/bin\(:\|\$\)") ]]; then
  echo "~/bin is already in the PATH"
else
  echo 'export PATH="$HOME/bin:$PATH"' >> $BASHRC_FILE
  source $BASHRC_FILE
  echo '~/bin added to the PATH (export PATH="$HOME/bin:$PATH" added to $BASHRC_FILE)'
fi

echo
echo "--- Copying scripts for tmux paired session ---"
echo

cp -Rv "${currdir}/scripts/." "${HOME}/bin/"

chmod u+x ~/bin/attach-session ~/bin/share-session ~/bin/tmux-session

echo
echo "--- Default login shell for guest user ---"
echo

sudo cp $ATTACH_SESSION_SCRIPT /home/$PAIR_USER/
sudo chown $PAIR_USER:$PAIR_USER /home/$PAIR_USER/attach-session
sudo chmod u+x /home/$PAIR_USER/attach-session
echo "Added the attach-session script to the home of the ${PAIR_USER} user"

sudo sed --follow-symlinks -r -i \
  "s|^(${PAIR_USER}.+):/bin/bash(.*)|\1:/home/${PAIR_USER}/attach-session\2|" \
  /etc/passwd

echo "Changed default login shell of the ${PAIR_USER} user to the attach-session script"
echo "This means that:"
echo "  - the remote user will enter the tmux session automatically after having"
echo "    connected via SSH"
echo "  - the remote user will not be able to login when there is no shared tmux"
echo "    active"
echo "  - the remote user will be disconnected automatically when the tmux"
echo "    session is terminated"

echo
echo "--- What to do next ---"
echo
echo "- Add the public keys of the remote pairs to /home/${PAIR_USER}/.ssh/authorized_keys"
