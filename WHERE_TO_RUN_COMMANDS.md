# ⚠️ IMPORTANT: Where to Run Commands

## Directory Structure Explained

```
/Users/shinichiokada/
├── Bash/
│   └── awesome/                           ← SOURCE DIRECTORY (work here!)
│       ├── awesome                        ← Main script (original)
│       ├── awesome-enhanced               ← Enhanced version
│       ├── utils/
│       │   ├── lib                        ← Library (original)
│       │   └── lib-enhanced               ← Enhanced library
│       ├── migrate.sh
│       ├── show-enhancements.sh
│       └── ... (all other files)
│
└── .local/share/
    ├── bin/
    │   └── awesome                        ← SYMLINK ONLY (don't touch!)
    │
    └── awesome/                           ← INSTALLED PACKAGES
        ├── gitstart/
        ├── cleanit/
        └── ... (your installed packages)
```

## The Two Directories Explained

### 1. Source Directory: `~/Bash/awesome/` ✅ WORK HERE

**This is where:**
- The awesome project source code lives
- Development and testing happens
- You make changes and improvements
- All the enhanced files are located

**Commands to run here:**
```bash
cd ~/Bash/awesome
./awesome-enhanced doctor
./show-enhancements.sh
./migrate.sh
```

### 2. Installation Directory: `~/.local/share/` ❌ DON'T WORK HERE

**This contains:**
- `bin/` - Symlinks to your scripts (created by awesome)
- `awesome/` - Installed packages (cloned repos)

**The symlink explained:**
```bash
~/.local/share/bin/awesome  →  ~/Bash/awesome/awesome
       (symlink)                    (actual script)
```

When you run `awesome` from anywhere, it uses the symlink which points to the actual script in your source directory.

## What Happens When You Migrate

```bash
# Before migration
~/Bash/awesome/
├── awesome              ← v0.5.3 (old)
├── awesome-enhanced     ← v0.6.0 (new)
└── utils/lib            ← old library

# After migration (what migrate.sh does)
~/Bash/awesome/
├── awesome              ← v0.6.0 (replaced!)
├── awesome.v0.5.3.backup  ← v0.5.3 (backed up)
└── utils/lib            ← new library (replaced!)
└── utils/lib.v0.5.3.backup  ← old library (backed up)

# The symlink automatically uses the new version
~/.local/share/bin/awesome  →  ~/Bash/awesome/awesome (now v0.6.0!)
```

## Quick Reference

### ✅ DO: Work in Source Directory

```bash
# Always start here
cd ~/Bash/awesome

# Test enhanced version
./awesome-enhanced doctor

# Run feature showcase
./show-enhancements.sh

# Migrate when ready
./migrate.sh
```

### ❌ DON'T: Touch the Symlink Directory

```bash
# Don't do this
cd ~/.local/share/bin
# Nothing to do here - it's just symlinks!
```

## How to Remember

Think of it like this:

- **`~/Bash/awesome/`** = Your workshop (where you build/modify)
- **`~/.local/share/bin/`** = Your toolbelt (where shortcuts live)
- **`~/.local/share/awesome/`** = Your warehouse (where packages are stored)

You work in the **workshop**, and the tools in your **toolbelt** automatically point to what you build.

## Commands Cheat Sheet

```bash
# 1. Navigate to source directory
cd ~/Bash/awesome

# 2. Test everything
./test-enhanced.sh

# 3. Try the features
./awesome-enhanced doctor

# 4. See the showcase
./show-enhancements.sh

# 5. Migrate (when ready)
./migrate.sh

# 6. After migration, awesome command works everywhere
cd ~
awesome doctor  # Works from any directory!
```

## Still Confused?

**Simple rule:** If you're doing anything with `awesome-enhanced`, `migrate.sh`, or modifying files, you must be in:

```bash
cd ~/Bash/awesome
pwd
# Should show: /Users/shinichiokada/Bash/awesome
```

If you see `/Users/shinichiokada/.local/share/bin`, you're in the wrong place!
