<p align="center">
<a href='https://ko-fi.com/Z8Z2CHALG' target='_blank'><img height='42' style='border:0px;height:42px;' src='https://storage.ko-fi.com/cdn/kofi3.png?v=3' alt='Buy Me a Coffee at ko-fi.com' /></a>
</p>

<p align="center">
<img width="400" src="https://raw.githubusercontent.com/shinokada/awesome/main/images/mkdirawesome.png" />
</p>

<p align="center">
<a href="https://awesome.codewithshin.com/">https://awesome.codewithshin.com/</a>
</p>

<p align="center">
<a href="https://github.com/sponsors/shinokada" target="_blank"><img src="https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86" height="25"></a>
<a href="https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps" target="_blank"><img src="https://img.shields.io/badge/PWA-enabled-brightgreen" alt="PWA Shield" height="25"></a>
<a href="https://twitter.com/shinokada" rel="nofollow" target="_blank"><img src="https://img.shields.io/badge/created%20by-@shinokada-4BBAAB.svg" alt="Created by Shin Okada" height="25"></a>
<a href="https://opensource.org/licenses/MIT" rel="nofollow" target="_blank"><img src="https://img.shields.io/github/license/shinokada/awesome" alt="License" height="25"></a>
</p>

<h1  align="center">A Simple Shell Script Package Manager - Awesome</h1>
<p align="center">
<img width="400" src="https://raw.githubusercontent.com/shinokada/awesome/main/images/awesomesky-o.gif" />
</p>

[Read more about Awesome Package Manager](https://medium.com/mkdir-awesome/a-new-simple-package-manager-for-script-languages-a1228fd0972a)

## Overview

Awesome is a lightweight shell script package manager that installs packages from GitHub repositories on macOS and Linux. It manages installations in `~/.local/share/awesome` and creates convenient symlinks in `~/.local/share/bin`.

## Why Awesome?

- Install scripts not available in package managers like Homebrew
- Simple, fast installation and updates
- Easy package management with health checks and diagnostics
- Git workflow integration for script development

## Requirements

- UNIX-like system (macOS, Linux, BSD)
- Git
- Bash 3.2 or higher

## Installation

```sh
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install
```

Or using wget:

```sh
wget -qO - https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install
```

Add to your shell config (`.zshrc`, `.bashrc`, etc.):

```sh
export PATH=$HOME/.local/share/bin:$PATH
```

Then reload your shell:

```sh
source ~/.zshrc  # or source ~/.bashrc
```

The installer will:
- Verify prerequisites (Git, network)
- Create necessary directories
- Clone the awesome repository
- Set up symlinks
- Run diagnostics (optional)

## Uninstallation

```sh
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s uninstall
```

This removes all packages, symlinks, configuration, and logs.

## Features

### Package Management

```sh
# Install packages
awesome install shinokada/gitstart
awesome install raylee/tldr-sh-client tldr
awesome install https://github.com/shinokada/cleanit

# Update packages
awesome update cleanit
awesome update --all  # Update all packages

# Remove packages
awesome rm cleanit

# List installed packages
awesome ls
```

### Health & Diagnostics

```sh
# System health check
awesome doctor

# Package information
awesome info gitstart

# Show statistics
awesome stats
```

### Backup & Restore

```sh
# Export installed packages
awesome export ~/my-packages.txt

# Import and install from list
awesome import ~/my-packages.txt
```

### Symlink Management

```sh
# Create symlink to installed package
awesome link tldr-sh-client tldr

# Remove symlink only
awesome unlink tldr

# Show all symlinks
awesome links
```

### Aliases

Create command aliases for scripts within a package:

```sh
# Install package with one script as main
awesome install shinokada/script-examples php-example.php

# Create alias to another script in same package
awesome alias ne script-examples node-example.js

# Now use the alias
ne  # Runs node-example.js
```

### Development Workflow

When developing a script managed by awesome:

```sh
# Git add, commit, push, and update local package
awesome push "your commit message"
```

This combines Git workflow with automatic package updates.

### Additional Commands

```sh
# Open Awesome GitHub repository
awesome url

# Show version
awesome -v

# Show help
awesome -h
```

## Multi-Script Repositories

Install from repositories with multiple scripts using the Bash Snippets collection:

```sh
awesome install alexanderepstein/Bash-Snippets cheat/cheat
awesome install alexanderepstein/Bash-Snippets movies/movies
```

## Recommended Packages

| Package | Installation | Description |
| --- | --- | --- |
| [tldr](https://github.com/raylee/tldr-sh-client) | `awesome install raylee/tldr-sh-client tldr` | Community-maintained help pages |
| [has](https://github.com/kdabir/has) | `awesome install kdabir/has` | Check command-line tool versions |
| [ddgr](https://github.com/jarun/ddgr) | `awesome install jarun/ddgr` | DuckDuckGo from terminal |
| [googler](https://github.com/jarun/googler) | `awesome install jarun/googler` | Google Search from terminal |
| [gitstart](https://github.com/shinokada/gitstart) | `awesome install shinokada/gitstart` | GitHub repository automation |
| [gitig](https://github.com/shinokada/gitig) | `awesome install shinokada/gitig` | Fix gitignore problems |
| [manop](https://github.com/shinokada/manop) | `awesome install shinokada/manop` | Man page viewer |
| [spark](https://github.com/holman/spark) | `awesome install holman/spark` | Sparklines in shell |
| [ansiweather](https://github.com/fcambus/ansiweather) | `awesome install fcambus/ansiweather` | Weather conditions display |

Discover 20+ more scripts from [Bash Snippets](https://github.com/alexanderepstein/Bash-Snippets).

## Creating Awesome-Compatible Scripts

Best practices for script compatibility:

1. Add shebang: `#!/usr/bin/env bash`
2. Use executable name without `.sh` extension
3. Match repository and main script names (e.g., `gitstart` repo → `gitstart` script)
4. Include `-h` and `--help` options
5. Make script executable: `chmod +x script-name`

## Testing

Run the test suite:

```sh
shellspec -s bash
```

## PWA: Offline Access

This documentation is available as a Progressive Web App. Install it on your device for offline access using the "Add to Home Screen" option in your browser.

## Author

Created by [@shinokada](https://twitter.com/shinokada)

## License

MIT License - Copyright (c) 2021 Shinichi Okada

See the [LICENSE](../LICENSE) file for details.
