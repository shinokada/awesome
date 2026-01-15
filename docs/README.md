# 🚀 Awesome Package Manager

<p align="center">
<img width="400" src="https://raw.githubusercontent.com/shinokada/awesome/main/images/mkdirawesome.png" />
</p>

<p align="center">
<a href="https://awesome.codewithshin.com/">https://awesome.codewithshin.com/</a>
</p>

<p align="center">
<a href="https://github.com/sponsors/shinokada" target="_blank"><img src="https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86" height="25"></a>
<a href="https://opensource.org/licenses/MIT" rel="nofollow" target="_blank"><img src="https://img.shields.io/github/license/shinokada/awesome" alt="License" height="25"></a>
<a href="https://twitter.com/shinokada" rel="nofollow" target="_blank"><img src="https://img.shields.io/badge/created%20by-@shinokada-4BBAAB.svg" alt="Created by Shin Okada" height="25"></a>
</p>

## What is Awesome?

Awesome is a lightweight shell script package manager that installs packages from GitHub repositories. It's designed for scripts and tools that aren't available in traditional package managers like Homebrew or apt.

**Quick facts:**
- ⚡ Fast and simple - just shell scripts
- 🔧 Manages packages from any GitHub repository
- 💾 Installs to `~/.local/share/awesome`
- 🔗 Creates convenient symlinks in `~/.local/share/bin`
- 🏥 Built-in health checks and diagnostics
- 🔄 Supports batch operations

## Quick Start

### Installation

```bash
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install
```

You can update your current `awesome` package:

```bash
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/update | bash -s update
```

Add to your shell config:

```bash
export PATH=$HOME/.local/share/bin:$PATH
```

Reload your shell:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

### Basic Usage

```bash
# Health check
awesome doctor

# Install a package
awesome install shinokada/gitstart

# Get package info
awesome info gitstart

# List installed packages
awesome ls

# Update all packages
awesome update --all

# Remove a package
awesome rm gitstart
```

## Key Features

| Feature             | Command                    | Description                              |
| ------------------- | -------------------------- | ---------------------------------------- |
| 🏥 **Health Check**  | `awesome doctor`           | Verify installation and check for issues |
| 📦 **Package Info**  | `awesome info <pkg>`       | See package details, size, and git info  |
| 📊 **Statistics**    | `awesome stats`            | View disk usage and package counts       |
| 🔄 **Batch Update**  | `awesome update --all`     | Update all packages at once              |
| 💾 **Backup**        | `awesome export`           | Save package list for migration          |
| 📥 **Restore**       | `awesome import`           | Install packages from backup file        |
| ⚙️ **Configuration** | `~/.config/awesome/config` | Customize behavior and settings          |
| 📝 **Logging**       | Auto-enabled               | Track operations for debugging           |

## Common Tasks

### Installing Packages

```bash
# From user/repo format
awesome install shinokada/gitstart

# With custom script name
awesome install raylee/tldr-sh-client tldr

# From full URL
awesome install https://github.com/shinokada/cleanit
```

### Managing Packages

```bash
# List installed packages
awesome ls

# Get detailed info
awesome info gitstart

# Update single package
awesome update gitstart

# Update all packages
awesome update --all

# Remove package
awesome rm gitstart
```

### System Maintenance

```bash
# Health check
awesome doctor

# View statistics
awesome stats

# Backup packages
awesome export ~/my-packages.txt

# View logs (if enabled)
tail -20 ~/.local/share/awesome/logs/awesome.log
```

### TAB completion

```bash
# If installed from source or cloned repo:
 source completions/awesome-completion.bash

# Or download directly:
# curl -o ~/.local/share/awesome/awesome-completion.bash \
#   https://raw.githubusercontent.com/shinokada/awesome/main/completions/awesome-completion.bash
# source ~/.local/share/awesome/awesome-completion.bash
awesome update <TAB>  # Should show --all
```

## Configuration

Create `~/.config/awesome/config` to customize:

```bash
# Directories
AWESOME_DIR="$HOME/.local/share/awesome"
BIN_DIR="$HOME/.local/share/bin"

# Performance
GIT_CLONE_DEPTH=1  # Shallow clones save space

# Reliability
MAX_RETRY_ATTEMPTS=3
RETRY_DELAY=2

# Logging
ENABLE_LOGGING=true
LOG_DIR="$HOME/.local/share/awesome/logs"
```

See `awesome.config.example` for all options.

## Documentation

- **[GUIDE.md](./GUIDE.md)** - Complete command reference and advanced usage

## What's New in v0.6.0

✨ **New Commands:**
- `awesome doctor` - System health checks
- `awesome info <package>` - Detailed package information
- `awesome stats` - Package statistics
- `awesome update --all` - Batch updates
- `awesome export/import` - Backup and restore

🔧 **Improvements:**
- Configuration file support
- Automatic retry on failures
- Network connectivity checks
- Comprehensive logging
- Package manifests
- Enhanced error messages


## Troubleshooting

**Commands not found?**
```bash
# Check PATH
echo $PATH | grep ".local/share/bin"

# Add if missing
echo 'export PATH=$HOME/.local/share/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

**Network issues?**
```bash
# Increase retries in config
echo 'MAX_RETRY_ATTEMPTS=5' >> ~/.config/awesome/config
```

**Package issues?**
```bash
# Run health check
awesome doctor

# Check specific package
awesome info <package-name>

# View logs
tail ~/.local/share/awesome/logs/awesome.log
```

## Requirements

- UNIX-like system (macOS, Linux, BSD)
- Bash 3.2 or higher
- Git

## Uninstallation

```bash
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s uninstall
```

This removes all packages, symlinks, configuration, and logs.

## Contributing

Contributions welcome! When contributing:

1. Maintain backward compatibility
2. Add tests for new features
3. Update documentation
4. Run test suite: `shellspec -s bash`

## Support

- 📖 **Documentation:** [awesome.codewithshin.com](https://awesome.codewithshin.com)
- 🐛 **Issues:** [GitHub Issues](https://github.com/shinokada/awesome/issues)
- 💬 **Discussions:** [GitHub Discussions](https://github.com/shinokada/awesome/discussions)
- ☕ **Sponsor:** [Ko-fi](https://ko-fi.com/Z8Z2CHALG)

## License

MIT License - See [LICENSE](LICENSE) for details

## Credits

Created by [Shinichi Okada](https://twitter.com/shinokada)

**Read more:** [A New Simple Package Manager for Script Languages](https://medium.com/mkdir-awesome/a-new-simple-package-manager-for-script-languages-a1228fd0972a)

---

**Ready to get started?** Run `awesome doctor` to verify your installation! 🚀
