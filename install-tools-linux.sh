#!/usr/bin/env bash
# Install the terminal toolkit into ~/.local/bin without sudo (for north / samovar).
set -euo pipefail
BIN="$HOME/.local/bin"; mkdir -p "$BIN" "$HOME/.config"
export PATH="$BIN:$PATH"
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
gh_latest() { curl -fsSL "https://api.github.com/repos/$1/releases/latest" | grep -o '"tag_name": *"[^"]*"' | cut -d'"' -f4; }

echo ">> starship"; curl -sS https://starship.rs/install.sh | sh -s -- -y --bin-dir "$BIN" >/dev/null
echo ">> zoxide";   curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- --bin-dir "$BIN" >/dev/null

echo ">> eza"; curl -fsSL "https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz" | tar xz -C "$T" && mv "$T/eza" "$BIN/"

v=$(gh_latest sharkdp/bat); echo ">> bat $v"
curl -fsSL "https://github.com/sharkdp/bat/releases/download/$v/bat-$v-x86_64-unknown-linux-gnu.tar.gz" | tar xz -C "$T"
mv "$T"/bat-*/bat "$BIN/"

v=$(gh_latest junegunn/fzf); echo ">> fzf $v"
curl -fsSL "https://github.com/junegunn/fzf/releases/download/$v/fzf-${v#v}-linux_amd64.tar.gz" | tar xz -C "$T" && mv "$T/fzf" "$BIN/"
{ echo 'eval "$(fzf --bash)"'; } > "$HOME/.fzf.bash"

v=$(gh_latest sxyazi/yazi); echo ">> yazi $v"
curl -fsSL "https://github.com/sxyazi/yazi/releases/download/$v/yazi-x86_64-unknown-linux-gnu.zip" -o "$T/yazi.zip"
(cd "$T" && unzip -q yazi.zip && mv yazi-*/yazi yazi-*/ya "$BIN/")

echo ">> neovim"; curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz" | tar xz -C "$T"
rm -rf "$HOME/.local/nvim" && mv "$T/nvim-linux-x86_64" "$HOME/.local/nvim" && ln -sfn "$HOME/.local/nvim/bin/nvim" "$BIN/nvim"

v=$(gh_latest dandavison/delta); echo ">> delta $v"
curl -fsSL "https://github.com/dandavison/delta/releases/download/$v/delta-$v-x86_64-unknown-linux-gnu.tar.gz" | tar xz -C "$T"
mv "$T"/delta-*/delta "$BIN/"

echo ">> fastfetch"; curl -fsSL "https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.tar.gz" | tar xz -C "$T"
mv "$T"/fastfetch-linux-amd64/usr/bin/fastfetch "$BIN/"

command -v bat >/dev/null && bat cache --build >/dev/null
echo "done: $(ls "$BIN" | tr '\n' ' ')"
