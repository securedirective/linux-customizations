# Linux Customizations
Adds various Linux customizations to improve user experience:
* customizes the Linux prompt
* adds aliases and some useful functions to `bash`
* configures `nano` to remember search phrases, always show line position, turn off line wrapping, etc. (if you already have a config, it will be renamed)
* configures `tmux` with some useful keyboard shortcuts (if you already have a config, it will be renamed)

You are highly recommended to look at the contents of `install.sh` prior to running it. Use at your own risk!

Has been tested to work on the following Linux distros:
* CentOS 7
* Ubuntu 14.x LTS
* macOS 10.x (OSX)

## Download
cd /usr/local/etc
git clone https://github.com/securedirective/linux-customizations

## Install for current user
/usr/local/etc/linux-customizations/install.sh

## Install for root user
sudo /usr/local/etc/linux-customizations/install.sh
