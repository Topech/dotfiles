#!/bin/bash

trap 'exit 130' INT


if [[ $EUID -eq 0 ]]; then
    # detected script running at root
    echo "Please don't run this script as root"
    exit 1
fi


OS=$(./detect_OS.sh)

mkdir ~/Repos/ENCO

# setup ENCO git config
read -rp 'ENCO username: ' GIT_USER
read -rp 'ENCO email: ' GIT_EMAIL
git config --global 'includeIf.gitdir:~/Repos/ENCO/.user' "$GIT_USER"
git config --global 'includeIf.gitdir:~/Repos/ENCO/.email' "$GIT_EMAIL"



case "$OS" in
	"Fedora")
        # remove old docker
        sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
        # set up repo
        sudo dnf -y install dnf-plugins-core
        sudo dnf config-manager \
            --add-repo \
            https://download.docker.com/linux/fedora/docker-ce.repo
        # install docker
        sudo dnf install docker-ce docker-ce-cli containerd.io
        # start docker
        sudo systemctl start docker
        # auto start docker on boot
        sudo systemctl enable docker.service
        sudo systemctl enable containerd.service
		;;


	"Ubuntu")
        ## remove old docker
        sudo apt-get remove docker docker-engine docker.io containerd runc
        sudo apt-get update

        # set up apt repo
        sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            lsb-release
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o \
            /usr/share/keyrings/docker-archive-keyring.gpg

        echo \
            "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
            https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        # install
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io
		;;
esac

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo curl \
    -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose \
    -o /etc/bash_completion.d/docker-compose


# add docker group (no sudo needed)
sudo groupadd docker
sudo usermod -aG docker $USER

echo 'restart for docker without sudo'

