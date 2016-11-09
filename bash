# This file should be made world-readable, and then included it into /etc/bash.bashrc,
# so it will apply to both user and root accounts

# Terminal color codes
# Note that the \[ and \] are used to exclude those portions from bash's character count, thus avoiding alignment issues
    clrreset="\[\e[m\]"
    fc_black="\[\e[0;30m\]"
    fc_red="\[\e[0;31m\]"
    fc_green="\[\e[0;32m\]"
    fc_yellow="\[\e[0;33m\]"
    fc_blue="\[\e[0;34m\]"
    fc_magenta="\[\e[0;35m\]"
    fc_cyan="\[\e[0;36m\]"
    fc_white="\[\e[0;37m\]"
    fc_black_b="\[\e[1;30m\]"
    fc_red_b="\[\e[1;31m\]"
    fc_green_b="\[\e[1;32m\]"
    fc_yellow_b="\[\e[1;33m\]"
    fc_blue_b="\[\e[1;34m\]"
    fc_magenta_b="\[\e[1;35m\]"
    fc_cyan_b="\[\e[1;36m\]"
    fc_white_b="\[\e[1;37m\]"
    fc_black_u="\[\e[4;30m\]"
    fc_red_u="\[\e[4;31m\]"
    fc_green_u="\[\e[4;32m\]"
    fc_yellow_u="\[\e[4;33m\]"
    fc_ulue_u="4[\e[4;34m\]"
    fc_magenta_u="\[\e[4;35m\]"
    fc_cyan_u="\[\e[4;36m\]"
    fc_white_u="\[\e[4;37m\]"
    bc_black="\[\e[40m\]"
    bc_red="\[\e[41m\]"
    bc_green="\[\e[42m\]"
    bc_yellow="\[\e[43m\]"
    bc_blue="\[\e[44m\]"
    bc_magenta="\[\e[45m\]"
    bc_cyan="\[\e[46m\]"
    bc_white="\[\e[47m\]"

# Custom terminal prompt
    function __prompt_command() {
        local EXIT="$?"             # This needs to be first
        if [ -z "$VIRTUAL_ENV" ]; then
            local PS1VENV=""
        else
            local PS1VENV="${fc_magenta_b}[venv]${clrreset} "
        fi
        if [[ ${EUID} == 0 ]] ; then
            # Root user
            local PS1BASE="${fc_blue_b}\w ${PS1VENV}${fc_red}\u#${clrreset} "
        else
            # Normal user
            local PS1BASE="${fc_blue_b}\w ${PS1VENV}${fc_green}\u>${clrreset} "
        fi
        if [ $EXIT != 0 ]; then
            # Last command failed
            PS1="${fc_yellow}$(date '+%H:%M:%S') ${fc_white_b}${bc_red}ERR=$EXIT${clrreset} ${PS1BASE}"
        else
            # Last command succeeded
            PS1="${fc_yellow}$(date '+%H:%M:%S')${clrreset} ${PS1BASE}"
        fi
    }
    PROMPT_COMMAND="__prompt_command"



# Add color
    alias grep='grep --colour=auto'
    alias egrep='egrep --colour=auto'
    alias fgrep='fgrep --colour=auto'
    alias ls='ls --color=auto'
    alias tree='tree -C'

# Aliases just to shorten things
    alias ..='cd ..'
    alias cd..='cd ..'
    alias c='clear'
    alias h='history'

# Show more information on jobs
    alias jobs='jobs -l'

# Make parent folders if necessary
    alias mkdir='mkdir -pv'

# Show various log files, and follow them for future changes
    alias fwl='sudo tail -f /var/log/ufw.log'
    alias msg='sudo tail -f /var/log/syslog'

# Customize my standard ls display
    alias l="ls -lhvF --time-style='+%F %r ' --group-directories-first"
    alias la="ls -AlhvF --time-style='+%F %r ' --group-directories-first"

# List files in date order, newest on top
    alias lt="echo '-------NEWEST-------' && ls -AlhvFt --time-style='+%F %r ' && echo '-------OLDEST-------'"

# Show file permissions in numeric format in addition to the standard
    alias lp='l | awk '\''{
        k = 0
        s = 0
        for( i = 0; i <= 8; i++ )
        {
                k += ( ( substr( $1, i+2, 1 ) ~ /[rwxst]/ ) * 2 ^( 8 - i ) )
        }
        j = 4
        for( i = 4; i <= 10; i += 3 )
        {
                s += ( ( substr( $1, i, 1 ) ~ /[stST]/ ) * j )
                j/=2
        }
        if ( k )
        {
                printf( "%0o%0o ", s, k )
        }
        print
    }'\'

# Show my own processes, with 3/10sec refresh rate
    alias t='htop -d 3 -u $USER'

# Copy to clipboard (must install xclip first)
    alias pbcopy='xclip -selection clipboard'

# tcpdump
    alias moneth='sudo tcpdump -n -i eth0'
    alias monwlan='sudo tcpdump -n -i wlan0'

# Show mounts in aligned columns
    alias m='mount | column -t'

# From within a VM, mount a shared folder from the host machine
    mountvbox() {
        sudo mkdir -p /mnt/$1 && sudo mount -t vboxsf $1 /mnt/$1 && l /mnt/$1
    }

# Show the $PATH environment variable with each entry on its own line
    alias path='echo -e ${PATH//:/\\n}'

# Make rm safer by preventing user from accidentally removing '/', and prompt if deleting more than 3 files
    alias rm='rm -I --preserve-root'

# Make mv and cp safer by prompting before overwriting any files
    alias mv='mv -i'
    alias cp='cp -i'

# Make ln safer by prompting whether to remove destinations
    alias ln='ln -i'

# Make these safer by preventing any changes to '/'
    alias chown='chown --preserve-root'
    alias chmod='chmod --preserve-root'
    alias chgrp='chgrp --preserve-root'

# Show IP addresses in columns
    alias i='ip -o addr | column -t | cut -c -$COLUMNS'

# Show human-readable numbers
    alias df='df -h'

# Show sizes in MB
    alias free='free -m'

# Show every line of a file that is NOT commented out
    alias nocomment="grep -v -e '^\s*[#;]' -e '^$'"

# List all aliases and functions
    alias al='echo "Aliases:"; alias; echo; echo "Functions (see code with type <name>):"; declare -F -p | cut -d " " -f 3 | grep -v "^_"'

# Some useful git aliases
# show current status of local store
    alias gs='git status -sb; echo; git log -3 --oneline --decorate'
    alias gsw='watch -d --color -n 10 "git status -sb; echo; git log -3 --oneline --decorate"'
# Unstage a file, by resetting the file to the HEAD
    alias gu='git reset HEAD --'
# Run a git diff, followed by a git add if requested
    ga() {
        [ $# -eq 1 ] || return 1
        echo
        git diff $1
        echo
        echo -n "Would you like to perform 'git add' on this same file? (y/N)"
        read ans
        if [ "$ans" == "y" ] || [ "$ans" == "Y" ]; then
            git add -v $1
        fi
        echo
    }

# Output a horizontal rule to visually separate projects
    alias e="echo -e '\n========================================================\n'"

# Fix the file permissions recursively that Sublime Text v2 messes up
    alias fixperms='find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;'

# Allow aliases to work even when using sudo
alias sudo='sudo '

# Restore the auto service/file completion after the “sudo” command
    complete -cf sudo

# Set default editor
    export EDITOR=nano

# Various customizations to the command history
    export HISTCONTROL=ignoreboth       # Ignore any command that begins with whitespace, and also do not store duplicate commands in the history
    typeset -r HISTCONTROL              # (mark this option read-only)
    export HISTSIZE=2000
    typeset -r HISTSIZE                 # (mark this option read-only)
    export HISTFILESIZE=${HISTSIZE}
    typeset -r HISTFILESIZE             # (mark this option read-only)
    export HISTIGNORE=
    typeset -r HISTIGNORE               # (mark this option read-only)
    export HISTTIMEFORMAT="%F %r | "    # Format the history with datestamps
    typeset -r HISTTIMEFORMAT           # (mark this option read-only)
    shopt -s cmdhist                    # Put multi-line commands on one line
    shopt -s histappend                 # Append instead of overwriting the entire file

# Other shell options
    shopt -s cdspell                    # Minor errors in the spelling of a directory component in a cd command will be corrected
    shopt -s checkwinsize               # Check the window size after each command and, if necessary, updates the values of LINES and COLUMNS
    shopt -s dotglob                    # Include filenames beginning with a . in the results of filename expansion
    shopt -s expand_aliases             # Aliases are expanded too
    shopt -s extglob                    # Extended pattern matching features are enabled

# Be notified asynchronously about completed background jobs
    set -o notify

# Shows running processes, and optionally filters based on the name passed
    p() {
        if [[ -z "$1" ]]; then
            ps -aux
        else
            ps -aux | grep $1 | grep -v grep
        fi
    }

# Extends the information displayed by the 'which' command
# Usage: wh <command>
    wh() {
        loc=$(which $1)
        if [[ -z "$loc" ]]; then
            echo "Command not found: $1"
        else
            ls -l $loc
            file -bkrLz $loc
            echo
            whatis $1
        fi
    }

# Opens the specified file with nano, and will prompt for sudo password if it is not writeable
# Usage: edit <file>
    edit() {
        if [[ -f "$1" ]]; then
            if [[ -w "$1" ]]; then
                $EDITOR "$1"
            else
                echo "File is not writable; opening it with sudo..."
                sudo $EDITOR "$1"
            fi
        else
            echo "File does not exist: $(readlink -f "$1")"
        fi
    }

# Recursively search all files within the current directory
# Usage: grepr <searchtext>
grepr() {
    grep --color=auto -nr "$1" *
}

# Set the window/tab title
# Usage: settitle <title>
    function settitle() {
        echo -e "\033]0; $* \007";
    }

# Automatically extract files
# Usage: extract <file>
    extract() {
        if [ -f $1 ] ; then
            case $1 in
                *.tar.bz2)   tar xjf $1   ;;
                *.tar.gz)    tar xzf $1   ;;
                *.bz2)       bunzip2 $1   ;;
                *.rar)       unrar x $1     ;;
                *.gz)        gunzip $1    ;;
                *.tar)       tar xf $1    ;;
                *.tbz2)      tar xjf $1   ;;
                *.tgz)       tar xzf $1   ;;
                *.zip)       unzip $1     ;;
                *.Z)         uncompress $1;;
                *.7z)        7z x $1      ;;
                *)           echo "'$1' cannot be extracted via ex()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    }

# Search for and activate a Python virtual environment
    ve() {
        if [ -z "$VIRTUAL_ENV" ]; then
            _ve bin/activate ||
            _ve venv/bin/activate ||
            _ve .venv/bin/activate ||
            _ve ../venv/bin/activate ||
            _ve ../.venv/bin/activate ||
            _ve ../../venv/bin/activate ||
            _ve ../../.venv/bin/activate ||
            echo "ERROR: Could not find a virtual environment to source."
        else
            echo
            venv="$VIRTUAL_ENV"
            deactivate
            echo -e "\e[1;35mDeactivated virtual environment $venv\e[m"
            echo
            echo
        fi
    }
    _ve() {
        if [[ -f "$1" ]]; then
            echo
            echo
            . "$1"
            echo -e "\e[1;35mYou are now using virtual environment $VIRTUAL_ENV\e[m"
            echo
            return 0
        else
            return 1
        fi
    }
