# This file should be stored in ~/.bash_kenneth and made world-readable:
#   chmod u+r,g+r,o+r .bash_kenneth
# Then include it into /etc/bash.bashrc, so it will apply to both user and root accounts:
#   sudo nano /etc/bash.bashrc
#     [...]
#     . /home/user/.bash_kenneth


# Custom terminal prompt
red="\[\e[0;31m\]"
green="\[\e[0;32m\]"
blue="\[\e[0;34m\]"
bluedark="\[\e[1;34m\]"
none="\[\e[m\]"
if [[ ${EUID} == 0 ]] ; then
  # Root user
  PR="${red}#${none}"
else
  # Normal user
  PR="${green}>${none}"
fi
PS1="\$(e=\$?; if [[ e -ne 0 ]]; then echo \"${red}ERR=\${e} ${none}\"; fi)${bluedark}\w${none} ${PR} "

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
alias l="ls -lhvF --time-style='+' --group-directories-first"

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

# List files in date order, newest on top
alias lt="echo '-------NEWEST-------' && ls -lhvFt --time-style='+%F %r  ' && echo '-------OLDEST-------'"

# Show my own processes, with 3/10sec refresh rate
alias t='htop -d 3 -u $USER'

# tcpdump
alias moneth='sudo tcpdump -n -i eth0'
alias monwlan='sudo tcpdump -n -i wlan0'

# Show mounts in aligned columns
alias mount='mount | column -t'

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
alias i='ip -o addr | column -t'

# Show human-readable numbers
alias df='df -h'

# Show sizes in MB
alias free='free -m'

# List all aliases and functions
alias al='echo "Aliases:"; alias; echo; echo "Functions (see code with typeset -f <name>):"; declare -F -p | cut -d " " -f 3 | grep -v "^_"'

# Some useful git aliases
alias gs='git log -3 --oneline --decorate; git status -sb'

# Output a horizontal rule to visually separate projects
alias eb="echo; echo '========================================================'; echo"

# From within a VM, mount a shared folder from the host machine
alias mntvbhost='sudo mkdir -p /mnt/$1 && sudo mount -t vboxsf $1 /mnt/$1 && l /mnt/$1'

# Fix the file permissions recursively that Sublime Text v2 messes up
alias fixperms='find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;'

# Restore the auto service/file completion after the “sudo” command
complete -cf sudo

# Set default editor
export EDITOR=/usr/bin/nano

# Various customizations to the command history
export HISTCONTROL=ignoreboth		# Ignore any command that begins with whitespace, and also do not store duplicate commands in the history
typeset -r HISTCONTROL				# (mark this option read-only)
export HISTSIZE=2000
typeset -r HISTSIZE					# (mark this option read-only)
export HISTFILESIZE=${HISTSIZE}
typeset -r HISTFILESIZE				# (mark this option read-only)
export HISTIGNORE=
typeset -r HISTIGNORE				# (mark this option read-only)
export HISTTIMEFORMAT="%F %r | "	# Format the history with datestamps
typeset -r HISTTIMEFORMAT			# (mark this option read-only)
shopt -s cmdhist					# Put multi-line commands on one line
shopt -s histappend					# Append instead of overwriting the entire file

# Other shell options
shopt -s cdspell					# Minor errors in the spelling of a directory component in a cd command will be corrected
shopt -s checkwinsize				# Check the window size after each command and, if necessary, updates the values of LINES and COLUMNS
shopt -s dotglob					# Include filenames beginning with a . in the results of filename expansion
shopt -s expand_aliases				# Aliases are expanded too
shopt -s extglob					# Extended pattern matching features are enabled

# Be notified asynchronously about completed background jobs
set -o notify

# Shows running processes, and optionally filters based on the name passed
p()
{
  if [[ -z "$1" ]]; then
    ps -aux
  else
    ps -aux | grep $1 | grep -v grep
  fi
}

# Extends the information displayed by the 'which' command
# Usage: wh <command>
wh()
{
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
edit()
{
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

# Set the window/tab title
# Usage: settitle <title>
function settitle()
{
  echo -e "\033]0; $* \007";
}

# Automatically extract files
# Usage: extract <file>
extract()
{
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
ve()
{
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo
    echo
    echo "Deactivating virtual environment $VIRTUAL_ENV"
    deactivate
    echo
    echo
  else
    _ave .env/bin/activate ||
    _ave venv/bin/activate ||
    _ave bin/activate ||
    _ave ../.env/bin/activate ||
    _ave ../venv/bin/activate ||
    _ave ../bin/activate ||
    _ave ../../.env/bin/activate ||
    _ave ../../venv/bin/activate ||
    _ave ../../bin/activate ||
    echo "ERROR: Could not find a virtual environment to source."
  fi
}
_ave()
{
  if [[ -f "$1" ]]; then
    echo
    echo
    echo "Executing 'source $1'"
    source "$1"
    echo "You are now using virtual environment $VIRTUAL_ENV"
    echo
    echo
    return 0
  else
    return 1
  fi
}
