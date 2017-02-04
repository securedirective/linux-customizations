#!/usr/bin/env bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

function create_symlink {
  ln -fs $2 $1 && echo "Symlinked $1 to $2" || echo "Failed to symlink $1 to $2"
}
create_symlink ~/.nanorc $SCRIPTPATH/.nanorc
create_symlink ~/.tmux.conf $SCRIPTPATH/.tmux.conf

bashextra=". $SCRIPTPATH/.bashrc.extra"
function install_bash {
  if [ -e $1 ]; then
    if (grep  -Fxq "$bashextra" "$1" || echo "$bashextra" >> "$1"); then
      echo "Included .bashrc.extra into $1"
    else
      echo "Failed to include .bashrc.extra into $1"
      return 1
    fi
  else
    echo "Could not find $1"
    return 1
  fi
}
install_bash ~/.bashrc
