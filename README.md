# Linux Customizations
Adds various Linux customizations to improve user experience:
* customizes the Linux prompt
* adds aliases and some useful functions to `bash`
* configures `nano` to remember search phrases, always show line position, turn off line wrapping, etc. (if you already have a config, the installer will rename it)
* configures `tmux` with some useful keyboard shortcuts (if you already have a config, the installer will rename it)

You are highly recommended to look at the contents of `install.sh` prior to running it. Use at your own risk!

Before anything is commited to the `master` branch, it must be tested to work on the following Linux distros:
* CentOS 7
* Ubuntu 14.x LTS
* macOS 10.x (OSX)

## Download and install
```
cd /usr/local/etc
git clone https://github.com/securedirective/linux-customizations
/usr/local/etc/linux-customizations/install.sh
```

## Install for root user
Do not simply run this with `sudo` to install it as the root user. MacOS (and maybe some other distros) does not update the `~` alias to point to root's home directory, even though the script runs as the root user. So what actually happens is the install script will create files in *your* home directory, but with `root` as the owner... definitely not what you want!

To avoid this, don't use shortcuts like `sudo`. Login the old-fashioned way and install like this:
```
sudo su
/usr/local/etc/linux-customizations/install.sh
exit
```
