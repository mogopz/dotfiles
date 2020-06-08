# Path to your oh-my-zsh installation
export ZSH=/Users/mog/.oh-my-zsh

export GOPATH=$HOME/go/bin
export PATH=/usr/local/sbin:$PATH:$GOPATH

export DOCKER_BUILDKIT=1
export AWS_PAGER=""

export ZSH_TMUX_AUTOSTART=true

ZSH_THEME="spaceship"

export UPDATE_ZSH_DAYS=10

plugins=(
  aws
  git
  osx
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ll="ls -lah"
alias wget="wget --no-hsts"
alias ping="prettyping"