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
mkdir -p ~/.SpaceVim.d

# Setup TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup symlinks
ln -sf "$(pwd)/dotfiles/git/.gitconfig" ~/.gitconfig
ln -sf "$(pwd)/dotfiles/git/.gitignore" ~/.gitignore
ln -sf "$(pwd)/dotfiles/spacevim/init.toml" ~/.SpaceVim.d/init.toml
ln -sf "$(pwd)/dotfiles/starship/starship.toml" ~/.config/starship.toml
ln -sf "$(pwd)/dotfiles/.tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/dotfiles/.zshrc" ~/.zshrc
mkdir -p ~/.config/lsd
ln -sf "$(pwd)/dotfiles/lsd/config.yaml" ~/.config/lsd/config.yaml