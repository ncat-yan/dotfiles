
# Path to your Oh My Zsh installation.
export ZSH="$XDG_DATA_HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZDOTDIR/custom"

ZSH_THEME="robbyrussell"

autoload -U compinit
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# Update settings
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

# Plugins
plugins=(
  git
  aliases
  autojump
  history
  zsh-autosuggestions
  zsh-syntax-highlighting
  colored-man-pages
  fzf
  ssh-agent
)

# ssh-agent settings
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent lazy yes

source $ZSH/oh-my-zsh.sh

# Starship prompt
eval "$(starship init zsh)"

# Optional completions
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"
