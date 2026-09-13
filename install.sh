#!/usr/bin/env bash
# Symlink dotfiles into place. Safe to re-run.
# Usage: ./install.sh
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.config"

link() {
  local src="$DOTFILES/$1" dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak-$(date +%Y%m%d-%H%M%S)"
    echo "backed up $dst"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "linked $dst -> $src"
}

link zsh/zshrc            "$HOME/.zshrc"
link zsh/zprofile         "$HOME/.zprofile"
link bash/bashrc          "$HOME/.bashrc"
link bash/bash_profile    "$HOME/.bash_profile"
link tmux/tmux.conf       "$HOME/.tmux.conf"
link starship/starship.toml "$HOME/.config/starship.toml"
link nvim                 "$HOME/.config/nvim"
link fastfetch            "$HOME/.config/fastfetch"
link bat                  "$HOME/.config/bat"
link git/gitconfig        "$HOME/.gitconfig"
link btop                 "$HOME/.config/btop"
link yazi                 "$HOME/.config/yazi"
link iterm2/mocha-profile.json "$HOME/Library/Application Support/iTerm2/DynamicProfiles/mocha.json"
link git/gitignore_global  "$HOME/.config/git/ignore"
link atuin                 "$HOME/.config/atuin"
# tmux plugin manager
[ -d "$HOME/.tmux/plugins/tpm" ] || git clone -q https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
"$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null 2>&1 && echo "tmux plugins installed"
link karabiner/karabiner.json "$HOME/.config/karabiner/karabiner.json"
# mac-only: downloads tidier on an hourly launchd timer
if [ "$(uname -s)" = Darwin ]; then
  link mac/bin/tidy-downloads "$HOME/.local/bin/tidy-downloads"
  mkdir -p "$HOME/Library/LaunchAgents"
  cp "$DOTFILES/mac/launchd/com.anna.tidy-downloads.plist" "$HOME/Library/LaunchAgents/"
  launchctl bootout "gui/$(id -u)/com.anna.tidy-downloads" 2>/dev/null || true
  launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.anna.tidy-downloads.plist" && echo "tidy-downloads scheduled (hourly)"
fi
