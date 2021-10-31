# Path to your oh-my-zsh installation.
export ZSH="/Users/mog/.oh-my-zsh"

export AWS_PAGER=""
export BAT_PAGER="less -RF"
export HISTCONTROL="ignoreboth"

plugins=(
  aws
  docker
  git
  kubectl
  osx
  spotify
  httpie
  tmux
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $(which assume-role)

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

alias k="kubectl"
alias ls="exa"
alias ll="ls -lah"
alias wget="wget --no-hsts"

eval "$(starship init zsh)"
