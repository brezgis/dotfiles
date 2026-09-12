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
