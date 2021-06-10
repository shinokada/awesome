# A Simple Shell Script Package Manager - Awesome

## Overview

The `awesome` is a simple shell script package manager. Awesome installs a shell script package from a GitHub repo on your macOS/Linux.

 It creates the `~/awesome` directory and the `~/bin` directory if they don't exist. When you install a package, it will clone it in the `~/awesome` directory. It creates a symlink in the `~/bin` directory.

## Why?

- Some scripts don't have Homebrew installation. (macOS/Linux)
- Make an easy installation.

## Installation

Installing awesome:

```sh
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install
```

or

```sh
wget -qO - https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install
```

Add the following to your terminal config file, such as .zshrc or .bashrc.

```sh
export PATH=$HOME/bin:$PATH
```

## Uninstallation

Uninstalling awesome:

```sh
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install > tmp1 && bash tmp1 uninstall && rm tmp1
```

or

```sh
wget -qO - https://raw.githubusercontent.com/shinokada/awesome/main/install > tmp1 && bash tmp1 uninstall && rm tmp1
```

## Update

Update awesome:

```sh
awesome update awesome
```

## Usage

```sh
-i | install   installs a package from a GitHub repo and create a symlink in ~/bin
rm             uninstalls a package and remove a symlink
ls | list      lists awesome packages
link           adds a symlink
unlink         remove a package symlink
-u | update    checks an update and install a new package
-a | alias     creates an alias
-v | --version shows version
-h, --help     shows this help message and exit"
```

```sh

# Installing a repo using user/repo
awesome -i shinokada/gitstart
# Installing a repo using user/repo.git
awesome -i shinokada/gitstart.git
# Installing a repo whose main script is different from the repo name
awesome -i raylee/tldr-sh-client tldr
# Same as above but using https
awesome -i https://github.com/shinokada/cleanit
awesome -i https://github.com/raylee/tldr-sh-client tldr
# Installing a repo using install option instead of -i
awesome install https://github.com/shinokada/gitstart.git

# Remove a symlink and repo
awesome rm cleanit

# Show installed packages
awesome ls
awesome list

# Remove a symlink but not uninstall
awesome unlink cleanit

# Add a symlink
awesome link cleanit

# Update a repo
awesome update cleanit
awesome -u cleanit

# help
awesome --help
awesome -h

# version
awesome --version
awesome -v
```

## Alias

Alias is useful when a repo has multiple scripts.

Let's add aliases using [script-examples](https://github.com/shinokada/script-examples)

Install it using php-example.php as the main script.

```sh
awesome -i shinokada/script-examples php-example.php
```

Run it:

```sh
php-example.php
Hello world from PHP!%
```

```sh
# Create an alias to a different script
awesome -a ne script-examples node-example.js
```

Run it:

```sh
ne
Hello World! from Node.
```

You can try it for `perl-example.pl`, `python-example.py`, `ruby-example.rb`.

## Some libraries you can install

- [has](https://github.com/kdabir/has): helps you check presence of various command line tools and their versions on path.
- [ddgr](https://github.com/jarun/ddgr): DuckDuckGo from the terminal.
- [desk](https://github.com/jamesob/desk): Lightweight workspace manager for the shell.
- [gitstart](https://github.com/shinokada/gitstart): GitHub repository automation.
- [gitig](https://github.com/shinokada/gitig): Fix a gitignore problem.
- [googler](https://github.com/jarun/googler): Google Search, Google Site Search, Google News from the terminal
- [hhighlighter](https://github.com/paoloantinori/hhighlighter): Colorize words in a command output
- [backpack_install](https://github.com/shinokada/backpack_install): Backpack for Laravel installer.
- [hr](https://github.com/paoloantinori/hhighlighter): <hr /> for your terminal
- [manop](https://github.com/shinokada/manop): Man page description and option viewer.
- [shml](https://github.com/odb/shml): A shell framework for faster and easier script development.
- [slugify](https://github.com/benlinton/slugify): A bash command that converts filenames and directories to a web friendly format.
- [spark](https://github.com/holman/spark): 
▁▂▃▅▂▇ in your shell
- [spot](https://github.com/rauchg/spot): Tiny file search utility
- [v](https://github.com/rupa/v): z for vim.
- [ansiweather](https://github.com/fcambus/ansiweather): Displaying the current weather conditions.
- 

## How to create a script for Awesome

- Use `#!/usr/bin/env script-name` at the beginning.
- No `.sh` file extension for the main script
- Recommend to have the same repo and main script name. e.g. `shinokada/gitstart` has `gitstart`.
- Add `-h| --help` option.
- Your command start with your main script name.

## Test

Run:

```sh
shellspec -s bash
```

## Todos

- tldr-sh-client has tldr as the main script
- add `awesome -u tldr` to uninstall symlink and symlink destination. Use `realpath tldr` to find the source and remove the dir.

## Author

Shinichi Okada

## Licence

Please see license.txt.
