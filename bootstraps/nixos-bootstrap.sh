#!/usr/bin/env bash

set -e  # set bash to exit on fail
set -x  # set bash to echo each command run



BOOTSTRAP_DIR="/tmp/dotfiles-bootstrap"

mkdir -p "$BOOTSTRAP_DIR"  # NOTE: -p to continue even if already exists



REPO_OWNER=topech
REPO=dotfiles
REPO_BRANCH=master

DOTFILES_REPO_URL="https://github.com/${REPO_OWNER}/${REPO}"

cd "$BOOTSTRAP_DIR"
nix-shell git --run "git clone --depth 1 --branch ${REPO_BRANCH} ${DOTFILES_REPO_URL}"



echo 'System bootstrapped with temporary dotfiles repo at:'
printf "\t${BOOTSTRAP_DIR}/${REPO}"

