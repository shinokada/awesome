# Quick Start Guide - Awesome Enhanced v0.6.0

## New Commands at a Glance

### Health Check
```bash
awesome doctor
```
**What it does:** Checks your Awesome installation health
- Verifies Git is installed
- Tests network connectivity
- Validates directories
- Checks disk space
- Finds broken symlinks
- Shows package count

### Package Info
```bash
awesome info <package-name>
```
**What it does:** Shows detailed package information
- Installation date
- Package size
- Repository URL
- Git branch and last commit
- Symlink locations

**Example:**
```bash
awesome info gitstart
```

### Update All Packages
```bash
awesome update --all
```
**What it does:** Updates all installed packages at once
- Shows progress for each package
- Reports success/failure count
- Continues even if some fail

### Package Statistics
```bash
awesome stats
```
**What it does:** Shows statistics about installed packages
- Total package count
- Individual package sizes
- Total disk usage

### Backup & Restore
```bash
# Backup
awesome export ~/my-packages.txt

# Restore on another machine
awesome import ~/my-packages.txt
```
**What it does:** Save and restore your package list
- Easy migration to new machine
- Simple backup of installed packages
- Share package lists with team

## Quick Examples

### Example 1: New Installation
```bash
# Check system health
awesome doctor

# Install a package
awesome install shinokada/gitstart

# Check what was installed
awesome info gitstart
```

### Example 2: Maintenance
```bash
# Check all packages
awesome stats

# Update everything
awesome update --all

# Run health check
awesome doctor
```

### Example 3: Migration to New Machine
```bash
# On old machine
awesome export ~/awesome-packages.txt

# Transfer file to new machine
# scp ~/awesome-packages.txt newmachine:~

# On new machine (after installing awesome)
awesome import ~/awesome-packages.txt
```

### Example 4: Troubleshooting
```bash
# Something not working?
awesome doctor

# Check specific package
awesome info problematic-package

# View recent logs (if logging enabled)
tail -20 ~/.local/share/awesome/logs/awesome.log
```

## Configuration Quick Reference

Edit `~/.config/awesome/config`:

```bash
# Essential settings
AWESOME_DIR="$HOME/.local/share/awesome"  # Where packages are stored
BIN_DIR="$HOME/.local/share/bin"          # Where symlinks go
ENABLE_LOGGING=true                        # Keep logs

# Performance
GIT_CLONE_DEPTH=1                          # Shallow clone (faster, less space)
MAX_RETRY_ATTEMPTS=3                       # Retry failed operations

# Network
NETWORK_TIMEOUT=30                         # Seconds before timeout
RETRY_DELAY=2                              # Seconds between retries
```

## Common Tasks

### Install a Package
```bash
# Same as before
awesome install shinokada/gitstart
awesome install raylee/tldr-sh-client tldr
```

### Keep Packages Updated
```bash
# Update single package
awesome update gitstart

# NEW: Update everything
awesome update --all
```

### Check What's Installed
```bash
# List packages (same as before)
awesome ls

# NEW: Get details
awesome info gitstart

# NEW: See sizes
awesome stats
```

### Remove a Package
```bash
# Same as before
awesome rm gitstart
```

### Troubleshoot Issues
```bash
# NEW: Health check
awesome doctor

# Check logs
tail ~/.local/share/awesome/logs/awesome.log
```

## Tips

1. **Run `awesome doctor` regularly** to catch issues early

2. **Use shallow clones** to save space:
   ```bash
   echo 'GIT_CLONE_DEPTH=1' >> ~/.config/awesome/config
   ```

3. **Enable logging** for troubleshooting:
   ```bash
   echo 'ENABLE_LOGGING=true' >> ~/.config/awesome/config
   ```

4. **Backup before major changes**:
   ```bash
   awesome export ~/awesome-backup-$(date +%Y%m%d).txt
   ```

5. **Use `awesome info`** to check package details before updating

## Getting Help

### Built-in Help
```bash
awesome --help          # Full help
awesome doctor          # System check
awesome info <package>  # Package details
```

### Documentation
- Enhanced features: See `ENHANCEMENTS.md`
- Docs: https://awesome.codewithshin.com
- GitHub: https://github.com/shinokada/awesome

### Logs
```bash
# View recent activity
tail -50 ~/.local/share/awesome/logs/awesome.log

# Watch in real-time
tail -f ~/.local/share/awesome/logs/awesome.log
```

## Rollback

If you need to revert to the original version:

```bash
# Restore backups
mv awesome.v0.5.3.backup awesome
mv utils/lib.v0.5.3.backup utils/lib

# Your packages are unchanged and will continue to work
```

## Next Steps

1. ✅ Test the new `doctor` command
2. ✅ Try `awesome info` on an installed package
3. ✅ Run `awesome update --all` to update everything
4. ✅ Create a backup with `awesome export`
5. ✅ Explore the new help system

Happy scripting! 🚀
