#!/bin/bash

trap 'exit 130' INT


if [[ $EUID -eq 0 ]]; then
    # detected script running at root
    echo "Please don't run this script as root"
    exit 1
fi


OS=$(./setup/detect_OS.sh)



if ! command -v brave-browser &> /dev/null 
then       
    case "$OS" in
        "Fedora")
            sudo dnf install dnf-plugins-core
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo dnf install brave-browser
            ;;
        "Ubuntu")
            sudo apt install apt-transport-https curl
            sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
                https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

            echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] \
                https://brave-browser-apt-release.s3.brave.com/ stable main" \
                | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
            sudo apt update
            sudo apt install brave-browser
            ;;
        "Mac")
            brew install brave-browser
            ;;
    esac
fi
