export ZSH="/Users/mog/.oh-my-zsh"

export AWS_PAGER=""
export HISTCONTROL="ignoreboth"

export EDITOR=nvim

# coloured man pages
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

source $ZSH/oh-my-zsh.sh
source $(which assume-role)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

alias ls="exa"
alias ll="ls -lah"
alias vim="nvim"
alias wget="wget --no-hsts"

eval "$(starship init zsh)"
