#!/usr/bin/env bash

SCRIPTPATH="/usr/local/etc/linux-customizations"

function create_symlink_and_backup {
    # If destination file already exists and is not a symlink, we should back it up
    if [ -e "$1" ] && [ ! -h "$1" ]; then
        bk="$1.bak$(date +%s)"
        mv $1 $bk >/dev/null && echo "Moved existing $1 to $bk"
    fi
    ln -fs $2 $1 && echo "Symlinked $1 to point at $2" || echo "Failed to symlink $1 to point at $2"
}
create_symlink_and_backup ~/.nanorc $SCRIPTPATH/.nanorc
create_symlink_and_backup ~/.tmux.conf $SCRIPTPATH/.tmux.conf

bashextra="$SCRIPTPATH/.bashrc.extra"
includestmt=". $bashextra"
function install_bash {
    if grep -Fxq "$includestmt" "$1" 2>/dev/null; then
        echo "Your $1 already includes $bashextra"
    else
        if echo -e "\n$includestmt" >> "$1"; then
            echo "Updated $1 to include $bashextra"
        else
            echo "Failed to modify $1"
            return 1
        fi
    fi
}
install_bash ~/.bashrc
if [[ "$(uname)" == "Darwin" ]]; then
    # When new terminal windows are opened, only ~/.bash_profile is loaded. But when 'bash' is run manually, only ~/.bashrc is loaded. So we must link ourselves into both.
    install_bash ~/.bash_profile
fi
