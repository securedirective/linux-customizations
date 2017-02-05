#!/usr/bin/env bash

# Deterimes Linux distribution type and returns one of the following values:

# redhat
# redhat/fedora
# redhat/rhel
# redhat/centos
# slackware
# slackware/suse
# debian
# debian/ubuntu
# debian/knoppix
# debian/raspbian
# arch

# Each item will be on its own line, so you can use head/tail to check a particular item.

#uname -a 2>/dev/null
#cat /etc/version 2>/dev/null
#cat /proc/version 2>/dev/null
#lsb_release -a 2>/dev/null
#cat /etc/issue 2>/dev/null
#cat /etc/*release


if [ -e "/etc/redhat-release" ]; then
  echo "redhat"
  if [ -e "/etc/centos-release" ]; then
    echo -en "centos\t"; tr -d '\n' < /etc/centos-release
    exit
  fi
elif [ -e "/etc/debian_version" ]; then
  echo "debian"
  if grep Ubuntu /etc/lsb-release >/dev/null; then
    echo -en "ubuntu\t"; sed -n -e '/DISTRIB_DESCRIPTION=/ s/\w*=\"//;s/\"$//p' /etc/lsb-release
  fi
fi
