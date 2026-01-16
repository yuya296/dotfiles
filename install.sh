#!/usr/bin/env bash
set -e

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

links=(
  "$DOTFILES_DIR/.zshrc:$HOME/.zshrc"
  "$DOTFILES_DIR/.zprofile:$HOME/.zprofile"
  "$DOTFILES_DIR/.zshenv:$HOME/.zshenv"
)

for pair in "${links[@]}"; do
  src="${pair%%:*}"
  dst="${pair#*:}"

  mkdir -p "$(dirname "$dst")"
  ln -snf "$src" "$dst"
done

echo "linked."

