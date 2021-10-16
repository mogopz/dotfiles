# Path to your oh-my-zsh installation.
export ZSH=/Users/mog/.oh-my-zsh
export DOCKER_BUILDKIT=1
export AWS_PAGER=""

ZSH_THEME="spaceship"

plugins=(
  aws
  docker
  git
  kubectl
  osx
  httpie
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source ${ZSH}/oh-my-zsh.sh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(which assume-role)

alias k="kubectl"
alias ll="ls -lah"
alias wget='wget --no-hsts'
alias pip='pip3'
