#!/usr/bin/env bash

set -eo pipefail

# Install dependencies
xcode-select --install

# Setup Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew bundle --file ~/dotfiles/Brewfile

# Setup TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim

# Setup Zsh highlighting
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git catppuccin-zsh-syntax-highlighting
cp -v catppuccin-zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/catppuccin-mocha-zsh-syntax-highlighting.zsh
rm -rf catppuccin-zsh-syntax-highlighting

# Setup symlinks
stow -v -d ~/dotfiles -t ~ ghostty rectangle git lsd nvim rectangle starship tmux vscode zsh