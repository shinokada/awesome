# 🚀 Awesome Package Manager - Enhanced Edition

## Quick Links

- 📖 [Quick Start Guide](QUICKSTART.md) - Get started in 5 minutes
- 📚 [Full Documentation](ENHANCEMENTS.md) - Comprehensive feature guide
- 🔄 [Implementation Summary](IMPLEMENTATION_SUMMARY.md) - What was added
- 🎯 [Original README](docs/README.md) - Original awesome documentation

## What's New in v0.6.0

### 🆕 New Commands

```bash
awesome doctor          # Health check - verify your installation
awesome info <package>  # Detailed package information
awesome stats           # Package statistics and disk usage
awesome update --all    # Update all packages at once
awesome export          # Backup your packages
awesome import          # Restore from backup
```

### ✨ Key Features

- **Configuration System** - Customize behavior via `~/.config/awesome/config`
- **Retry Logic** - Automatic retry on network failures
- **Health Checks** - Built-in diagnostics with `doctor` command
- **Logging** - Track all operations for debugging
- **Batch Updates** - Update all packages with one command
- **Backup/Restore** - Easy migration between machines
- **Better Errors** - Clear, actionable error messages

### 🎯 100% Backward Compatible

All your existing commands work exactly the same. Nothing breaks.

## Quick Start

### Try It Now (No Installation Required)

```bash
# Make enhanced version executable
chmod +x awesome-enhanced utils/lib-enhanced

# Run health check
./awesome-enhanced doctor

# See new help system
./awesome-enhanced --help

# Try the demo
chmod +x demo.sh
./demo.sh
```

### Migrate When Ready

```bash
# Automated migration
chmod +x migrate.sh
./migrate.sh
```

## Examples

### Health Check
```bash
$ awesome doctor

=== Awesome Health Check ===

1. Checking Git installation...
   ✓ Git is installed (git version 2.39.0)

2. Checking network connectivity...
   ✓ Network connection OK

3. Checking directories...
   ✓ Awesome directory exists
   ✓ Bin directory exists

4. Checking disk space...
   ✓ Disk space OK

5. Checking for broken symlinks...
   ✓ No broken symlinks found

=== Summary ===
All checks passed! ✓
```

### Package Info
```bash
$ awesome info gitstart

=== Package Information: gitstart ===

{
  "name": "gitstart",
  "version": "latest",
  "repo_url": "https://github.com/shinokada/gitstart",
  "install_date": "2024-01-15 14:30:00"
}

Size: 4.2M
Location: ~/.local/share/awesome/gitstart
```

### Batch Update
```bash
$ awesome update --all

Updating 5 package(s)...

Updating: gitstart
✓ gitstart updated

Updating: cleanit
✓ cleanit updated

Update complete: 5 succeeded, 0 failed
```

### Backup & Restore
```bash
# Backup on old machine
$ awesome export ~/my-packages.txt
Exported 12 package(s) to: /Users/you/my-packages.txt

# Restore on new machine
$ awesome import ~/my-packages.txt
Importing packages...
```

## What Makes This Better?

### Before (v0.5.3)
```bash
# Install - no retry on failure
awesome install user/repo

# Update - one at a time
awesome update package1
awesome update package2
awesome update package3

# No way to check system health
# No package information
# No backup functionality
```

### After (v0.6.0)
```bash
# Install - automatic retry on failure
awesome install user/repo
# Cloning (attempt 1/3)...
# ✓ Clone succeeded

# Update - all at once
awesome update --all
# Updates all packages

# Health check
awesome doctor
# Comprehensive diagnostics

# Package info
awesome info package1
# Shows size, location, git info, etc.

# Backup
awesome export ~/backup.txt
# Easy migration
```

## Files Created

| File | Description |
|------|-------------|
| `awesome-enhanced` | Enhanced main script |
| `utils/lib-enhanced` | Enhanced library |
| `awesome.config.example` | Configuration template |
| `QUICKSTART.md` | Quick start guide |
| `ENHANCEMENTS.md` | Full documentation |
| `IMPLEMENTATION_SUMMARY.md` | Summary of changes |
| `migrate.sh` | Automated migration |
| `demo.sh` | Interactive demo |
| `spec/enhanced_spec.sh` | Test suite |
| `completions/awesome-completion.bash` | Bash completion |

## Configuration

Create `~/.config/awesome/config`:

```bash
# Where packages are stored
AWESOME_DIR="$HOME/.local/share/awesome"
BIN_DIR="$HOME/.local/share/bin"

# Performance
GIT_CLONE_DEPTH=1  # Shallow clone (faster)

# Reliability
MAX_RETRY_ATTEMPTS=3
RETRY_DELAY=2

# Logging
ENABLE_LOGGING=true
LOG_DIR="$HOME/.local/share/awesome/logs"
```

## Testing

```bash
# Run enhanced tests
shellspec -s bash spec/enhanced_spec.sh

# Run all tests
shellspec -s bash
```

## Migration Options

### Option 1: Test First (Recommended)
```bash
chmod +x awesome-enhanced
./awesome-enhanced doctor
./awesome-enhanced --help
```

### Option 2: Run Demo
```bash
chmod +x demo.sh
./demo.sh
```

### Option 3: Automated Migration
```bash
chmod +x migrate.sh
./migrate.sh
```

### Option 4: Manual Migration
```bash
cp awesome awesome.backup
cp awesome-enhanced awesome
cp utils/lib utils/lib.backup
cp utils/lib-enhanced utils/lib
chmod +x awesome utils/lib
```

## Requirements

Same as original awesome:
- Bash 3.2+
- Git
- macOS or Linux

## Documentation

- **QUICKSTART.md** - Start here! 5-minute guide to new features
- **ENHANCEMENTS.md** - Complete feature documentation
- **IMPLEMENTATION_SUMMARY.md** - Technical overview of changes
- **docs/README.md** - Original awesome documentation

## Comparison Chart

| Feature | v0.5.3 | v0.6.0 |
|---------|--------|--------|
| Install packages | ✅ | ✅ |
| Network retry | ❌ | ✅ |
| Health check | ❌ | ✅ |
| Package info | ❌ | ✅ |
| Batch update | ❌ | ✅ |
| Backup/Restore | ❌ | ✅ |
| Configuration | ❌ | ✅ |
| Logging | ❌ | ✅ |
| Statistics | ❌ | ✅ |
| Completion | ❌ | ✅ |

## Getting Help

```bash
# Built-in help
awesome --help
awesome doctor

# Documentation
cat QUICKSTART.md
cat ENHANCEMENTS.md

# Logs (if enabled)
tail ~/.local/share/awesome/logs/awesome.log
```

## Contributing

1. Keep backward compatibility
2. Add tests for new features
3. Update documentation
4. Run test suite

## License

MIT - Same as original Awesome

## Credits

Enhanced by request for the Awesome Package Manager project by Shinichi Okada.

Original: https://github.com/shinokada/awesome

---

**Ready to try it?** Run `./demo.sh` to see all the new features! 🎉
