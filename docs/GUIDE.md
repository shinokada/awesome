# Awesome Package Manager - Complete Guide

## Table of Contents

- [Command Reference](#command-reference)
- [Advanced Usage](#advanced-usage)
- [Configuration](#configuration)
- [Package Manifests](#package-manifests)
- [Logging](#logging)
- [Troubleshooting](#troubleshooting)
- [Development](#development)

---

## Command Reference

### Core Commands

#### `awesome install`

Install packages from GitHub repositories.

**Syntax:**
```bash
awesome install <user/repo> [script-name]
awesome install <github-url> [script-name]
```

**Examples:**
```bash
# Install with default script name (repo name)
awesome install shinokada/gitstart

# Install with custom script name
awesome install raylee/tldr-sh-client tldr

# Install from full GitHub URL
awesome install https://github.com/shinokada/cleanit

# Install with .git extension
awesome install https://github.com/shinokada/gitig.git
```

**What it does:**
1. Validates the repository URL
2. Checks network connectivity
3. Clones the repository (with retry on failure)
4. Creates a symlink in `$BIN_DIR`
5. Creates a package manifest
6. Logs the operation

**Features:**
- Automatic retry on failure (configurable)
- Network connectivity check
- Shallow clones (configurable depth)
- Progress indicators

---

#### `awesome rm`

Remove installed packages.

**Syntax:**
```bash
awesome rm <package-name> [package-name2 ...]
```

**Examples:**
```bash
# Remove single package
awesome rm gitstart

# Remove multiple packages
awesome rm gitstart cleanit gitig
```

**What it does:**
1. Removes the package directory
2. Removes the symlink
3. Removes the manifest
4. Logs the operation

---

#### `awesome update`

Update packages to the latest version.

**Syntax:**
```bash
awesome update <package-name>
awesome update --all
```

**Examples:**
```bash
# Update single package
awesome update gitstart

# Update all packages
awesome update --all
```

**What it does:**
1. Navigates to package directory
2. Runs `git pull`
3. Reports success or failure
4. Updates manifest (if needed)
5. Logs the operation

**Batch Update Output:**
```
Updating 5 package(s)...

Updating: gitstart
✓ gitstart updated

Updating: cleanit
✓ cleanit updated

Updating: gitig
✗ gitig update failed

Update complete: 4 succeeded, 1 failed
```

---

#### `awesome ls`

List all installed packages.

**Syntax:**
```bash
awesome ls
```

**Example output:**
```
cleanit
gitig
gitstart
tldr
```

---

### Diagnostic Commands

#### `awesome doctor`

Comprehensive system health check.

**Syntax:**
```bash
awesome doctor
```

**What it checks:**
1. **Git Installation** - Verifies git is installed and shows version
2. **Network Connectivity** - Tests connection to GitHub
3. **Directory Structure** - Validates awesome directories exist
4. **Disk Space** - Checks available disk space
5. **Broken Symlinks** - Finds and reports broken symlinks
6. **Package Summary** - Shows total installed packages

**Example output:**
```
=== Awesome Health Check ===

1. Checking Git installation...
   ✓ Git is installed (git version 2.39.0)

2. Checking network connectivity...
   ✓ Network connection OK

3. Checking directories...
   ✓ Awesome directory exists: /Users/you/.local/share/awesome
   ✓ Bin directory exists: /Users/you/.local/share/bin
   ✓ Log directory exists: /Users/you/.local/share/awesome/logs

4. Checking disk space...
   ✓ Disk space OK (42GB available)

5. Checking for broken symlinks...
   ✓ No broken symlinks found

6. Package summary...
   Installed packages: 12
   Total size: 45.2M

=== Summary ===
All checks passed! ✓
```

---

#### `awesome info`

Display detailed package information.

**Syntax:**
```bash
awesome info <package-name>
```

**Example:**
```bash
$ awesome info gitstart

=== Package Information: gitstart ===

Manifest:
{
  "name": "gitstart",
  "version": "latest",
  "repo_url": "https://github.com/shinokada/gitstart",
  "install_date": "2024-01-15 14:30:00",
  "installed_by": "awesome 0.6.0"
}

Size:
  4.2M

Location:
  Symlink: /Users/you/.local/share/bin/gitstart
  Target:  /Users/you/.local/share/awesome/gitstart/gitstart

Git Information:
  Remote: https://github.com/shinokada/gitstart
  Branch: main
  Last commit: 2 days ago (abc1234)
  Status: Clean working directory

Script Info:
  Executable: Yes
  Permissions: rwxr-xr-x
  Type: Bash script
```

---

#### `awesome stats`

Show package statistics and disk usage.

**Syntax:**
```bash
awesome stats
```

**Example output:**
```
=== Awesome Statistics ===

Total packages installed: 12

Package sizes:
  gitstart                       4.2M
  cleanit                        2.1M
  gitig                          1.8M
  tldr                           3.5M
  myrepo                         8.1M
  script1                        1.2M
  script2                        956K
  tool1                          2.8M
  tool2                          3.4M
  util1                          1.9M
  util2                          2.2M
  helper                         12.0M

Total disk usage: 45.2M
Average package size: 3.8M
Largest package: helper (12.0M)
```

---

### Backup & Restore Commands

#### `awesome export`

Export list of installed packages.

**Syntax:**
```bash
awesome export [output-file]
```

**Examples:**
```bash
# Export to default location (~/awesome-packages.txt)
awesome export

# Export to custom location
awesome export ~/backup/my-packages.txt

# Export with date
awesome export ~/packages-$(date +%Y%m%d).txt
```

**Output file format:**
```
# Awesome Package Manager - Package List
# Generated: 2024-01-15 14:30:00
# Hostname: my-machine
# Awesome version: 0.6.0

shinokada/gitstart
shinokada/cleanit
shinokada/gitig
raylee/tldr-sh-client tldr
```

---

#### `awesome import`

Install packages from an exported list.

**Syntax:**
```bash
awesome import <package-file>
```

**Example:**
```bash
awesome import ~/awesome-packages.txt
```

**What it does:**
1. Reads the package list
2. Validates each entry
3. Installs packages one by one
4. Reports success/failure for each
5. Shows summary at the end

**Example output:**
```
Importing packages from: /Users/you/awesome-packages.txt

Found 4 package(s) to install

Installing: shinokada/gitstart
✓ gitstart installed

Installing: shinokada/cleanit
✓ cleanit installed

Installing: shinokada/gitig
✓ gitig installed

Installing: raylee/tldr-sh-client (as tldr)
✓ tldr installed

Import complete: 4 succeeded, 0 failed
```

---

### Utility Commands

#### `awesome link`

Create a symlink for a package.

**Syntax:**
```bash
awesome link <package-name>
```

#### `awesome unlink`

Remove a symlink (keeps the package).

**Syntax:**
```bash
awesome unlink <package-name>
```

#### `awesome links`

Show all symlinks.

**Syntax:**
```bash
awesome links
```

#### `awesome alias`

Create an alias for a package.

**Syntax:**
```bash
awesome alias <package-name> <alias-name>
```

**Example:**
```bash
awesome alias tldr-sh-client tldr
```

#### `awesome push`

Push changes in a package repository.

**Syntax:**
```bash
awesome push <package-name> ["commit message"]
```

#### `awesome url`

Open package repository in browser.

**Syntax:**
```bash
awesome url <package-name>
```

---

## Advanced Usage

### Using Configuration File

Create `~/.config/awesome/config`:

```bash
mkdir -p ~/.config/awesome
cp awesome.config.example ~/.config/awesome/config
```

**Available options:**

```bash
# === Directory Configuration ===
AWESOME_DIR="$HOME/.local/share/awesome"
BIN_DIR="$HOME/.local/share/bin"
LOG_DIR="$HOME/.local/share/awesome/logs"
CONFIG_DIR="$HOME/.config/awesome"

# === Git Configuration ===
# Use shallow clones to save disk space and bandwidth
GIT_CLONE_DEPTH=1

# === Network Configuration ===
# Maximum retry attempts for failed operations
MAX_RETRY_ATTEMPTS=3

# Delay between retries (seconds)
RETRY_DELAY=2

# Network timeout (seconds)
NETWORK_TIMEOUT=30

# === Logging Configuration ===
# Enable/disable logging
ENABLE_LOGGING=true

# Log level: DEBUG, INFO, WARN, ERROR
LOG_LEVEL=INFO

# Rotate logs when they exceed this size (in MB)
LOG_MAX_SIZE=10

# === Performance Configuration ===
# Enable parallel operations (experimental)
ENABLE_PARALLEL=false

# Maximum parallel jobs
MAX_PARALLEL_JOBS=4

# === Display Configuration ===
# Colored output
ENABLE_COLOR=true

# Show progress indicators
SHOW_PROGRESS=true
```

---

### Working with Package Manifests

Each installed package has a manifest file: `~/.local/share/awesome/<package>/.awesome-manifest`

**Manifest format (JSON):**
```json
{
  "name": "gitstart",
  "version": "latest",
  "repo_url": "https://github.com/shinokada/gitstart",
  "install_date": "2024-01-15 14:30:00",
  "installed_by": "awesome 0.6.0",
  "script_name": "gitstart",
  "custom_name": false
}
```

**Reading manifests programmatically:**
```bash
# Read manifest
cat ~/.local/share/awesome/gitstart/.awesome-manifest

# Parse with jq
jq .install_date ~/.local/share/awesome/gitstart/.awesome-manifest
```

---

### Logging

Logs are stored in `~/.local/share/awesome/logs/awesome.log` (if enabled).

**Log format:**
```
[2024-01-15 14:30:00] [INFO] install gitstart - started
[2024-01-15 14:30:05] [INFO] install gitstart - clone succeeded
[2024-01-15 14:30:06] [INFO] install gitstart - symlink created
[2024-01-15 14:30:06] [INFO] install gitstart - success
```

**Viewing logs:**
```bash
# View recent logs
tail -20 ~/.local/share/awesome/logs/awesome.log

# Watch logs in real-time
tail -f ~/.local/share/awesome/logs/awesome.log

# Search logs
grep "ERROR" ~/.local/share/awesome/logs/awesome.log

# View logs for specific package
grep "gitstart" ~/.local/share/awesome/logs/awesome.log
```

---

### Batch Operations

**Install multiple packages:**
```bash
# Using a for loop
for pkg in shinokada/gitstart shinokada/cleanit shinokada/gitig; do
  awesome install "$pkg"
done

# Or create a script
cat > install-my-tools.sh << 'EOF'
#!/bin/bash
awesome install shinokada/gitstart
awesome install shinokada/cleanit
awesome install raylee/tldr-sh-client tldr
EOF
chmod +x install-my-tools.sh
./install-my-tools.sh
```

**Update all packages (built-in):**
```bash
awesome update --all
```

---

### Migration Between Machines

**On old machine:**
```bash
# Export packages
awesome export ~/awesome-packages.txt

# Transfer file to new machine
scp ~/awesome-packages.txt newmachine:~
```

**On new machine:**
```bash
# Install awesome
curl -s https://raw.githubusercontent.com/shinokada/awesome/main/install | bash -s install

# Add to PATH
export PATH=$HOME/.local/share/bin:$PATH

# Import packages
awesome import ~/awesome-packages.txt
```

---

### Custom Installations

**Install from a fork:**
```bash
awesome install yourusername/forked-repo
```

**Install from a branch:**
```bash
# Clone the repo
cd ~/.local/share/awesome
git clone -b feature-branch https://github.com/user/repo

# Create symlink manually
ln -s ~/.local/share/awesome/repo/repo ~/.local/share/bin/repo
```

**Install with custom location:**
```bash
# Use config file to change directories
echo 'AWESOME_DIR="$HOME/my-scripts"' >> ~/.config/awesome/config
echo 'BIN_DIR="$HOME/bin"' >> ~/.config/awesome/config
```

---

## Configuration

### Environment Variables

Awesome respects these environment variables:

```bash
# Override directories
export AWESOME_DIR="$HOME/my-scripts"
export BIN_DIR="$HOME/bin"

# Override settings
export MAX_RETRY_ATTEMPTS=5
export ENABLE_LOGGING=true
```

Priority order: Environment variables > Config file > Defaults

---

## Troubleshooting

### Common Issues

**Problem: Commands not found after installation**

```bash
# Check if awesome is in PATH
which awesome

# If not found, check PATH
echo $PATH | grep ".local/share/bin"

# Add to PATH
export PATH=$HOME/.local/share/bin:$PATH

# Make permanent
echo 'export PATH=$HOME/.local/share/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

---

**Problem: Network timeout errors**

```bash
# Increase timeout and retries
cat >> ~/.config/awesome/config << 'EOF'
MAX_RETRY_ATTEMPTS=5
RETRY_DELAY=3
NETWORK_TIMEOUT=60
EOF
```

---

**Problem: Disk space issues**

```bash
# Check package sizes
awesome stats

# Use shallow clones
echo 'GIT_CLONE_DEPTH=1' >> ~/.config/awesome/config

# Remove unused packages
awesome rm <package-name>
```

---

**Problem: Broken symlinks**

```bash
# Find broken symlinks
awesome doctor

# Fix manually
awesome unlink <package-name>
awesome link <package-name>
```

---

**Problem: Git clone failures**

```bash
# Check network
ping github.com

# Try manual clone
cd ~/.local/share/awesome
git clone https://github.com/user/repo

# Check logs
tail ~/.local/share/awesome/logs/awesome.log
```

---

### Debug Mode

Enable verbose logging:

```bash
# In config file
echo 'LOG_LEVEL=DEBUG' >> ~/.config/awesome/config

# Or temporarily
LOG_LEVEL=DEBUG awesome install shinokada/gitstart
```

---

## Development

### Testing

Run the test suite:

```bash
# Install shellspec
brew install shellspec  # macOS
# or
git clone https://github.com/shellspec/shellspec.git
export PATH="$PWD/shellspec/bin:$PATH"

# Run all tests
shellspec -s bash

# Run specific test file
shellspec -s bash spec/enhanced_spec.sh

# Run with coverage
shellspec -s bash --kcov
```

---

### Creating Custom Commands

Add custom commands by creating a plugin file:

```bash
# Create plugin directory
mkdir -p ~/.config/awesome/plugins

# Create a plugin
cat > ~/.config/awesome/plugins/my-commands.sh << 'EOF'
#!/bin/bash

awesome_custom_command() {
  echo "Running custom command"
  # Your logic here
}
EOF

# Source in your shell config
echo 'source ~/.config/awesome/plugins/my-commands.sh' >> ~/.zshrc
```

---

### Contributing

1. **Fork the repository**
2. **Create a feature branch**
3. **Make your changes**
4. **Add tests**
5. **Update documentation**
6. **Submit a pull request**

**Guidelines:**
- Maintain backward compatibility
- Follow existing code style
- Add tests for new features
- Update relevant documentation
- Keep commits atomic and well-described

---

## Appendix

### File Locations

| File/Directory | Purpose |
|---------------|---------|
| `~/.local/share/awesome` | Package installations |
| `~/.local/share/bin` | Symlinks to executables |
| `~/.local/share/awesome/logs` | Operation logs |
| `~/.config/awesome` | Configuration files |
| `~/.config/awesome/config` | Main configuration |
| `<package>/.awesome-manifest` | Package metadata |

### Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 2 | Invalid arguments |
| 3 | Network error |
| 4 | Git error |
| 5 | Package not found |

---

For more information, visit [awesome.codewithshin.com](https://awesome.codewithshin.com)
