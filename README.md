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
sudo -H git clone https://github.com/securedirective/linux-customizations
/usr/local/etc/linux-customizations/install.sh
```

## Install for root user
```
sudo -H /usr/local/etc/linux-customizations/install.sh
```

The -H is important, as this allows the script to run under the root user's context. Without this, MacOS and some Linux distros simply grant admin-level rights but still run the script under the current user's context.
