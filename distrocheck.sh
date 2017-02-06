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
  echo -en "debian:\t"; tr -d '\n' < /etc/debian_version; echo -n ', '; grep '^PRETTY_NAME=' /etc/os-release | sed -n -e '/PRETTY_NAME=/ s/^\w*=\"//;s/\"$//p'
  #tr -d '\n' < /etc/debian_version; sed -n -e '/PRETTY_NAME=/ s/\w*=\"//;s/\"$//p' /etc/os-release
  #if grep -q Ubuntu /etc/os-release; then
  #  echo -en "ubuntu:\t"; sed -n -e '/PRETTY_NAME=/ s/\w*=\"//;s/\"$//p' /etc/os-release
  #fi
else
  echo "unknown distro"
fi
