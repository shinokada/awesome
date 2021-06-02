# Awesome

## Overview

Awesome install a package from a GitHub repo on your macOS/Linux.

## Requirement

- curl or wget

## Installation

### curl

Ubuntu/Debian:

```sh
sudo apt install curl
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash fn_install
```

CentOs/Fedora/Redhat:

```sh
sudo yum install curl
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash install
```

### wget

Ubuntu/Debian:

```sh
sudo apt install wget
wget -qO - http://example.com/script.sh | bash install
```

## Usage

```sh
# Install a github repo
awesome install https://github.com/shinokada/cleanit.git

# Remove a symlink and repo
awesome uninstall cleanit

# Remove a symlink but not uninstall
awesome remove cleanit

# Update a repo
awesome update cleanit

# help
awesome help
awesome h

# version
awesome version
awesome v
```


## Uninstallation


## Author

Shinichi Okada

## Licence

Please see license.txt.
