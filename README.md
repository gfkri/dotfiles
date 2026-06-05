# 🎯 Dotfiles

Configuration files and automated setup for macOS and Linux development environments.

## 📋 Directory Structure

```
~/.dotfiles/
├── vim/              # Vim/Neovim configuration
├── zsh/              # Zsh shell configuration (.zshrc, .zprofile, etc.)
├── tmux/             # Tmux configuration
├── ghostty/          # Ghostty terminal configuration
├── install.sh        # Main installation script
├── macos.sh          # macOS-specific setup
├── utils.sh          # Shared utility functions
└── README.md         # This file
```

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone git@github.com:gfkri/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Preview what will be installed (dry-run)

```bash
./install.sh --dry-run
```

### 3. Run the installer

```bash
./install.sh
```

That's it! The script will:
- Install dependencies (Homebrew, packages, tools)
- Symlink your dotfiles into `~` using stow
- Set up shell frameworks and plugins
- Display any manual steps needed

## 🔗 How Stow Works

The script uses **GNU stow** to symlink dotfiles. Your directory structure in `~/.dotfiles/` directly mirrors your home directory:

```
~/.dotfiles/zsh/.zshrc → ~/.zshrc
~/.dotfiles/tmux/.tmux.conf → ~/.tmux.conf
~/.dotfiles/vim/.vimrc → ~/.vimrc
~/.dotfiles/ghostty/config → ~/.config/ghostty/config
```

**Advantage:** All dotfiles are version-controlled in one place, but appear in their expected locations in your home.

## 📦 What Gets Installed

### Dependencies Installed
- **Oh My Zsh** – Shell framework
- **Tmux** – Terminal multiplexer + plugin manager (tpm)
- **Powerlevel10k** – Zsh theme
- **Zsh Plugins** – zsh-autosuggestions, zsh-eza
- **uv** – Python project manager (cross-platform)

### macOS Only
- **Homebrew** – Package manager
- **Packages** – stow, tmux, thefuck, fzf, eza
- **Applications** – Visual Studio Code, Firefox, Docker (installed via DMG)

## 🛠️ Scripts Reference

### `install.sh` – Main orchestrator
- Parses `--dry-run` / `-d` flag
- Detects OS and sources platform-specific setup
- Installs tools and applications
- Symlinks dotfiles with stow
- Collects and displays manual setup steps

### `macos.sh` – macOS-specific
- Installs Homebrew
- Installs Homebrew packages
- Downloads and installs DMG applications
- Sourced (not subprocess) to maintain variable scope

### `utils.sh` – Shared utilities
- `print_section LEVEL "text"` – Hierarchical output formatting
- `command_exists CMD` – Check if command exists
- `dir_exists PATH` – Check if directory exists
- `is_dryrun` – Check dry-run mode
- `add_manual_step TEXT` – Collect manual steps
- `print_manual_steps` – Display all manual steps
- `install_dmg NAME URL` – Download and install DMG

## 📋 Manual Setup Steps

After installation, the script will display steps that require manual action:

- **Disable autocorrect** – System Settings > Keyboard > Input Sources > Edit
- **Enable Ghostty accessibility** – System Settings > Privacy & Security > Accessibility
- **Download Logi Options** – If using Logitech devices

## 🔄 Safe to Re-run

It's completely safe to run `./install.sh` multiple times:
- Already-installed tools are skipped
- Stow verifies and repairs symlinks
- No harm if run repeatedly

Use this to:
- Fix broken symlinks
- Update after adding new dotfiles
- Re-sync configuration

## 🤔 Troubleshooting

**Symlinks not appearing?**  
Ensure the folder is in `STOW_FOLDERS` array in `install.sh` and the directory exists in `~/.dotfiles/`.

**Command not found after install?**  
Start a new shell session: `exec zsh`

**Permission denied?**  
Make scripts executable: `chmod +x install.sh macos.sh`

**Something went wrong?**  
Stow is safe to rollback. Just remove symlinks manually or check existing symlinks with:
```bash
ls -la ~/ | grep "^l"
```

## 📚 Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/)
- [Oh My Zsh](https://ohmyz.sh/)
- [Tmux](https://github.com/tmux/tmux)
- [uv Package Manager](https://astral.sh/uv/)
