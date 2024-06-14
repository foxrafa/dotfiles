export PATH="/opt/homebrew/Cellar/bison/3.8.2/bin:$PATH"

DEFAULT_USER=”$”
COMPLETION_WAITING_DOTS="true"

#ENABLE_CORRECTION="true"

bindkey '^[[1;5D' beginning-of-line  # Cmd+Left
bindkey '^[[1;5C' end-of-line  # Cmd+Right

HISTSIZE=10000
setopt HIST_IGNORE_SPACE

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' case-insensitive true

bindkey '^[[A' history-search-backward  # Up arrow key
bindkey '^[[B' history-search-forward

set nocompatible 
set showcmd

autoload -Uz compinit
compinit

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/git_theme.plugin.zsh
source ~/.zsh/amuse.zsh-theme

if [ -f '/Users/fox/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/fox/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/fox/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/fox/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
