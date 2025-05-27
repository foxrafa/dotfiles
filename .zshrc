# ===== Path Configurations =====
export PATH="/opt/homebrew/Cellar/bison/3.8.2/bin:$PATH"
export PATH="$PATH:/Users/fox/bin:/opt/homebrew/bin:/opt/nvim/:/opt/nvim-linux64/bin:/opt/homebrew/bin/magick:$HOME/go/bin"
export DYLD_LIBRARY_PATH="/opt/homebrew/lib:/opt/homebrew/bin:$DYLD_LIBRARY_PATH"

# ===== History Settings =====
HISTFILE=~/.zsh_history
HISTSIZE=3000000
SAVEHIST=3000000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
export HISTTIMEFORMAT="[%F %T] "

# ===== Zsh Options and Settings =====
DEFAULT_USER="$"
COMPLETION_WAITING_DOTS="true"
set nocompatible 
set showcmd

# Enable command completion
autoload -Uz compinit
compinit

# ===== Source Additional Configuration Files =====
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/git_theme.plugin.zsh
source ~/.zsh/amuse.zsh-theme
source ~/.zsh/jumplist.zsh

# ===== Google Cloud SDK Configuration =====
if [ -f '/Users/fox/google-cloud-sdk/path.zsh.inc' ]; then
  source '/Users/fox/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/fox/google-cloud-sdk/completion.zsh.inc' ]; then
  source '/Users/fox/google-cloud-sdk/completion.zsh.inc'
fi
if [ $commands[kubectl] ]; then
  source ~/.zsh/kubectl_completion.sh
fi

alias c=clear
alias who=/usr/bin/w
alias w=watch -n 1
# ===== Aliases =====
# Git aliases
alias gv='open -a fork .'
alias gb='git checkout'
alias lg='lazygit'
alias s='lazysql'

alias snowden='ssh -i ~/.ssh/snowden fox@ssh.rafafox.com -p 22'
test_direct_connection() {
    WORK_IP=$(ssh -o ConnectTimeout=3 -A -J fox@ssh.rafafox.com rfox@localhost -p 2222 \
        "ifconfig en0 | grep 'inet ' | grep -v 127.0.0.1 | awk '{print \$2}'" 2>/dev/null)
    
    if [[ -z "$WORK_IP" ]]; then
        return 1
    fi
    
    
    if ssh -o ConnectTimeout=3 rfox@$WORK_IP "echo 'success'" >/dev/null 2>&1; then
        export WORK_MAC_IP="$WORK_IP"
        return 0
    else
        return 1
    fi
}

groq() {
    ssh-add ~/.ssh/snowden 2>/dev/null
    
    if test_direct_connection; then
        echo "Connecting directly to $WORK_MAC_IP"
        ssh rfox@$WORK_MAC_IP
    else
        echo "Using tunnel"
        ssh -A -J fox@ssh.rafafox.com rfox@localhost -p 2222
    fi
}

groqd() {
    ssh-add ~/.ssh/snowden 2>/dev/null
    
    if test_direct_connection; then
        echo "Opening VNC directly to $WORK_MAC_IP"
        open vnc://$WORK_MAC_IP:5900
    else
        echo "Setting up tunnel for VNC"
        pkill -f "ssh.*5900.*" 2>/dev/null
        ssh -A -f -N -J fox@ssh.rafafox.com -L 5900:Rafaels-Mac.local:5900 rfox@localhost -p 2222
        sleep 2
        open vnc://localhost:5900
    fi
}
alias groqvm='ssh rfox'

# Kubernetes aliases
alias gke='kubectl --context=staging-gke-cluster'
alias vke='kubectl --context=staging-vke-cluster'
alias production_gke='kubectl --context=production-gke-cluster'
alias production_vke='kubectl --context=production-vke-cluster'

# Google Cloud aliases
alias ga='gcloud auth application-default login; gcloud auth login'
alias gli='gcloud compute instances list --format="table(name, networkInterfaces[].ipv6AccessConfigs[0].externalIpv6.notnull().list():label=EXTERNAL_IPV6, status)"'
alias pping='/sbin/ping'
alias ping='gping'

# Filesystem and navigation aliases
alias refresh='source ~/.zshrc'
alias t='tree'
alias l='ls -la'
alias code='cd ~/code'
alias fcode='open -a "finder" ~/code'

# Development aliases
alias nr='npm run'
alias br='bun run'
alias p2='python2'
alias p3='python3'
alias pip='pip3'
alias jn='jupyter notebook'

# Application aliases
alias sb='open -a "Sublime Text"'

# Misc aliases
alias d='cd ~/notes && vim /Users/fox/notes/do.md'
alias box='gcloud compute ssh box-rafa'
alias lbox='multipass shell ubuntu'
alias nmap='rustscan'

# ===== Custom Functions =====
# Docker stop all running containers
ds() {
  running=$(docker ps -q)
  if [ -z "$running" ]; then
    echo "No running containers."
  else
    echo "Stopping containers:"
    echo "$running" | xargs -r docker stop
    echo "All containers stopped."
  fi
}

# Git push with optional commit message
gg() {
  remote_url=$(git config --get remote.origin.url)
  [ -z "$remote_url" ] && echo "Error: Not in a Git repository." && exit 1
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  github_url="${remote_url%.git}/tree/$current_branch"
  
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "$github_url"
  else
    open "$github_url"
  fi
}

gtp() {
  gt add --all
  gt create -m "$*"
  gt submit
}

gtm() {
  gt add --all
  gt modify -m "$*"
  gt submit --cli
}

gp() {
  branch=$(git rev-parse --abbrev-ref HEAD)
  git add --all
  if [ -z "$1" ]; then
    git commit -m fix
  else
    git commit -m "$*"
  fi
  git push origin "$branch"
}

gpull() {
  branch=$(git rev-parse --abbrev-ref HEAD)
  git pull origin "$branch"
}

# Create and clone a new GitHub repository
gn() {
  gh repo create $1 --private
  git clone https://github.com/$1.git
  v
}

# Mount/unmount a disk image
ones() {
  local VOLUME="/Volumes/new-ones"
  local DMG_PATH="/Users/fox/notes/new-ones.dmg"
  if [ -d "$VOLUME" ]; then
    echo "Unmounting..."
    cd
    hdiutil detach "$VOLUME" -force
  else
    echo "Mounting..."
    hdiutil attach "$DMG_PATH"
    cd /Volumes/new-ones
  fi
  if [ $? -eq 0 ]; then
    echo "Operation completed successfully."
  else
    echo "Operation failed."
    return 1
  fi
}

alias n='cd ~/notes && nvim .'

# Neovim shortcut
alias vim='nvim'
v() {
  if (( $# == 0 )); then
    nvim ./
  elif [[ $# = 1 ]]; then
    nvim ./$1
  fi
}

# ===== Environment Variables =====
export FZF_DEFAULT_COMMAND='rg --files'
export SSH_KEY_PATH="~/.ssh/server"
export EDITOR=nvim

# ===== Python Path =====
# Setting PATH for Python 3.12
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH

# ===== Cleanup =====
# Unmount the 'new-ones' volume if it's mounted
if [ -d "/Volumes/new-ones" ]; then
  echo "Unmounting..."
  hdiutil detach "/Volumes/new-ones" -force
fi

# ===== History Search Configuration =====
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search

# bun completions
[ -s "/Users/fox/.bun/_bun" ] && source "/Users/fox/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
