# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for managing personal configuration files and system setup scripts, following the XDG Base Directory Specification.

## Directory Structure

```
~/.dotfiles/
├── .config/          # Application configurations (XDG compliant)
│   ├── zsh/         # Zsh + Oh My Zsh configuration
│   ├── git/         # Git configuration
│   ├── nvim/        # Neovim (LazyVim) configuration
│   ├── ghostty/     # Ghostty terminal configuration
│   ├── karabiner/   # Karabiner keyboard mapping
│   ├── npm/         # NPM configuration
│   └── starship.toml # Starship prompt configuration
├── Brewfile         # Homebrew package management
├── install.sh       # Installation script
└── README.md
```

## Key Configuration Files

### Zsh Configuration
- `.config/zsh/.zshenv` - Environment variables and XDG paths (sources `.zshenv.local`)
- `.config/zsh/.zshenv.local` - Local environment variables with sensitive information (NOT tracked in git)
- `.config/zsh/.zshenv.local.example` - Template for local environment variables
- `.config/zsh/.zprofile` - Homebrew initialization
- `.config/zsh/.zshrc` - Oh My Zsh configuration and plugins
- `.config/zsh/custom/` - Custom aliases, plugins, and themes
- `.config/zsh/hosts/` - Host-specific configuration (loaded by `.zshenv`)

### XDG Environment Variables
All set in `.zshenv`:
- `ZDOTDIR=$HOME/.config/zsh`
- `XDG_CONFIG_HOME=$HOME/.config`
- `XDG_CACHE_HOME=$HOME/.cache`
- `XDG_DATA_HOME=$HOME/.local/share`
- `XDG_STATE_HOME=$HOME/.local/state`
- `XDG_RUNTIME_DIR=$HOME/.xdg`

### Oh My Zsh
- Installation location: `$XDG_DATA_HOME/.oh-my-zsh` (`~/.local/share/.oh-my-zsh`)
- Custom directory: `$ZDOTDIR/custom` (`~/.config/zsh/custom`)
- Plugins: git, aliases, autojump, history, zsh-autosuggestions, zsh-syntax-highlighting, colored-man-pages, fzf, ssh-agent
- Custom plugins (zsh-autosuggestions, zsh-syntax-highlighting) are managed as **git submodules**

## Common Tasks

### Install on a new machine
```bash
git clone --recursive <repo-url> ~/.dotfiles
cd ~/.dotfiles
./install.sh
cp ~/.config/zsh/.zshenv.local.example ~/.config/zsh/.zshenv.local
# Edit .zshenv.local with your sensitive information
```

### Install script options
```bash
./install.sh              # Full installation
./install.sh --skip-brew  # Skip Homebrew installation
./install.sh --skip-omz   # Skip Oh My Zsh installation
./install.sh --help       # Show help
```

### Update Brewfile
```bash
cd ~/.dotfiles
brew bundle dump --force
```

### Add new configuration
```bash
# Copy config to dotfiles repo
cp -r ~/.config/app ~/.dotfiles/.config/
# Commit changes
cd ~/.dotfiles
git add .config/app
git commit -m "Add app configuration"
```

### Test configuration changes
```bash
# For zsh changes
source ~/.config/zsh/.zshenv
source ~/.config/zsh/.zshrc

# Or restart terminal
```

## Important Notes

### Sensitive Information
- `.zshenv.local` contains sensitive information (API tokens, credentials)
- This file is in `.gitignore` and should NEVER be committed
- Use `.zshenv.local.example` as a template for new setups
- `.zshenv` automatically sources `.zshenv.local` if it exists

### Symlink Management
The `install.sh` script creates symlinks:
- `~/.zshenv` → `~/.dotfiles/.config/zsh/.zshenv` (so zsh finds ZDOTDIR)
- `~/.config/<app>` → `~/.dotfiles/.config/<app>` (for each config directory)
- `~/.config/starship.toml` → `~/.dotfiles/.config/starship.toml`

Changes in `~/.config/` are automatically reflected in the dotfiles repo.

### Plugin Management
Custom zsh plugins are managed as git submodules in `.config/zsh/custom/plugins/`:
- `install.sh` runs `git submodule update --init` to install them
- To update plugins: `git submodule update --remote`

### Homebrew
- Installed at `/opt/homebrew` (Apple Silicon)
- All packages managed via `Brewfile`
- Use `brew bundle` to install packages from Brewfile
- Use `brew bundle dump --force` to update Brewfile with currently installed packages

## Architecture Notes

This setup uses:
1. **XDG Base Directory Specification** - All configs follow XDG standards
2. **Symlink-based management** - `install.sh` creates symlinks instead of copying files
3. **Git submodules** - Custom zsh plugins tracked as submodules
4. **Separation of concerns** - Sensitive data in `.zshenv.local`, public config in tracked files
5. **Homebrew for package management** - All CLI tools and apps managed via Brewfile
6. **Oh My Zsh** - Installed in XDG-compliant location with custom plugins
