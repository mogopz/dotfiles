#!/usr/bin/env bash

set -eo pipefail

# Setup Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew bundle --file "${HOME}/dotfiles/Brewfile"

# Setup TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup Neovim
git clone https://github.com/LazyVim/starter ~/.config/nvim
cat <<EOF > ~/.config/nvim/lua/plugins/theme.lua
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    }
  }
}
EOF

# Setup Zsh highlighting
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git catppuccin-zsh-syntax-highlighting
cp -v catppuccin-zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/catppuccin-mocha-zsh-syntax-highlighting.zsh
rm -rf catppuccin-zsh-syntax-highlighting

# Setup symlinks
mkdir -p ~/.config/lsd
ln -sf "$(pwd)/dotfiles/ghostty/config.toml" "${HOME}/Library/Application Support/com.mitchellh.ghostty/config"
ln -sf "$(pwd)/dotfiles/git/.gitconfig" ~/.gitconfig
ln -sf "$(pwd)/dotfiles/git/.gitignore" ~/.gitignore
ln -sf "$(pwd)/dotfiles/lsd/config.yaml" ~/.config/lsd/config.yaml
ln -sf "$(pwd)/dotfiles/lsd/colors.yaml" ~/.config/lsd/colors.yaml
ln -sf "$(pwd)/dotfiles/starship/starship.toml" ~/.config/starship.toml
ln -sf "$(pwd)/dotfiles/.tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/dotfiles/.zshrc" ~/.zshrc