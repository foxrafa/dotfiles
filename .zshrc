DEFAULT_USER=”$”
COMPLETION_WAITING_DOTS="true"

ENABLE_CORRECTION="true"

bindkey '^[[1;5D' beginning-of-line  # Cmd+Left
bindkey '^[[1;5C' end-of-line  # Cmd+Right

HISTSIZE=10000
setopt HIST_IGNORE_SPACE
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' case-insensitive true

bindkey '^[[A' history-search-backward  # Up arrow key
bindkey '^[[B' history-search-forward

if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi

set nocompatible 
set showcmd

autoload -Uz compinit
compinit

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/git_theme.plugin.zsh
source ~/.zsh/amuse.zsh-theme
