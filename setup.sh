#!/bin/bash

trap 'exit 130' INT


OS=$(./src/detectOperatingSystem.sh)
echo "Detected $OS!"

case "$OS" in
	"Fedora")
		CLI_PKG_MAN='dnf'
		;;
	"Ubuntu")
		CLI_PKG_MAN='apt'
		sudo apt install flatpak
		;;
	"Mac")
		CLI_PKG_MAN='brew'
		;;
esac

# set up directories
echo "----- create directories -----"
mkdir -p "$HOME/Developer/repos" "$HOME/3dPrints"




# install programs
echo "----- cli installs  -----"
sudo "$CLI_PKG_MAN" install git vim ssh zsh xkbset neovim

if [ "$OS" != "Mac" ]; then
	echo "----- desktop installs -----"
	flatpak install flathub com.bitwarden.desktop
	flatpak install flathub com.visualstudio.code

	echo "----- herbstluftwm installs  -----"
	sudo "$CLI_PKG_MAN" dnf install plank xfce4-terminal dmenu feh arandr compton i3lock
fi

# install source programs
## TODO: Create directory for 
# - polybar

# configure dotfiles into system
echo "----- dotfiles  -----"
chmod +x src/lndotfiles.sh
./src/lndotfiles.sh

# ssh keygen
echo "----- ssh-keygen  -----"
if [ ! -f "$HOME/.ssh/id_rsa" ] ; then
	ssh-keygen
	chmod 400 "$HOME/.ssh/id_rsa*"
else
	echo 'key already generated'
fi


# Git setup
echo "----- git setup -----"
read -p 'Git username: ' GIT_USERNAME
read -p 'Git email: ' GIT_EMAIL

git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

git config --global core.editor "nvim"

git config --global alias.s 'status'
git config --global alias.l 'log --oneline'
git config --global alias.ll 'log'
git config --global alias.lf 'log --oneline --names-only'
git config --global alias.g 'log --graph --oneline'
git config --global alias.ga 'log --graph --oneline --all'

# Reminders
echo "----- reminders  -----"
echo " * set up factory in /etc/hosts and ssh key"
echo " * source .profile and other files"


