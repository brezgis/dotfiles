# dotfiles

Anna's terminal configs. Catppuccin Mocha everything.

## What's here

- `.tmux.conf` — tmux config (Ctrl+A prefix, mouse, Catppuccin Mocha borders, 256color)
- `.bashrc` — starship prompt, eza/bat aliases (`ls` → `eza --icons`, `ll` → `eza --icons -la`, `cat` → `bat`), interactive-only guard
- `.bash_profile` — Homebrew shellenv, PATH setup, conda init, sources .bashrc (macOS paths)
- `Brewfile` — full Homebrew bundle (formulae, casks, VS Code extensions)

The last couple of aliases in `.bashrc` point at scripts that live outside this
repo — drop or edit those if you're borrowing the config.

## Setup on a new machine

Install Homebrew, then restore everything from the Brewfile:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file=~/dotfiles/Brewfile
```

Symlink configs:

```bash
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
```

## Updating

Dump current Homebrew state and push:

```bash
brew bundle dump --force --file=~/dotfiles/Brewfile
cd ~/dotfiles
git add -A
git commit -m "Update dotfiles"
git push
```

## Stack

- **Terminal:** iTerm2 + JetBrains Mono Nerd Font
- **Color scheme:** [Catppuccin Mocha](https://github.com/catppuccin/catppuccin)
- **Prompt:** [Starship](https://starship.rs)
- **Shell:** bash
- **Tools:** eza, bat, fastfetch, lazygit, glow, tmux, cbonsai, asciiquarium

## License

MIT — see [LICENSE](LICENSE).
