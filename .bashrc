# Interactive shells only (skip for ssh-command / scripts)
case $- in *i*) ;; *) return ;; esac

eval "$(starship init bash)"

# Quality-of-life aliases
alias ls='eza --icons'
alias ll='eza --icons -la'
alias cat='bat'

# radiooooo.com — global radio in the terminal
alias radio="python3 ~/Projects/radiooooo/radio.py"

# Terminal launcher menu
alias menu='bash ~/ClawdbotSync/terminal-menu/menu.sh'
