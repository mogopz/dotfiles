typeset -U PATH path FPATH fpath

autoload -Uz compinit
zmodload zsh/complist
compinit

setopt always_to_end
setopt complete_in_word
setopt interactive_comments
unsetopt flow_control

# Keep ZLE in Emacs mode even though EDITOR is nvim.
bindkey -e

# Map home + end keys
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# Delete previous word across terminals that encode Option+Backspace differently.
bindkey "^W" backward-kill-word
bindkey "^[^?" backward-kill-word
bindkey "^[^H" backward-kill-word

# Set word boundaries
autoload -U select-word-style
select-word-style bash

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=120000
SAVEHIST=100000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# Enable history search with up/down arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Completion configuration
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'

eval "$(mise activate zsh)"

export AWS_PAGER=""
export ARGOCD_OPTS="--grpc-web"
export BAT_PAGER=""
export BAT_THEME="Catppuccin Mocha"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"
export EDITOR="nvim"
export VISUAL="${EDITOR}"
export KUBE_EDITOR="${EDITOR}"
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

source <(fzf --zsh)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/catppuccin-mocha-zsh-syntax-highlighting.zsh

ssm() {
  local instance_ids selection
  local -a region

  [[ -n "${1}" ]] && region=(--region "${1}")

  instance_ids="$(
    aws "${region[@]}" ssm describe-instance-information \
      --filters \
        "Key=PingStatus,Values=Online" \
        "Key=ResourceType,Values=EC2Instance" \
      --query "InstanceInformationList[].InstanceId" \
      --output json
  )" || return

  selection="$(
    aws "${region[@]}" ec2 describe-instances --output json |
      jq -r --argjson instance_ids "${instance_ids}" '
        .Reservations[].Instances[]
        | select(.InstanceId as $id | $instance_ids | index($id))
        | [([.Tags[]? | select(.Key == "Name") | .Value][0] // "(unnamed)"), .InstanceId]
        | @tsv
      ' |
      fzf \
        --header=$'NAME\tINSTANCE ID' \
        --prompt="SSM instance> "
  )" || return

  aws "${region[@]}" ssm start-session --target "${selection##*$'\t'}"
}

alias cat="bat --plain"
alias codexq="codex --profile quick"
alias gaa="git add --all"
alias gcmsg="git commit --message"
alias ggp="git push"
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias k="kubecolor"
alias kctx="kubectx"
alias kns="kubens"
alias ll="ls -lah"
alias ls="lsd"
alias ofd="open ."
alias todo="rg \"TODO\" --colors match:fg:yellow --colors match:style:bold"
alias vim="nvim"

compdef kubecolor=kubectl
eval "$(starship init zsh)"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
