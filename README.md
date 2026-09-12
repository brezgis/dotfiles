# dotfiles

Anna's terminal configs. Catppuccin Mocha everything.

## Layout

| dir | what |
|---|---|
| `zsh/` | `zshrc` (aliases, plugins, fzf/zoxide/starship) + `zprofile` (PATH) |
| `bash/` | minimal fallback for machines that still run bash (north) |
| `starship/` | prompt |
| `tmux/` | Ctrl+A prefix, mouse, Rosé Pine status bar |
| `nvim/` | tiny `init.lua` — one plugin (the colorscheme), `vim` is aliased to it |
| `bat/` | Rosé Pine theme for `cat` |
| `fastfetch/` | logo-less system summary |
| `Brewfile` | Homebrew bundle |

Machine-local overrides go in `~/.zshrc.local` / `~/.bashrc.local` (untracked).

## New machine

```bash
git clone https://github.com/brezgis/dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles && ./install.sh
# mac only:
brew bundle
bat cache --build
```

`install-tools.sh` installs the toolkit into `~/.local/bin` without sudo (Linux or Mac). `install.sh` symlinks everything into place and backs up anything it replaces.

## Stack

- **Terminal:** iTerm2 + JetBrains Mono Nerd Font
- **Colors:** [Catppuccin Mocha](https://catppuccin.com)
- **Shell:** zsh + zsh-autosuggestions + zsh-syntax-highlighting
- **Prompt:** [Starship](https://starship.rs)
- **Tools:** eza, bat, fzf, zoxide, lazygit, tmux, fastfetch
