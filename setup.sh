#!/usr/bin/env bash

set -eo pipefail

# Setup Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew bundle

# Setup Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Setup SpaceVim
curl -sLf https://spacevim.org/install.sh | bash

# Setup TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup symlinks
ln -s "$(pwd)/dotfiles/.tmux.conf" ~/.tmux.conf