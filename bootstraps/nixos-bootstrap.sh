#!/usr/bin/env bash
set -e


nix-env --install git



BOOTSTRAP_DIR="/tmp/dotfiles-bootstap"

mkdir "$BOOTSTRAP_DIR"


DOTFILES_REPO_URL="https://github.com/topech/dotfiles"

cd "$BOOTSTRAP_DIR"
git clone "$DOTFILES_REPO_URL"
