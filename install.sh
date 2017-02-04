#!/usr/bin/env bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

ln -fs $SCRIPTPATH/.nanorc ~ && echo "Installed .nanorc" || echo "Failed to install .nanorc"
ln -fs $SCRIPTPATH/.tmux.conf ~ && echo "Installed .tmux.conf" || echo "Failed to install .tmux.conf"

bashextra=". $SCRIPTPATH/.bashrc.extra"
function install_bash {
  if [ -e $1 ]; then
    (grep  -Fxq "$bashextra" "$1" || echo "$bashextra" >> "$bashconf") && echo "Installed .bashrc.extra" || return 1
  else
    return 1
  fi
}
install_bash ~/.bashrc || echo "Failed to install .bashrc.extra"
