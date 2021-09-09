#!/bin/bash

trap 'exit 130' INT


OS=$(./detect_OS.sh)
echo "Detected $OS!"

case "$OS" in
	"Fedora")
		CLI_PKG_MAN='dnf'
		;;
	"Ubuntu")
		CLI_PKG_MAN='apt'
		sudo apt install flatpak
		sudo apt install gnome-software-plugin-flatpak
		sudo apt install ssh
		flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
		;;
    "Linux Mint")
        CLI_PKG_MAN='apt'
        OS="Ubuntu"  # all other commands are just ubuntu
        ;;
	"Mac")
		CLI_PKG_MAN='brew'
		;;
esac

# set up directories
echo "----- create directories -----"
mkdir -p "$HOME/Repos" "$HOME/3dPrints"




# install programs
echo "----- cli installs  -----"
sudo "$CLI_PKG_MAN" install git neovim

if [ "$OS" != "Mac" ]; then
	echo "----- desktop installs -----"
	flatpak install flathub com.bitwarden.desktop org.signal.Signal com.spotify.Client -y

	# echo "----- herbstluftwm installs  -----"
	# sudo "$CLI_PKG_MAN" install plank xfce4-terminal dmenu feh arandr compton i3lock
else
    brew install bitwarden signal spotify
fi


# Set Up Neovim
echo "---- set up neovim ---"
NVIM_DIR="$HOME/.config/nvim"
if [ ! -d  "$NVIM_DIR" ] ; then
    echo "No Neovim config folder detected. Making now..."
    mkdir "$NVIM_DIR"
    # install vim-plug for neovim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    nvim +'PlugInstall' +qa --headless
fi

# configure dotfiles into system
echo "----- dotfiles  -----"
source soft_linker.sh

pushd ..
TARGET_DIR="$HOME"
DOTFILES=".bashrc .bash_aliases .profile .vimrc .zshrc"
link_dotfiles "$TARGET_DIR" "$DOTFILES"


TARGET_DIR="$HOME/.config"
DOTFILES="herbstluftwm Xmodmap nvim/init.vim"
link_dotfiles "$TARGET_DIR" "$DOTFILES"
popd 

# ssh keygen
echo "----- ssh-keygen  -----"
if [ ! -f "$HOME/.ssh/id_rsa" ] ; then
	ssh-keygen -b 4096 -t rsa
	chmod 400 "$HOME/.ssh/id_rsa*"
else
	echo 'key already generated'
fi


# Git setup
echo "----- git setup -----"
read -rp 'Git username: ' GIT_USERNAME
read -rp 'Git email: ' GIT_EMAIL

git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_EMAIL"

git config --global core.editor "nvim"

git config --global init.defaultBranch 'main'

git config --global alias.s 'status'
git config --global alias.l 'log --oneline'
git config --global alias.ll 'log'
git config --global alias.lf 'log --oneline --name-only'
git config --global alias.g "log  --graph  '--pretty=format:%C(auto)%h <%aN> %d %C(dim normal)(%cr)%Creset%n %s%n'"
git config --global alias.ga 'g --all'
git config --global alias.gf 'g --name-status'
git config --global advice.pushNonFastForward false
git config --global advice.statusHints false
git config --global advice.commitBeforeMerge false
git config --global advice.resolveConflict false

# Reminders
echo "----- reminders  -----"
echo " * set up factory in /etc/hosts and ssh key"
echo " * source .profile and other files"


