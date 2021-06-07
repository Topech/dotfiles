#!/bin/bash

trap 'exit 130' INT


OS=$(./src/detectOperatingSystem.sh)
echo "Detected $OS!"

case "$OS" in
	"Fedora")
		CLI_PKG_MAN='dnf'
		sudo dnf install tlp tlp-rdw powertop
		for serv in tlp tlp powertop; do
			sudo systemctl start "$serv.service"
			sudo systemctl enable "$serv.service"
		done
		;;
	"Ubuntu")
		CLI_PKG_MAN='apt'
		sudo apt install flatpak
		sudo apt install gnome-software-plugin-flatpak
		flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
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
	flatpak install flathub com.bitwarden.desktop com.visualstudio.code org.signal.Signal com.spotify.Client -y

	echo "----- herbstluftwm installs  -----"
	sudo "$CLI_PKG_MAN" install plank xfce4-terminal dmenu feh arandr compton i3lock
fi

# install source programs
## TODO: Create directory for 
# - polybar

# Set Up Neovim
echo "---- set up neovim ---"
NVIM_DIR="$HOME/.config/nvim"
if [ ! -d  "$NVIM_DIR" ] ; then
    echo "No Neovim config folder detected. Making now..."
    mkdir "$NVIM_DIR"
    # install vim-plug for neovim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # install vim-openscad
    git clone https://github.com/sirtaj/vim-openscad.git "$HOME/Developer/repos/"
    SUBDIRS="syntax ftplugin ftdetect"
    for S in $SUBDIRS; do
        mkdir "$NVIM_DIR/$S";
        # link all openscad files from git
        ln -s "$HOME/Developer/repos/vim-openscad/$S/openscad.vim" "$NVIM_DIR/$S/openscad.vim";
    done;

    nvim +'PlugInstall' +qa --headless
fi

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

git config --global init.defaultBranch 'main'

git config --global alias.s 'status'
git config --global alias.l 'log --oneline'
git config --global alias.ll 'log'
git config --global alias.lf 'log --oneline --names-only'
git config --global alias.g "log  --graph  '--pretty=format:%C(auto)%h <%aN> %d %C(dim normal)(%cr)%Creset%n %s%n'"
git config --global alias.ga 'g --all'
git config --global alias.gf 'g --name-status'

# Reminders
echo "----- reminders  -----"
echo " * set up factory in /etc/hosts and ssh key"
echo " * source .profile and other files"


