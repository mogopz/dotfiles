autoload -Uz compinit
compinit

# Map home + end keys
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# Set word boundaries
autoload -U select-word-style
select-word-style bash

# History configuration
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Enable history search with up/down arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

export AWS_PAGER=""
export ARGOCD_OPTS="--grpc-web"
export BAT_PAGER=""
export BAT_THEME="Catppuccin Mocha"
export EDITOR="nvim"
export KUBE_EDITOR="nvim"
export GOSS_PATH="/usr/local/bin/goss"
export PATH="${PATH}:$(go env GOPATH)/bin"
export KUBECTL_EXTERNAL_DIFF="delta --paging never"

# Coloured man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/catppuccin-mocha-zsh-syntax-highlighting.zsh
source <(fzf --zsh)

alias gaa="git add --all"
alias gcmsg="git commit --message"
alias ggp="git push"
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias k="kubecolor"
alias kctx="kubectx"
alias kns="kubens"
alias ll="ls -lah"
alias ls="lsd"
alias vim="nvim"

compdef kubecolor=kubectl

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"
