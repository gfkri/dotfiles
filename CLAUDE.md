# Dotfiles

Cross-platform dotfiles managed with GNU stow. Targets macOS and Ubuntu (including Docker).

## Structure

```
install.sh          Entry point. Detects OS, runs platform setup, installs tools, stows configs.
macos.sh            macOS-specific: Homebrew + packages + DMG apps.
ubuntu.sh           Ubuntu-specific: apt packages + eza/jless/fzf/thefuck binaries.
utils.sh            Shared helpers: print_section, is_dryrun, is_minimal, is_force_stow, add_manual_step.
docker/
  build.sh          Generic build script. Takes variant name, optional --tag, passes extra args to docker build.
  ubuntu2404/
    Dockerfile      Ubuntu 24.04 base. Creates appuser (UID/GID 1001), clones repo, runs install.sh + tpm install_plugins.
    entrypoint.sh   Sets HOME, cd's to ~, remaps UID/GID via LOCAL_UID/LOCAL_GID, drops to appuser via gosu.
  pytorch/
    Dockerfile      vastai/pytorch base (linux/amd64). Same user setup, runs install.sh --force-stow + tpm install_plugins.
    entrypoint.sh   Same as ubuntu2404.
git/                → ~/.gitconfig
ghostty/            → ~/Library/Application Support/com.mitchellh.ghostty/ (macOS only)
ohmyzsh/            → ~/.oh-my-zsh/custom/aliases.zsh (eza aliases)
p10k/               → ~/.p10k.zsh
tmux/               → ~/.tmux.conf
vim/                → ~/.vimrc, ~/.vim/
zsh/                → ~/.zshrc, ~/.zprofile
```

## install.sh flags

| Flag | Effect |
|------|--------|
| `--dry-run` / `-d` | Print what would happen, no changes |
| `--minimal` / `-m` | Skip omz, p10k, tmux plugins, zsh plugins |
| `--force-stow` / `-f` | Use `--adopt` + `git checkout` to overwrite existing files |

## Key conventions

- **Install order matters**: omz installs before stow to avoid stow creating `~/.oh-my-zsh/` as a real dir and causing omz installer to skip.
- **sudo handling**: `ubuntu.sh` detects root via `$EUID` — no sudo when root. Docker containers run as `appuser` (non-root) with passwordless sudo, so sudo is used.
- **MANUAL_STEPS**: owned by `install.sh` (initialized after sourcing utils.sh). Platform scripts append via `add_manual_step`.
- **PATH setup**: all PATH exports in `.zprofile` (login shell). `.zshrc` is interactive config only.
- **Homebrew**: guarded with `[[ "$OSTYPE" == "darwin"* ]]` everywhere — never runs on Linux.
- **eza binary**: uses `linux-gnu` variant (no musl for aarch64). URL: `latest/download/eza_${ARCH}-unknown-linux-gnu.tar.gz`.
- **jless binary**: version-tagged URL — must fetch tag from GitHub API first. No aarch64 Linux release upstream.
- **force-stow uses `--adopt` only (not `--restow`)**: `--restow` runs an unstow phase first — if omz created `~/.zshrc` as a real file (not a symlink), stow aborts with "existing target is neither a link nor a directory". `--adopt` alone handles adoption without the unstow phase.
- **fzf on Ubuntu**: installed via `git clone https://github.com/junegunn/fzf.git ~/.fzf` + `~/.fzf/install --all --no-update-rc` — apt package doesn't ship key-bindings file. omz plugin uses `fzf_setup_using_local_installation` path.
- **thefuck on Ubuntu**: installed via `pipx` (not pip3) — Ubuntu 24.04 enforces PEP 668 externally-managed-environment. `pipx` in `APT_PACKAGES`. Binary lands in `~/.local/bin` — added to PATH in `.zprofile`.
- **tmux clipboard**: `pbcopy` is macOS-only. `.tmux.conf` uses `if-shell` to switch between `pbcopy` (Darwin) and `xclip` (Linux). `xclip` is in `APT_PACKAGES`.
- **tmux + p10k Nerd Fonts**: set `default-terminal "tmux-256color"` + `terminal-overrides ",*256col*:Tc"`. Using `screen-256color` causes p10k to fall back to ASCII glyphs inside tmux. `ncurses-term` apt package required for `tmux-256color` terminfo on Ubuntu.
- **tmux plugins pre-installed in Docker**: Dockerfiles run `~/.tmux/plugins/tpm/bin/install_plugins` after `install.sh` so plugins are ready on first session.
- **tmux auto-start in Docker**: `.zshrc` sets `ZSH_TMUX_AUTOSTART=true` when `/.dockerenv` exists — tmux starts automatically on container login.
- **tmux dracula gpu-usage**: guarded with `if-shell "command -v nvidia-smi"` — omitted on non-GPU containers.

## provision.sh

Clones the dotfiles repo into `$HOME` and runs `install.sh --force-stow`. Safe to re-run. Accepts any `install.sh` flags.

```bash
# Run on any machine or in any container — no pre-cloning needed
bash <(curl -fsSL https://raw.githubusercontent.com/gfkri/dotfiles/main/provision.sh)

# With flags
bash <(curl -fsSL https://raw.githubusercontent.com/gfkri/dotfiles/main/provision.sh) --minimal
```

Paste the one-liner into vast.ai's **On-start script** field to auto-provision any instance.

## Docker

```bash
# Build
./docker/build.sh <variant> [--tag <tag>] [--bust-cache] [docker build args...]

# Examples
./docker/build.sh ubuntu2404
./docker/build.sh ubuntu2404 --bust-cache          # force re-clone dotfiles repo
./docker/build.sh pytorch --build-arg PYTORCH_TAG=2.11.0-cu128-cuda-12.9-mini-py314-2026-04-15
./docker/build.sh ubuntu2404 --no-cache

# Run
docker run --rm -it -e LOCAL_UID=$(id -u) -e LOCAL_GID=$(id -g) gfkri/dotfiles:ubuntu2404
```

- **User**: non-root `appuser` (UID/GID 1001 — avoids Ubuntu 24.04 reserved GID 1000). Override at build: `USERNAME=foo USER_UID=$(id -u) USER_GID=$(id -g) ./docker/build.sh <variant>`.
- **UID/GID remapping**: entrypoint remaps to `LOCAL_UID`/`LOCAL_GID` at runtime — fixes volume mount ownership on host. Entrypoint also sets `HOME=/home/${USERNAME}` and `cd`s there before exec — `gosu` does not set HOME, Docker defaults it to `/root` when last `USER` is root.
- **WORKDIR**: set to `/home/${USERNAME}` in Dockerfile, but only takes effect if entrypoint explicitly sets HOME/cd — otherwise shell starts in `/`.
- **pytorch**: forced `linux/amd64` platform (CUDA images are amd64-only). Uses `--force-stow` to overwrite pre-existing shell configs from base image.
