# A Simple Shell Script Manager Awesome

## Overview

Awesome installs a shell script package from a GitHub repo on your macOS/Linux.

Shell script can be bash, lua, node, perl, php, python, python3, ruby, and more.

## Requirement

- curl or wget

## Installation

### curl

Ubuntu/Debian:

```sh
sudo apt install curl
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install
```

CentOs/Fedora/Redhat:

```sh
sudo yum install curl
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install
```

### wget
https://asciinema.org/a/14?t=25&speed=2&theme=solarized-dark

Ubuntu/Debian:

```sh
sudo apt install wget
wget -qO - https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install
```

CentOs/Fedora/Redhat:

```sh
sudo yum install curl
wget -qO - https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install
```

## Uninstallation

```sh
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s uninstall
```

## Usage

Select any script from [Aweseom-shell](https://github.com/alebcay/awesome-shell) and run `awesome intall <URL>`.

```sh
# Install a github repo
awesome install https://github.com/shinokada/cleanit.git
# OR using URL
awesome install https://github.com/shinokada/cleanit

# Remove a symlink and repo
awesome uninstall cleanit

# Remove a symlink but not uninstall
awesome remove cleanit

# Update a repo
awesome update cleanit

# Show installed packages
awesome list

# help
awesome --help
awesome -h

# version
awesome --version
awesome -v
```


## Author

Shinichi Okada

## Licence

Please see license.txt.
