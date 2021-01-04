#!/bin/bash


# install programs
echo "----- installs  -----"
sudo apt install git vim plank ssh zsh
sudo snap install spotify bitwarden

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
echo " * set up uServ in /etc/hosts and ssh key"
echo " * source .profile and other files"
