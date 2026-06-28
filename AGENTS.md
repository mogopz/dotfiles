# Repository Guidelines

## Project Structure & Module Organization

This repository stores personal macOS dotfiles managed by `mise`. The main control file is `mise.toml`, which defines tool versions, Homebrew packages, macOS defaults, bootstrap hooks, and the dotfile symlink map. Editable configuration lives under `.config/`, including `zsh`, `git`, `ghostty`, `lsd`, `nvim`, `rectangle`, `starship`, and `zed` settings. Static assets are split between `img/` for README screenshots and `wallpapers/` for desktop backgrounds.

## Build, Test, and Development Commands

- `mise trust`: trust this repository's `mise.toml` before running configured tasks.
- `mise bootstrap --yes --force-dotfiles --skip packages,tools,task`: refresh dotfile links without installing packages or tools.
- `mise bootstrap --yes`: run the full bootstrap flow from the README, including package/tool setup.
- `mise tasks`: list available local tasks; currently this exposes `bootstrap` for supplemental theme assets and cask installation.

Run install-oriented commands carefully because they can change Homebrew packages, casks, macOS settings, and files in `~/.config`.

## Coding Style & Naming Conventions

Follow `.editorconfig`: UTF-8, LF endings, two-space indentation, final newline, trimmed trailing whitespace, and 120-character maximum lines. Keep TOML, YAML, JSON, Lua, and shell snippets formatted consistently with neighboring files. Add new managed dotfiles under `.config/<tool>/...`, then map them in `[dotfiles]` using the target path as the key and repository path as the value.

## Testing Guidelines

There is no formal automated test suite. Validate changes by running the narrowest safe bootstrap command first, usually `mise bootstrap --yes --force-dotfiles --skip packages,tools,task`, then inspect the affected generated symlink or application config. For shell edits, prefer syntax checks such as `zsh -n .config/zsh/.zshrc` when applicable.

## Commit & Pull Request Guidelines

Recent history uses short Conventional Commit-style subjects such as `feat: migrate from stow to mise` and `fix: use mise`. Keep commits focused on one tool or behavior. Pull requests should describe the affected dotfiles, list validation commands run, call out package or macOS setting changes, and include screenshots for visible terminal, editor, or wallpaper updates.

## Security & Configuration Tips

Do not commit secrets, machine-specific credentials, or private tokens. Keep local exclusions in `.config/git/ignore` or `.gitignore` as appropriate, and prefer documenting required credentials over storing them in tracked config files.
