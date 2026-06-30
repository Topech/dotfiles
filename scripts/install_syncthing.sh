#!/bin/bash

trap 'exit 130' INT


if [[ $EUID -eq 0 ]]; then
    # detected script running at root
    echo "Please don't run this script as root"
    exit 1
fi


OS=$(./setup/detect_OS.sh)
if [ "$OS" == "Linux Mint" ]; then OS="Ubuntu"; fi


if ! command -v syncthing &> /dev/null 
then       
    case "$OS" in
        "Ubuntu")
            sudo apt-get install curl
            curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
            echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
            sudo apt-get install apt-transport-https
            sudo apt-get update
            sudo apt-get install syncthing

            CURRENT_USER="$USER"
            sudo systemctl enable "syncthing@$CURRENT_USER.service"
            sudo systemctl start "syncthing@$CURRENT_USER.service"
            ;;
        "Mac")
            brew install syncthing
            brew services syncthing start
            ;;
    esac
fi
