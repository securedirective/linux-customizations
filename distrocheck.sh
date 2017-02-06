#!/usr/bin/env bash

# Deterimes Linux distribution

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

if uname -a | grep -q FreeBSD; then
  echo -en "freebsd:\t"; uname -srKm
elif [ -e "/etc/redhat-release" ]; then
  echo "redhat"
  if [ -e "/etc/centos-release" ]; then
    echo -en "centos:\t"; cat /etc/centos-release
    exit
  fi
elif [ -e "/etc/debian_version" ]; then
  echo "debian"
  if grep Ubuntu /etc/lsb-release >/dev/null; then
    echo -en "ubuntu:\t"; sed -n -e '/DISTRIB_DESCRIPTION=/ s/\w*=\"//;s/\"$//p' /etc/lsb-release
  fi
else
  echo "unknown distro"
fi
