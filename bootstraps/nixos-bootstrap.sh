#!/usr/bin/env bash

set -e  # set bash to exit on fail
set -x  # set bash to echo each command run


nix-env --install git



BOOTSTRAP_DIR="/tmp/dotfiles-bootstap"

mkdir "$BOOTSTRAP_DIR"



REPO_OWNER=topech
REPO=dotfiles
REPO_BRANCH=master

DOTFILES_REPO_URL="https://github.com/${REPO_OWNER}/${REPO}"


cd "$BOOTSTRAP_DIR"
git clone  \
	--depth 1  \
	--branch "${REPO_BRANCH}"  \
	${DOTFILES_REPO_URL}"


echo 'System bootstrapped with temporary dotfiles repo at:'
echo '\t${BOOTSTRAP_DIR}/${REPO}

