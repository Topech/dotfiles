#!/bin/bash



# set up directories
echo "----- create directories -----"
mkdir -p "$HOME/Developer/repos" "$HOME/3dPrints"

# install programs
echo "----- ubuntu generic installs  -----"
sudo apt install git vim ssh zsh xkbset neovim

echo "----- ubuntu desktop installs  -----"
sudo apt install terminology
sudo snap install spotify bitwarden

echo "----- herbstluftwm installs  -----"
sudo apt install plank xfce4-terminal dmenu feh arandr compton polybar

# install source programs
## TODO: Create directory for 
# - polybar

# configure dotfiles into system
echo "----- dotfiles  -----"
chmod +x lndotfiles.sh
./lndotfiles.sh

# ssh keygen
echo "----- ssh-keygen  -----"
if [ ! -f "$HOME/.ssh/id_rsa" ] ; then
	ssh-keygen
	chmod 400 "$HOME/.ssh/id_rsa*"
else
	echo 'key already generated'
fi

# Reminders
echo "----- reminders  -----"
echo " * set up factory in /etc/hosts and ssh key"
echo " * source .profile and other files"
