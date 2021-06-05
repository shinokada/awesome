# A Simple Shell Script Manager Awesome

## Overview

The `awesome` is a simple script package manager. Awesome installs a shell script package from a GitHub repo on your macOS/Linux.

 It creates the `~/awesome` directory and the `~/bin` directory if they don't exist. When you install a script package in the `~/awesome` directory and, it creates a symlink in the `~/bin` directory.

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
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install > tmp1 && bash tmp1 uninstall && rm tmp1
```

## Limitations

A GitHub repository must have the same script name.

For example, a GitHub repo, https://github.com/shinokada/cleanit has a script name `cleanit`.

The script name can have an extension, `.sh`.

## Usage

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

## Some libraries

- [has](https://github.com/kdabir/has): helps you check presence of various command line tools and their versions on path.
- [ddgr](https://github.com/jarun/ddgr): DuckDuckGo from the terminal.
- [desk](https://github.com/jamesob/desk): Lightweight workspace manager for the shell.
- [gitstart](https://github.com/shinokada/gitstart): GitHub repository automation.
- [gitig](https://github.com/shinokada/gitig): Fix a gitignore problem.
- [backpack_install](https://github.com/shinokada/backpack_install): Backpack for Laravel installer.
- [manop](https://github.com/shinokada/manop): Man page description and option viewer

## Author

Shinichi Okada

## Licence

Please see license.txt.
