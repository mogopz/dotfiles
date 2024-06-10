export ZSH="/Users/mog/.oh-my-zsh"
export PATH="${PATH}:$(go env GOPATH)/bin"

export AWS_PAGER=""
export ARGOCD_OPTS="--grpc-web"
export HISTCONTROL="ignoreboth"
export KUBECTL_EXTERNAL_DIFF="delta --paging never"
export KUBE_EDITOR="nvim"

# Coloured man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

plugins=(
  aws
  git
  kubectl
  macos
  httpie
  z
)

source "${ZSH}/oh-my-zsh.sh"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source <(switcher init zsh)

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias k="kubecolor"
alias kctx="switch"
alias kns="switch ns"
alias ll="ls -lah"
alias ls="lsd"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias vim="nvim"
alias wget="wget --no-hsts"

compdef kubecolor=kubectl

eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"
