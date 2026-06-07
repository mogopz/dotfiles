#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Install dependencies
xcode-select --install

# Setup Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew doctor
brew bundle --file "${DOTFILES_DIR}/Brewfile"

# Prevent Stow from folding ~/.codex into a repo symlink.
mkdir -p "${HOME}/.codex"

# Setup BAT theme
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

# Setup LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim

# Setup Zsh highlighting
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git catppuccin-zsh-syntax-highlighting
cp -v catppuccin-zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/catppuccin-mocha-zsh-syntax-highlighting.zsh
rm -rf catppuccin-zsh-syntax-highlighting

# Setup symlinks
stow -v -d "${DOTFILES_DIR}" -t "${HOME}" codex ghostty git lsd nvim rectangle starship zed zsh
