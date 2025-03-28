#!/usr/bin/env bash

set -eo pipefail

# Setup Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew bundle

# Setup Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Setup TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup Neovim
git clone https://github.com/LazyVim/starter ~/.config/nvim
cat <<EOF > ~/.config/nvim/lua/plugins/theme.lua
return {
	{ "Mofiqul/dracula.nvim" },

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "dracula",
		},
	},
}
EOF

# Setup symlinks
mkdir -p ~/.config/lsd
ln -sf "$(pwd)/dotfiles/ghostty/config.toml" "${HOME}/Library/Application\ Support/com.mitchellh.ghostty/config"
ln -sf "$(pwd)/dotfiles/git/.gitconfig" ~/.gitconfig
ln -sf "$(pwd)/dotfiles/git/.gitignore" ~/.gitignore
ln -sf "$(pwd)/dotfiles/lsd/config.yaml" ~/.config/lsd/config.yaml
ln -sf "$(pwd)/dotfiles/starship/starship.toml" ~/.config/starship.toml
ln -sf "$(pwd)/dotfiles/.tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/dotfiles/.zshrc" ~/.zshrc