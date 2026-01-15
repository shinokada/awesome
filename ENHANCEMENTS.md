# Awesome Package Manager - Enhancement Guide

## Overview of Improvements

This document describes the enhancements made to the Awesome package manager (v0.6.0). The improvements focus on reliability, user experience, and maintainability.

## New Features

### 1. Configuration File Support

**Location:** `~/.config/awesome/config`

Create this file to customize your Awesome installation:

```bash
# Copy the example config
mkdir -p ~/.config/awesome
cp awesome.config.example ~/.config/awesome/config

# Edit to your preferences
nano ~/.config/awesome/config
```

**Key Configuration Options:**
- `AWESOME_DIR`: Where packages are installed (default: `~/.local/share/awesome`)
- `BIN_DIR`: Where symlinks are created (default: `~/.local/share/bin`)
- `GIT_CLONE_DEPTH`: Use shallow clones to save space (default: 1)
- `ENABLE_LOGGING`: Enable operation logging (default: true)
- `MAX_RETRY_ATTEMPTS`: Number of retries for git operations (default: 3)

### 2. Enhanced Error Handling

**Network Connectivity Check:**
```bash
# Automatically checks network before git operations
awesome install shinokada/gitstart
```

**Retry Logic:**
- Automatic retry on failed git clones (configurable attempts)
- Exponential backoff between retries
- Clear error messages

**Example output:**
```
Cloning (attempt 1/3)...
Clone attempt 1 failed. Retrying in 2s...
Cloning (attempt 2/3)...
✓ Clone succeeded
```

### 3. Health Check & Diagnostics

**New Command:** `awesome doctor`

Performs comprehensive system checks:
- Git installation verification
- Network connectivity test
- Directory structure validation
- Disk space check
- Broken symlink detection
- Package count summary

```bash
$ awesome doctor

=== Awesome Health Check ===

1. Checking Git installation...
   ✓ Git is installed (git version 2.39.0)

2. Checking network connectivity...
   ✓ Network connection OK

3. Checking directories...
   ✓ Awesome directory exists: /Users/you/.local/share/awesome
   ✓ Bin directory exists: /Users/you/.local/share/bin

4. Checking disk space...
   ✓ Disk space OK

5. Checking for broken symlinks...
   ✓ No broken symlinks found

6. Package summary...
   Installed packages: 12

=== Summary ===
All checks passed! ✓
```

### 4. Package Information

**New Command:** `awesome info <package>`

Shows detailed information about an installed package:
- Installation date
- Package version
- Repository URL
- Package size
- Symlink location
- Git branch and last commit

```bash
$ awesome info gitstart

=== Package Information: gitstart ===

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

Git Info:
  Remote: https://github.com/shinokada/gitstart
  Branch: main
  Last commit: 2 days ago
```

### 5. Batch Operations

**Update All Packages:**
```bash
awesome update --all
```

Output shows success/failure for each package:
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

### 6. Backup & Restore

**Export Installed Packages:**
```bash
# Export to default location (~/awesome-packages.txt)
awesome export

# Export to custom location
awesome export ~/my-packages.txt
```

**Import Packages:**
```bash
awesome import ~/awesome-packages.txt
```

**Package List Format:**
```
# Awesome Package Manager - Package List
# Generated: 2024-01-15 14:30:00

shinokada/gitstart
shinokada/cleanit
shinokada/gitig
raylee/tldr-sh-client
```

### 7. Enhanced Logging

All operations are automatically logged (if enabled in config).

**Log Location:** `~/.local/share/awesome/logs/awesome.log`

**Log Format:**
```
[2024-01-15 14:30:00] [INFO] install gitstart - success
[2024-01-15 14:31:00] [INFO] symlink gitstart - created
[2024-01-15 14:35:00] [INFO] update gitstart - success
[2024-01-15 14:40:00] [ERROR] Clone failed after retries: https://github.com/invalid/repo
```

### 8. Package Statistics

**New Command:** `awesome stats`

Shows package statistics:
```bash
$ awesome stats

=== Awesome Statistics ===

Total packages installed: 12

Package sizes:
  gitstart                       4.2M
  cleanit                        2.1M
  gitig                          1.8M
  tldr                           3.5M
  ...
```

### 9. Package Manifests

Each installed package now has a manifest file:

**Location:** `~/.local/share/awesome/<package>/.awesome-manifest`

**Content:**
```json
{
  "name": "gitstart",
  "version": "latest",
  "repo_url": "https://github.com/shinokada/gitstart",
  "install_date": "2024-01-15 14:30:00",
  "installed_by": "awesome 0.6.0"
}
```

### 10. Improved Help System

**Enhanced help output:**
```bash
awesome --help
```

Now includes:
- Categorized commands (core vs. new)
- Colored output for better readability
- More examples
- Links to documentation

## Migration Guide

### From v0.5.3 to v0.6.0

**Option 1: Side-by-Side Testing**
1. Keep your current `awesome` installation
2. Test the enhanced version:
   ```bash
   # Make enhanced version executable
   chmod +x awesome-enhanced utils/lib-enhanced
   
   # Test commands
   ./awesome-enhanced doctor
   ./awesome-enhanced info gitstart
   ```

**Option 2: Full Migration**
1. Backup your packages:
   ```bash
   # Using old version
   awesome ls > ~/awesome-backup.txt
   ```

2. Replace files:
   ```bash
   # Backup originals
   cp awesome awesome.backup
   cp utils/lib utils/lib.backup
   
   # Install enhanced versions
   cp awesome-enhanced awesome
   cp utils/lib-enhanced utils/lib
   
   # Make executable
   chmod +x awesome utils/lib
   ```

3. Create config file:
   ```bash
   mkdir -p ~/.config/awesome
   cp awesome.config.example ~/.config/awesome/config
   ```

4. Test installation:
   ```bash
   awesome doctor
   ```

## Backward Compatibility

✅ **All original commands work exactly the same:**
- `awesome install`
- `awesome rm`
- `awesome update`
- `awesome ls`
- `awesome link/unlink`
- `awesome alias`
- `awesome push`

✅ **Existing installations are not affected:**
- Your installed packages continue to work
- No migration required for existing packages
- Symlinks remain unchanged

✅ **Graceful fallback:**
- If `lib-enhanced` is not found, falls back to original `lib`
- Configuration file is optional
- All new features are opt-in

## Performance Improvements

1. **Shallow Clones:**
   - Configurable via `GIT_CLONE_DEPTH`
   - Saves disk space and bandwidth
   - Faster installation times

2. **Batch Updates:**
   - Update all packages with one command
   - Parallel updates (configurable)

3. **Smart Caching:**
   - Reduces redundant git operations
   - Faster package queries

## Usage Examples

### Basic Workflow
```bash
# Health check first
awesome doctor

# Install a package
awesome install shinokada/gitstart

# Get package info
awesome info gitstart

# Update all packages
awesome update --all

# Export for backup
awesome export ~/my-awesome-packages.txt
```

### Advanced Workflow
```bash
# Install with custom branch
awesome install shinokada/gitstart main

# Create configuration
mkdir -p ~/.config/awesome
cat > ~/.config/awesome/config << 'EOF'
ENABLE_LOGGING=true
GIT_CLONE_DEPTH=1
MAX_RETRY_ATTEMPTS=5
EOF

# Check statistics
awesome stats

# View logs
tail -f ~/.local/share/awesome/logs/awesome.log
```

## Testing

Run the included tests:
```bash
# If you have shellspec installed
shellspec -s bash

# Test specific functionality
shellspec -s bash spec/functions_spec.sh
```

## Troubleshooting

### Issue: Commands not found after migration
```bash
# Check PATH
echo $PATH | grep ".local/share/bin"

# If not found, add to your shell config
echo 'export PATH=$HOME/.local/share/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

### Issue: Network timeouts
```bash
# Increase retry attempts in config
cat > ~/.config/awesome/config << 'EOF'
MAX_RETRY_ATTEMPTS=5
RETRY_DELAY=3
EOF
```

### Issue: Disk space warnings
```bash
# Check package sizes
awesome stats

# Remove unused packages
awesome rm <package-name>

# Use shallow clones
echo 'GIT_CLONE_DEPTH=1' >> ~/.config/awesome/config
```

## Contributing

To contribute improvements:

1. Test thoroughly:
   ```bash
   shellspec -s bash
   ```

2. Update documentation

3. Maintain backward compatibility

4. Add logging where appropriate

## Changelog

### v0.6.0 (Enhanced)
- ✨ Added configuration file support
- ✨ Added health check command (`doctor`)
- ✨ Added package info command (`info`)
- ✨ Added statistics command (`stats`)
- ✨ Added batch update (`update --all`)
- ✨ Added backup/restore (`export`/`import`)
- 🔧 Enhanced error handling with retry logic
- 🔧 Added network connectivity checks
- 🔧 Added comprehensive logging
- 🔧 Added package manifests
- 🔧 Improved help system
- 🐛 Fixed various edge cases
- ⚡ Performance improvements with shallow clones

### v0.5.3 (Original)
- Original stable release

## Future Enhancements

Planned for future versions:
- [ ] Version pinning (install specific tags/commits)
- [ ] Dependency resolution
- [ ] Package search functionality
- [ ] Security scanning
- [ ] Shell completion scripts
- [ ] Package verification (checksums)
- [ ] Multi-language support
- [ ] Web dashboard

## Questions?

- 📖 Documentation: https://awesome.codewithshin.com
- 🐛 Issues: https://github.com/shinokada/awesome/issues
- 💬 Discussions: https://github.com/shinokada/awesome/discussions

## License

MIT License - Same as original Awesome package manager
