# dotfiles

Anna's terminal configs. Catppuccin Mocha everything.

## What's here
- `.tmux.conf` — tmux config (Ctrl+A prefix, mouse, Catppuccin borders)
- `.bashrc` — starship prompt, eza/bat aliases
- `.bash_profile` — PATH setup, conda init, loads bashrc

## Setup on a new machine
bash
brew install tmux starship eza bat fastfetch lazygit glow
Then symlink:
bash
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.bashrc ~/.bashrc
```

Save (Ctrl+O, Enter, Ctrl+X). Then:

```
cd ~/dotfiles
git add -A
git commit -m "initial dotfiles: tmux, bash, starship, catppuccin"

