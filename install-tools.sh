#!/usr/bin/env bash
# Install the terminal toolkit into ~/.local/bin without sudo or Homebrew.
# Linux x86_64 and macOS arm64. (eza/btop have no mac binaries; use brew there if you can.)
set -euo pipefail
BIN="$HOME/.local/bin"; mkdir -p "$BIN" "$HOME/.config" "$HOME/.local/share"
export PATH="$BIN:$PATH"
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
gh_latest() { curl -fsSL "https://api.github.com/repos/$1/releases/latest" | grep -o '"tag_name": *"[^"]*"' | cut -d'"' -f4; }

case "$(uname -s)-$(uname -m)" in
  Linux-x86_64)  RUST=x86_64-unknown-linux-gnu;  FZF=linux_amd64;  NVIM=nvim-linux-x86_64; FF=linux-amd64 ;;
  Darwin-arm64)  RUST=aarch64-apple-darwin;      FZF=darwin_arm64; NVIM=nvim-macos-arm64;  FF=macos-aarch64 ;;
  *) echo "unsupported platform"; exit 1 ;;
esac

echo ">> starship"; curl -sS https://starship.rs/install.sh | sh -s -- -y --bin-dir "$BIN" >/dev/null
echo ">> zoxide";   curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- --bin-dir "$BIN" >/dev/null

if [ "$RUST" = x86_64-unknown-linux-gnu ]; then
  echo ">> eza"; curl -fsSL "https://github.com/eza-community/eza/releases/latest/download/eza_$RUST.tar.gz" | tar xz -C "$T" && mv "$T/eza" "$BIN/"
fi

v=$(gh_latest sharkdp/bat); echo ">> bat $v"
curl -fsSL "https://github.com/sharkdp/bat/releases/download/$v/bat-$v-$RUST.tar.gz" | tar xz -C "$T"; mv "$T"/bat-*/bat "$BIN/"

v=$(gh_latest junegunn/fzf); echo ">> fzf $v"
curl -fsSL "https://github.com/junegunn/fzf/releases/download/$v/fzf-${v#v}-$FZF.tar.gz" | tar xz -C "$T" && mv "$T/fzf" "$BIN/"
echo 'eval "$(fzf --bash)"' > "$HOME/.fzf.bash"

v=$(gh_latest sxyazi/yazi); echo ">> yazi $v"
curl -fsSL "https://github.com/sxyazi/yazi/releases/download/$v/yazi-$RUST.zip" -o "$T/yazi.zip"
(cd "$T" && unzip -q yazi.zip && mv yazi-*/yazi yazi-*/ya "$BIN/")

echo ">> neovim"; curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/$NVIM.tar.gz" | tar xz -C "$T"
rm -rf "$HOME/.local/nvim" && mv "$T/$NVIM" "$HOME/.local/nvim" && ln -sfn "$HOME/.local/nvim/bin/nvim" "$BIN/nvim"

v=$(gh_latest dandavison/delta); echo ">> delta $v"
curl -fsSL "https://github.com/dandavison/delta/releases/download/$v/delta-$v-$RUST.tar.gz" | tar xz -C "$T"; mv "$T"/delta-*/delta "$BIN/"

echo ">> fastfetch"; curl -fsSL "https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-$FF.tar.gz" | tar xz -C "$T"
mv "$T"/fastfetch-*/usr/bin/fastfetch "$BIN/"

echo ">> atuin"; curl -sSfL https://setup.atuin.sh | sh -s -- --no-modify-path >/dev/null 2>&1 || true
[ -x "$HOME/.atuin/bin/atuin" ] && ln -sfn "$HOME/.atuin/bin/atuin" "$BIN/atuin"

# zsh plugins (used by zshrc when brew's copies aren't present)
for p in zsh-autosuggestions zsh-syntax-highlighting; do
  d="$HOME/.local/share/$p"; [ -d "$d" ] && git -C "$d" pull -q || git clone -q --depth 1 "https://github.com/zsh-users/$p" "$d"
done

command -v bat >/dev/null && bat cache --build >/dev/null
echo "installed: $(cd "$BIN" && ls starship zoxide eza bat fzf yazi nvim delta fastfetch 2>/dev/null | tr '\n' ' ')"
