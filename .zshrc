autoload -Uz compinit
compinit

export AWS_PAGER=""
export ARGOCD_OPTS="--grpc-web"
export HISTCONTROL="ignoreboth"
export BAT_THEME="Catppuccin Mocha"
export EDITOR="nvim"
export KUBE_EDITOR="nvim"
export KUBECTL_EXTERNAL_DIFF="delta --paging never"
export SUDO_EDITOR="${EDITOR}"
export WORDCHARS=${WORDCHARS//-/}

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
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
source <(fzf --zsh)

alias k="kubecolor"
alias kns="kubens"
alias kctx="kubectx"
alias ll="ls -lah"
alias ls="lsd"
alias vim="nvim"

alias gaa="git add --all"
alias gcmsg="git commit --message"
alias ggp="git push"

alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'


compdef kubecolor=kubectl

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"
