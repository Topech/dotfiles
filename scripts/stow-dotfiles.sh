#!/usr/bin/env bash

SCRIPT_PATH=$( dirname -- "$0" )
DOTFILE_PATH="$( dirname -- "$SCRIPT_PATH" )/dotfiles"


## WAIT we can just gitignore soft linked files we don't want to push
# mkdir -p ~/.config/opencode
# stow -t ~/.config/opencode/ -d "${DOTFILE_PATH}/dot-config/" -v --dotfiles --stow opencode --no-folding  $@

stow -t ~/ -d "${DOTFILE_PATH}"/ --dotfiles -v --stow . $@
