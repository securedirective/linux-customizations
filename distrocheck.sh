#!/usr/bin/env sh

# Determines the running Linux distribution. So far, it can detect the following:
# REDHAT
# REDHAT/CENTOS
# DEBIAN
# DEBIAN/UBUNTU
# MACOS

# Eventually, I'd like to support the detection of the following as well
# REDHAT/FEDORA
# REDHAT/RHEL
# SLACKWARE
# SLACKWARE/SUSE
# DEBIAN/MINT
# DEBIAN/KNOPPIX
# DEBIAN/RASPBIAN
# ARCH (base)

if uname -a | grep -q Darwin; then
    echo "\nDISTRO = MACOS"
    uname -a
    echo $(sw_vers -productName) $(sw_vers -productVersion)

elif uname -a | grep -q FreeBSD; then
    echo "\nDISTRO = FREEBSD"
    uname -srKm

elif [ -e "/etc/redhat-release" ]; then
    echo "\nDISTRO = REDHAT"
    cat /etc/redhat-release
    if [ -e "/etc/centos-release" ]; then
        echo "\nDISTRO = REDHAT/CENTOS"
        cat /etc/centos-release
    fi

elif [ -e "/etc/debian_version" ]; then
    echo "\nDISTRO = DEBIAN"
    cat /etc/debian_version
    if grep -q Ubuntu /etc/os-release; then
        echo "\nDISTRO = DEBIAN/UBUNTU"
    fi
    grep '^PRETTY_NAME=' /etc/os-release | sed -n -e 's/^\w*=\"//;s/\"$//p'

else
    echo "\nDISTRO = UNKNOWN"
    uname -a
fi

echo