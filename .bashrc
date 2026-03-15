# Home server — set this to your server hostname/alias
HOME_SERVER="${HOME_SERVER:-homeserver}"

eval "$(starship init bash)"
alias ls='eza --icons'
alias ll='eza --icons -la'
alias cat='bat'
alias radio="python3 ~/Projects/radiooooo/radio.py"
alias books="ls ~/Library/Mobile\ Documents/iCloud~com~apple~iBooks/Documents/"
readbook() {
  local dir="$HOME/Library/Mobile Documents/iCloud~com~apple~iBooks/Documents"
  local file=$(ls "$dir"/*.epub 2>/dev/null | sed "s|.*/||" | fzf --prompt="📖 Pick a book: ")
  [ -n "$file" ] && bookokrat "$dir/$file"
}
nsend() { scp -r "$1" "$HOME_SERVER":~/drop/; }

# Convert documents via home server (PDF→EPUB, etc.)
# Usage: nconvert <file> [format]
# Example: nconvert paper.pdf epub
nconvert() {
    local file="$1"
    local fmt="${2:-epub}"
    local name=$(basename "$file")
    local base="${name%.*}"
    
    if [[ -z "$file" ]]; then
        echo "Usage: nconvert <file> [format]"
        echo "Formats: epub, md, html, txt, docx"
        return 1
    fi
    
    echo "📤 Sending $name to home server..."
    scp -r "$file" "$HOME_SERVER":~/drop/ || { echo "Failed to send file"; return 1; }
    
    echo "⚙️  Converting to $fmt..."
    ssh "$HOME_SERVER" "bash ~/scripts/doc-convert.sh \"\$HOME/drop/$name\" -f $fmt" || { echo "Conversion failed"; return 1; }
    
    echo "📥 Fetching result..."
    scp ""$HOME_SERVER":~/drop/${base}.${fmt}" . || { echo "Failed to fetch result"; return 1; }
    
    echo "✅ Done: $base.$fmt"
}

# Terminal capture — syncs compile/run output to home server
rr() {
    echo "=== $(date) | $* ===" > .terminal.log
    "$@" 2>&1 | tee -a .terminal.log
}

# Launch study session
alias rook="bash ~/ClawdbotSync/terminal-classroom/rook-session.sh"
alias cb="bash ~/ClawdbotSync/terminal-classroom/claude-chat.sh"
